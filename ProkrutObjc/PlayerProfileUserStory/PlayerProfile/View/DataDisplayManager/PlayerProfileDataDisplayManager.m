//
//  PlayerProfileDataDisplayManager.m
//  ProkrutObjc
//
//  Created by Karpushin Artem on 12/11/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "PlayerProfileDataDisplayManager.h"

#import <Nimbus/NimbusModels.h>

@interface PlayerProfileDataDisplayManager ()

@property (strong, nonatomic) NITableViewModel *tableViewModel;
@property (strong, nonatomic) NITableViewActions *tableViewActions;

@end

@implementation PlayerProfileDataDisplayManager

#pragma mark - Публичные методы

- (id<UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView
                                        playerStats:(AllUserStats *)stats {
    if (!self.tableViewModel) {
        NSArray *cellObjects = [self createCellObjectsWithStats:stats];
        self.tableViewModel = [[NITableViewModel alloc] initWithListArray:cellObjects
                                                                 delegate:(id)[NICellFactory class]];
    }
    return self.tableViewModel;
}

- (id<UITableViewDelegate>)delegateForTableView:(UITableView *)tableView
                               withBaseDelegate:(id<UITableViewDelegate>)baseTableViewDelegate {
    if (!self.tableViewActions) {
        [self setupActionBlocks];
    }
    return [self.tableViewActions forwardingTo:self];
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [NICellFactory tableView:tableView heightForRowAtIndexPath:indexPath model:self.tableViewModel];
}

#pragma mark - Вспомогательные методы

- (void)setupActionBlocks {
    self.tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
}

- (NSArray *)createCellObjectsWithStats:(AllUserStats *)stats {
    NSMutableArray *cellObjects = [NSMutableArray array];

    return [cellObjects copy];
}

@end
