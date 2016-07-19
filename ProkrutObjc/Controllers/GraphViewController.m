//
//  GraphViewController.m
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 23/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "GraphViewController.h"

#import "OnDateUserStatisctics.h"
#import "UserStatistics.h"
#import "StatisticsService.h"

#import <Parse/Parse.h>
#import <CorePlot/ios/CorePlot.h>

@class GraphStatisticsModel;

typedef NSNumber *(^StatisticPropertyBlock)(OnDateUserStatisctics *stat);

@interface GraphStatisticsModel : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *maxYValue;
@property (strong, nonatomic) NSNumber *minYValue;
@property (assign, nonatomic) CGFloat step;
@property (copy, nonatomic) StatisticPropertyBlock propertyBlock;

+ (instancetype)winrateModel;
+ (instancetype)pointsPerMatchModel;

@end

@implementation GraphStatisticsModel

+ (instancetype)winrateModel {
    GraphStatisticsModel *model = [GraphStatisticsModel new];
    model.title = @"Винрейт";
    model.maxYValue = @1.0;
    model.minYValue = @(-0.2);
    model.step = 10.0f;
    model.propertyBlock = ^NSNumber *(OnDateUserStatisctics *stat) {
        return @(stat.winrate);
    };
    return model;
}

+ (instancetype)pointsPerMatchModel {
    GraphStatisticsModel *model = [GraphStatisticsModel new];
    model.title = @"Очки за матч";
    model.maxYValue = @12;
    model.minYValue = @(-5);
    model.step = 10.0f;
    model.propertyBlock = ^NSNumber *(OnDateUserStatisctics *stat) {
        return @(stat.pointsPerMatch);
    };
    return model;
}

+ (instancetype)wins:(NSUInteger)maxCount {
    GraphStatisticsModel *model = [GraphStatisticsModel new];
    model.title = @"Победы";
    model.maxYValue = @(maxCount);
    model.minYValue = @(-5);
    model.step = 10.0f;
    model.propertyBlock = ^NSNumber *(OnDateUserStatisctics *stat) {
        return @(stat.wins);
    };
    return model;
}

+ (instancetype)looses:(NSUInteger)maxCount {
    GraphStatisticsModel *model = [GraphStatisticsModel new];
    model.title = @"Поражения";
    model.maxYValue = @(maxCount);
    model.minYValue = @(-5);
    model.step = 10.0f;
    model.propertyBlock = ^NSNumber *(OnDateUserStatisctics *stat) {
        return @(stat.looses);
    };
    return model;
}

+ (instancetype)points:(NSUInteger)maxCount {
    GraphStatisticsModel *model = [GraphStatisticsModel new];
    model.title = @"Очки";
    model.maxYValue = @(maxCount);
    model.minYValue = @(-5);
    model.step = 10.0f;
    model.propertyBlock = ^NSNumber *(OnDateUserStatisctics *stat) {
        return @(stat.points);
    };
    return model;
}

+ (instancetype)stars:(NSUInteger)maxCount {
    GraphStatisticsModel *model = [GraphStatisticsModel new];
    model.title = @"Звезды";
    model.maxYValue = @(maxCount);
    model.minYValue = @(-1);
    model.step = 10.0f;
    model.propertyBlock = ^NSNumber *(OnDateUserStatisctics *stat) {
        return @(stat.stars);
    };
    return model;
}

+ (instancetype)antistars:(NSUInteger)maxCount {
    GraphStatisticsModel *model = [GraphStatisticsModel new];
    model.title = @"Антивезды";
    model.maxYValue = @(maxCount);
    model.minYValue = @(-1);
    model.step = 10.0f;
    model.propertyBlock = ^NSNumber *(OnDateUserStatisctics *stat) {
        return @(stat.antiStars);
    };
    return model;
}

@end

@interface GraphViewController () <CPTPlotDataSource, CPTPlotSpaceDelegate>

@property (nonatomic, strong) NSArray <UserStatistics *>*userStatistics;
@property (nonatomic, strong) StatisticsService *statisticsService;

@property (nonatomic, strong) NSArray *dates;
@property (nonatomic, strong) GraphStatisticsModel *selectedGraphModel;

@end

@implementation GraphViewController

