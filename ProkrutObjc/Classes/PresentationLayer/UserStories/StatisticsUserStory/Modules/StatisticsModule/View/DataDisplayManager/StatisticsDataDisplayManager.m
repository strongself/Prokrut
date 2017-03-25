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

static NSUInteger const kStartRow = 1;

@interface StatisticsDataDisplayManager ()

@property (strong, nonatomic) NITableViewModel *tableViewModel;
@property (strong, nonatomic) NITableViewActions *tableViewActions;
@property (strong, nonatomic) NSArray *cellObjects;
@property (strong, nonatomic) id<UITableViewDelegate> delegate;

@end

@implementation StatisticsDataDisplayManager

#pragma mark - Public methods

- (void)updateTableViewModelWithObjects:(NSArray *)objects {
    [self createAllUserStatsCellObjectsWithStats:objects];
}

- (NSIndexPath *)obtainStartIndexPath {
    return [NSIndexPath indexPathForRow:kStartRow
                              inSection:0];
}

#pragma mark - Методы DataDisplayManager

- (id<UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView {
    if (!self.tableViewModel) {
        [self updateTableViewModelWithObjects:nil];
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

- (void)createAllUserStatsCellObjectsWithStats:(NSArray *)stats {
    if (stats.count == 0) {
        return;
    }
    NSMutableArray *mutableModel = [NSMutableArray array];
    [mutableModel addObject:[StatisticsSeparatorCellObject new]];
    [stats enumerateObjectsUsingBlock:^(AllUserStats *statistics, NSUInteger idx, BOOL * _Nonnull stop) {
        PlayerStatisticsTableViewCellObject *cellObject = [PlayerStatisticsTableViewCellObject objectWithStatistics:statistics];
        [mutableModel addObject:cellObject];
        if (idx < stats.count - 1) {
            StatisticsSeparatorCellObject *separatorObject = [StatisticsSeparatorCellObject new];
            [mutableModel addObject:separatorObject];
        }
    }];
    self.tableViewModel = [[NITableViewModel alloc] initWithSectionedArray:[mutableModel copy]
                                                                  delegate:(id)[NICellFactory class]];
}


@end
