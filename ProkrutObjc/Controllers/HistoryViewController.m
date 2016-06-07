//
//  HistoryViewController.m
//  ProkrutObjc
//
//  Created by Tsyganov Stanislav on 17/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "HistoryViewController.h"

#import "Parse/Parse.h"
#import "NimbusModels.h"

#import "MatchCellObject.h"
#import "DateFormatter.h"

@interface HistoryViewController ()<UITableViewDelegate>

@property (nonatomic, strong) NITableViewActions *tableViewActions;
@property (nonatomic, strong) NITableViewModel *model;
@property (nonatomic, strong) NSDate *tempDate;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIRefreshControl *pullToRefreshControl = [UIRefreshControl new];
    [pullToRefreshControl addTarget:self action:@selector(didPullToRefesh:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = pullToRefreshControl;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self recieveMathcesDataFromLocalStorage:YES];
}

- (void)didPullToRefesh:(UIRefreshControl *)refreshControl {
    [self recieveMathcesDataFromLocalStorage:NO];
}

- (NITableViewActions *)tableViewActions {
    if (_tableViewActions == nil) {
        _tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
    }
    return _tableViewActions;
}

- (void)recieveMathcesDataFromLocalStorage:(BOOL)fromLocalStorage {
    NSString *seasonId = [[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentSeasonId"];
    if (!seasonId) {
        return;
    }
    PFQuery *query = [PFQuery queryWithClassName:@"Match"];
    [query whereKey:@"seasonId" equalTo:seasonId];
    query.limit = 1000;
    if (fromLocalStorage) {
        [query fromPinWithName:seasonId];
    }
    [query addDescendingOrder:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects.count == 0 && fromLocalStorage) {
            // пробуем получить из сети
            [self recieveMathcesDataFromLocalStorage:NO];
        } else {
            if (objects.count > 0) {
                [self createCellObjectsWithMatches:objects];
            } else {
                [self createCellObjectsWithMatches:@[]];
            }
            [self.refreshControl endRefreshing];
            [PFObject pinAllInBackground:objects withName:seasonId];
        }
    }];
}

- (void)createCellObjectsWithMatches:(NSArray *)matches {
    self.tempDate = nil;
    NSMutableArray *mutableModel = [NSMutableArray array];
    matches = [matches sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *  _Nonnull obj1, NSDictionary * _Nonnull obj2) {
        return [obj2[@"createdDate"] compare:obj1[@"createdDate"]];
    }];
    
    for (PFObject *match in matches) {
        [self addDateWithMatch:match forModel:mutableModel];
        
        MatchCellObject *cellObject = [MatchCellObject new];
        cellObject.firstRedPlayer = ((PFUser *)match[@"firstRedPlayer"]).username;
        cellObject.secondRedPlayer = ((PFUser *)match[@"secondRedPlayer"]).username;
        cellObject.firstBluePlayer = ((PFUser *)match[@"firstBluePlayer"]).username;
        cellObject.secondBluePlayer = ((PFUser *)match[@"secondBluePlayer"]).username;
        cellObject.redScore = [match[@"redTeamScore"] stringValue];
        cellObject.blueScore = [match[@"blueTeamScore"] stringValue];
        
        [mutableModel addObject:cellObject];
    }
    self.model = [[NITableViewModel alloc] initWithSectionedArray:mutableModel
                                                         delegate:(id)[NICellFactory class]];
    [self updateTableView];
}

- (void)updateTableView {
    self.tableView.delegate = [self.tableViewActions forwardingTo:self];
    self.tableView.dataSource = self.model;
    [self.tableView reloadData];
}

- (void)addDateWithMatch:(PFObject *)match forModel:(NSMutableArray *)dateModel {
    NSDate *matchDate = match[@"createdDate"];
        if (!isSameDay(matchDate, self.tempDate)) {
        self.tempDate = matchDate;
        NSString *sectionString = [self.dateFormatter stringFromDate:matchDate];
        [dateModel addObject:sectionString];
    }
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [NSDateFormatter new];
        _dateFormatter.dateFormat = @"dd MMMM";
    }
    return _dateFormatter;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105.f;
}

@end