- (StatisticsService *)statisticsService {
    if (!_statisticsService) {
        _statisticsService = [StatisticsService new];
    }
    return _statisticsService;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedGraphModel = [GraphStatisticsModel winrateModel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    PFQuery *query = [PFUser query];
    __weak typeof(self)weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects && !error) {
            __block NSArray *users = objects;
            PFQuery *query = [PFQuery queryWithClassName:@"Match"];
            query.limit = 1000;
            
            NSString *seasonId = [[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentSeasonId"];
            if (!seasonId) {
                return;
            }
            
            [query whereKey:@"seasonId" equalTo:seasonId];
            [query addAscendingOrder:@"createdDate"];
            
            [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                __strong typeof(self)self = weakSelf;
                if (objects.count > 0) {
                    self.userStatistics = [self.statisticsService obtainStatisticsForMathes:objects
                                                                                      users:users];
                    [self determineSeasonDates];
                    [self setupGraphAppearance];
                    [self setupUserPlots];
                    [self setupLegend];
                    [self setupAxis];
                } else {
                    self.userStatistics = nil;
                    [self determineSeasonDates];
                    [self setupGraphAppearance];
                    [self setupUserPlots];
                    [self setupLegend];
                    [self setupAxis];
                }
            }];
        }
    }];
    
}

#pragma mark - Настройка графика

- (void)setupGraphAppearance {
    self.hostView.allowPinchScaling = YES;
    
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
    [graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];
    self.hostView.hostedGraph = graph;
    
    CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
    titleStyle.color = [CPTColor whiteColor];
    titleStyle.fontName = @"Helvetica-Bold";
    titleStyle.fontSize = 16.0f;
    
    graph.titleTextStyle = titleStyle;
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph.titleDisplacement = CGPointMake(0.0f, 10.0f);
    
    graph.plotAreaFrame.borderLineStyle = nil;
    graph.paddingTop = 0;
    graph.paddingLeft = 0;
    graph.paddingRight = 0;
    graph.paddingBottom = 0;
    graph.cornerRadius = 0;
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
}

- (void)setupUserPlots {
    NSMutableArray *mutablePlots = [@[] mutableCopy];
    CPTGraph *graph = self.hostView.hostedGraph;
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.delegate = self;
    for (UserStatistics *user in self.userStatistics) {
        CPTScatterPlot *plot = [[CPTScatterPlot alloc] init];
        NSUInteger identifier = [self.userStatistics indexOfObject:user];
        
        plot.dataSource = self;
        plot.identifier = @(identifier);
        CPTColor *color = [self colorWithIdentifaer:identifier];
        [graph addPlot:plot toPlotSpace:plotSpace];
        
        CPTMutableLineStyle *lineStyle = [plot.dataLineStyle mutableCopy];
        lineStyle.lineWidth = 2.5;
        lineStyle.lineColor = color;
        plot.dataLineStyle = lineStyle;
        
        CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
        symbolLineStyle.lineColor = color;
        CPTPlotSymbol *symbol = [CPTPlotSymbol ellipsePlotSymbol];
        symbol.fill = [CPTFill fillWithColor:color];
        symbol.lineStyle = symbolLineStyle;
        symbol.size = CGSizeMake(6.0f, 6.0f);
        plot.plotSymbol = symbol;
        
        plot.title = user.user.username;
        
        [mutablePlots addObject:plot];
    }
    [plotSpace scaleToFitPlots:mutablePlots];
    
    plotSpace.globalXRange = [CPTPlotRange plotRangeWithLocation:@(-2) length:@(self.dates.count + 2)];
    plotSpace.globalYRange = [CPTPlotRange plotRangeWithLocation:self.selectedGraphModel.minYValue length:@([self.selectedGraphModel.maxYValue floatValue] + fabsf([self.selectedGraphModel.minYValue floatValue]))];
}

