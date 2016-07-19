//
//  StatisticsViewController.m
//  ProkrutObjc
//
//  Created by Tsyganov Stanislav on 10/01/16.
//  Copyright (c) 2016 DevAlloy. All rights reserved.
//


#import "StatisticsViewController.h"

#import <Nimbus/NimbusModels.h>

#import "OnDateUserStatisctics.h"
#import "UserStatistics.h"
#import "StatisticsService.h"
#import "AllUserStats.h"
#import "AllStatsCellObject.h"
#import "UserStatiscticsCellObject.h"
#import "SeasonViewController.h"
#import "StatisticsProcessor.h"

@interface StatisticsViewController () <UITableViewDelegate>

@property (nonatomic, strong) NSArray <UserStatistics *>*userStatistics;
@property (nonatomic, strong) NITableViewActions *tableViewActions;
@property (nonatomic, strong) NITableViewModel *model;
@property (nonatomic, strong) StatisticsService *statisticsService;
@property (nonatomic, strong) StatisticsProcessor *statisticsProcessor;

@property (nonatomic, strong) NSDate *currentMatchDate;

@end

@implementation StatisticsViewController

- (StatisticsService *)statisticsService {
    if (!_statisticsService) {
        _statisticsService = [StatisticsService new];
    }
    return _statisticsService;
}

- (StatisticsProcessor *)statisticsProcessor {
    if (!_statisticsProcessor) {
        _statisticsProcessor = [StatisticsProcessor new];
    }
    return _statisticsProcessor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIRefreshControl *pullToRefreshControl = [UIRefreshControl new];
    [pullToRefreshControl addTarget:self action:@selector(didPullToRefesh:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = pullToRefreshControl;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self recieveMatchesData];
}

- (void)recieveMatchesData {
  __weak typeof(self)weakSelf = self;
    NSString *currentSeasonId = [[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentSeasonId"];
    NSDictionary *params;
    if (currentSeasonId) {
        params = @{@"seasonId" : currentSeasonId};
    }
    [PFCloud callFunctionInBackground:@"matchesStatistics"
                       withParameters:params
                                block:^(id  _Nullable object, NSError * _Nullable error)
     {
        typeof(weakSelf) stongSelf = weakSelf;
        if (object) {
          NSArray *allStats = [AllUserStats userStatisticsFromExternalRepresentation:object];
          [stongSelf createAllUserStatsCellObjectsWithStats:allStats];
        } else if (error) {
          NSLog(@"%@", error.localizedDescription);
        }
        [stongSelf.refreshControl endRefreshing];
     }];
}

- (void)didPullToRefesh:(UIRefreshControl *)refreshControl {
    [self recieveMatchesData];
}

#pragma mark - table view
- (void)createAllUserStatsCellObjectsWithStats:(NSArray *)stats {
    NSMutableArray *mutableModel = [NSMutableArray array];
    
    NSArray *filteredStatistics = [self.statisticsProcessor processStatistics:stats];
    for (AllUserStats *statistics in filteredStatistics) {
        AllStatsCellObject *cellObject = [AllStatsCellObject cellObjectWithAllStats:statistics];
        [mutableModel addObject:cellObject];
    }
    self.model = [[NITableViewModel alloc] initWithListArray:[mutableModel copy]
                                                    delegate:(id)[NICellFactory class]];
    [self updateTableView];
}

- (void)updateTableView {
    self.tableView.delegate = [self.tableViewActions forwardingTo:self];
    self.tableView.dataSource = self.model;
    [self.tableView reloadData];
}

- (NITableViewActions *)tableViewActions {
    if (_tableViewActions == nil) {
        _tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
    }
    return _tableViewActions;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 260.f;
}

#pragma mark <Actions>
- (IBAction)didTapNewSeasonButton:(id)sender {
    SeasonViewController *seasonVC = [[SeasonViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:seasonVC];
    [self presentViewController:navVC animated:YES completion:nil];
}

@end