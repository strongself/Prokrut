//
//  StatisticsDataDisplayManager.m
//  ProkrutObjc
//
//  Created by k.zinovyev on 02.09.16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "StatisticsDataDisplayManager.h"
#import <Nimbus/NimbusModels.h>

#import "AllUserStats.h"
#import "PlayerStatisticsTableViewCellObject.h"
#import "StatisticsSeparatorCellObject.h"
#import "StatisticsSearchCellObject.h"

static NSUInteger const kStartRow = 2;

@interface StatisticsDataDisplayManager ()

@property (strong, nonatomic) NITableViewModel *tableViewModel;
@property (strong, nonatomic) NITableViewActions *tableViewActions;
@property (strong, nonatomic) NSArray *cellObjects;

@end

@implementation StatisticsDataDisplayManager

#pragma mark - Public methods

- (void)updateTableViewModelWithObjects:(NSArray *)objects
                         searchDelegate:(id<StatisticsSearchTableViewCellDelegate>)searchDelegate {
    [self createAllUserStatsCellObjectsWithStats:objects
                                  searchDelegate:searchDelegate];
}

- (NSIndexPath *)obtainStartIndexPath {
    return [NSIndexPath indexPathForRow:kStartRow
                              inSection:0];
}

#pragma mark - Методы DataDisplayManager

- (id<UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView {
    if (!self.tableViewModel) {
        [self updateTableViewModelWithObjects:nil
                               searchDelegate:nil];
    }
    return self.tableViewModel;
}

- (id<UITableViewDelegate>)delegateForTableView:(UITableView *)tableView withBaseDelegate:(id<UITableViewDelegate>)baseTableViewDelegate {
    if (!self.tableViewActions) {
        [self setupActionBlocks];
    }
    return [self.tableViewActions forwardingTo:self];
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [NICellFactory tableView:tableView heightForRowAtIndexPath:indexPath model:self.tableViewModel];
}

#pragma mark - Private methods

- (void)setupActionBlocks {
    self.tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
}

- (void)createAllUserStatsCellObjectsWithStats:(NSArray *)stats
                                searchDelegate:(id<StatisticsSearchTableViewCellDelegate>)searchDelegate {
    if (stats.count == 0) {
        return;
    }
    NSMutableArray *mutableModel = [NSMutableArray array];
    
    StatisticsSearchCellObject *searchCellObject = [StatisticsSearchCellObject new];
    searchCellObject.delegate = searchDelegate;
    [mutableModel addObject:searchCellObject];
    [mutableModel addObject:[StatisticsSeparatorCellObject new]];
    
    [stats enumerateObjectsUsingBlock:^(AllUserStats *statistics, NSUInteger idx, BOOL * _Nonnull stop) {
        PlayerStatisticsTableViewCellObject *cellObject = [PlayerStatisticsTableViewCellObject objectWithStatistics:statistics ratingPosition:idx + 1];
        [mutableModel addObject:cellObject];
        if (idx < stats.count - 1) {
            StatisticsSeparatorCellObject *separatorObject = [StatisticsSeparatorCellObject new];
            [mutableModel addObject:separatorObject];
        }
    }];
    self.tableViewModel = [[NITableViewModel alloc] initWithListArray:[mutableModel copy]
                                                    delegate:(id)[NICellFactory class]];
}


@end