- (void)setupAxis {
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor whiteColor];
    axisTitleStyle.fontName = @"Helvetica-Bold";
    axisTitleStyle.fontSize = 12.0f;
    
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 2.0f;
    axisLineStyle.lineColor = [CPTColor whiteColor];
    
    CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
    axisTextStyle.color = [CPTColor whiteColor];
    axisTextStyle.fontName = @"Helvetica-Bold";
    axisTextStyle.fontSize = 11.0f;
    
    CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor whiteColor];
    tickLineStyle.lineWidth = 2.0f;
    
    CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor blackColor];
    tickLineStyle.lineWidth = 1.0f;
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
    CPTAxis *x = axisSet.xAxis;
    x.title = @"Дни";
    x.titleTextStyle = axisTitleStyle;
    x.titleOffset = 15.0f;
    x.axisLineStyle = axisLineStyle;
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    x.labelTextStyle = axisTextStyle;
    x.majorTickLineStyle = axisLineStyle;
    x.majorTickLength = 4.0f;
    x.tickDirection = CPTSignNegative;
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"DD.MM"];
    NSUInteger dateCount = self.dates.count;
    NSMutableSet *xLabels = [NSMutableSet setWithCapacity:dateCount];
    NSMutableSet *xLocations = [NSMutableSet setWithCapacity:dateCount];
    NSInteger i = 0;
    for (NSDate *date in self.dates) {
        CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[formatter stringFromDate:date] textStyle:x.labelTextStyle];
        CGFloat location = i++;
        label.tickLocation = @(location);
        label.offset = x.majorTickLength;
        if (label) {
            [xLabels addObject:label];
            [xLocations addObject:[NSNumber numberWithFloat:location]];
        }
    }
    x.axisLabels = xLabels;
    x.majorTickLocations = xLocations;
    
    CPTAxis *y = axisSet.yAxis;
    y.title = self.selectedGraphModel.title;
    y.titleTextStyle = axisTitleStyle;
    y.titleOffset = -20.0f;
    y.axisLineStyle = axisLineStyle;
    y.majorGridLineStyle = gridLineStyle;
    y.labelingPolicy = CPTAxisLabelingPolicyNone;
    y.labelTextStyle = axisTextStyle;
    y.majorTickLineStyle = axisLineStyle;
    y.majorTickLength = 8.0f;
    y.minorTickLength = 5.0f;
    y.tickDirection = CPTSignPositive;
    NSInteger majorIncrement = self.selectedGraphModel.step;
    NSInteger minorIncrement = self.selectedGraphModel.step / 10;
    CGFloat yMax = [self.selectedGraphModel.maxYValue floatValue];  // should determine dynamically based on max price
    NSMutableSet *yLabels = [NSMutableSet set];
    NSMutableSet *yMajorLocations = [NSMutableSet set];
    NSMutableSet *yMinorLocations = [NSMutableSet set];
    for (NSInteger j = minorIncrement; j <= yMax; j += minorIncrement) {
        NSUInteger mod = j % majorIncrement;
        if (mod == 0) {
            CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%zd", j] textStyle:y.labelTextStyle];
            label.tickLocation = @(j);
            label.offset = y.majorTickLength;
            if (label) {
                [yLabels addObject:label];
            }
            [yMajorLocations addObject:@(j)];
        } else {
            [yMinorLocations addObject:@(j)];
        }
    }
    y.axisLabels = yLabels;
    y.majorTickLocations = yMajorLocations;
    y.minorTickLocations = yMinorLocations;
}

- (void)setupLegend {
    CPTGraph *graph = self.hostView.hostedGraph;
    graph.legend = [CPTLegend legendWithGraph:graph];
    graph.legend.fill = [CPTFill fillWithColor:[CPTColor lightGrayColor]];
    graph.legend.cornerRadius = 5.0;
    graph.legend.numberOfRows = 4;
    graph.legend.swatchSize = CGSizeMake(10.0, 10.0);
    graph.legendAnchor = CPTRectAnchorBottom;
    graph.legendDisplacement = CGPointMake(0.0, 5.0);
}

#pragma mark - Методы CPTPlotDataSource

- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return self.dates.count;
}

- (id)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx {
    switch (fieldEnum) {
        case CPTScatterPlotFieldX:
            return @(idx);
        case CPTScatterPlotFieldY: {
            NSUInteger plotIndex = [(NSNumber *)plot.identifier integerValue];
            NSDate *date = self.dates[idx];
            OnDateUserStatisctics *dayStat = [self statisticForDate:date userIndex:plotIndex];
            
            return self.selectedGraphModel.propertyBlock(dayStat);
        }
    }
    
    return @0;
}

- (IBAction)didTapTypeButton:(id)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Типы графиков" message:@"Выберите тип графика" preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (GraphStatisticsModel *model in [self graphStatisticModels]) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:model.title
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           self.selectedGraphModel = model;
                                                           [self setupGraphAppearance];
                                                           [self setupUserPlots];
                                                           [self setupLegend];
                                                           [self setupAxis];
                                                           [self.hostView.hostedGraph reloadData];
                                                       }];
        [controller addAction:action];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }];
    [controller addAction:cancelAction];
    
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - Приватные методы

- (void)determineSeasonDates {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger comps = (NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear);
    NSMutableArray *mutableDates = [@[] mutableCopy];
    for (UserStatistics *stat in self.userStatistics) {
        for (OnDateUserStatisctics *onDateStat in stat.matchStatisticsArray) {
            NSDateComponents *dateComponents = [calendar components:comps
                                                           fromDate:onDateStat.dateStatistics];
            NSDate *date = [calendar dateFromComponents:dateComponents];
            if (![mutableDates containsObject:date]) {
                [mutableDates addObject:date];
            }
        }
    }
    self.dates = [[mutableDates copy] sortedArrayUsingSelector:@selector(compare:)];
}

- (OnDateUserStatisctics *)statisticForDate:(NSDate *)date userIndex:(NSUInteger)userIndex {
    UserStatistics *userStatistics = self.userStatistics[userIndex];
    
    NSUInteger lastAppropriateMatchIndex = 0;
    for (OnDateUserStatisctics *onDateStat in userStatistics.matchStatisticsArray) {
        if ([self compareDate:onDateStat.dateStatistics withDate:date] != NSOrderedDescending) {
            lastAppropriateMatchIndex = [userStatistics.matchStatisticsArray
                                         indexOfObject:onDateStat];
        }
    }
    if (userStatistics.matchStatisticsArray.count > lastAppropriateMatchIndex) {
        return userStatistics.matchStatisticsArray[lastAppropriateMatchIndex];
    } else {
        return nil;
    }
}

- (NSComparisonResult)compareDate:(NSDate *)date1 withDate:(NSDate *)date2 {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger comps = (NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear);
    
    NSDateComponents *date1Components = [calendar components:comps
                                                    fromDate:date1];
    NSDateComponents *date2Components = [calendar components:comps
                                                    fromDate:date2];
    
    NSDate *date1Calendar = [calendar dateFromComponents:date1Components];
    NSDate *date2Calendar = [calendar dateFromComponents:date2Components];
    
    return [date1Calendar compare:date2Calendar];
}

- (CPTColor *)colorWithIdentifaer:(NSUInteger)identifaer {
    NSArray *colors = [self plotColor];
    NSUInteger index = identifaer % 2 == 0 ? identifaer * 2 : colors.count - identifaer * 2;
    return [colors objectAtIndex:index];
}

- (NSArray *)plotColor {
    static NSMutableArray *colors;
    if (colors) {
        return colors;
    }
    colors = [NSMutableArray new];
    for (CGFloat blue = 0; blue < 256; blue = blue + 51) {
        for (CGFloat green = 0; green < 256; green = green + 51) {
            for (CGFloat red = 0; red < 256; red = red + 51) {
                CPTColor *color = [CPTColor colorWithComponentRed:red/255
                                                            green:green/255
                                                             blue:blue/255
                                                            alpha:1.0];
                [colors addObject:color];
            }
        }
    }
    return colors;
}

- (NSArray *)graphStatisticModels {
    static NSArray *models;
    if (models) {
        return models;
    }
    
    models = @[
               [GraphStatisticsModel winrateModel],
               [GraphStatisticsModel pointsPerMatchModel],
               [GraphStatisticsModel wins:[self.statisticsService maxWinsForStatistics:self.userStatistics] + 20],
               [GraphStatisticsModel looses:[self.statisticsService maxLoosesForStatistics:self.userStatistics] + 20],
               [GraphStatisticsModel stars:[self.statisticsService maxStarsForStatistics:self.userStatistics] + 5],
               [GraphStatisticsModel antistars:[self.statisticsService maxAntistarsForStatistics:self.userStatistics] + 5]
               ];
    return models;
}

@end
