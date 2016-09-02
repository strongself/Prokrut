//
//  StatisticsModuleStatisticsModuleViewController.m
//  Prokrut
//
//  Created by k.zinovyev on 02/09/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "StatisticsModuleViewController.h"

#import "StatisticsModuleViewOutput.h"

@implementation StatisticsModuleViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы StatisticsModuleViewInput

- (void)setupInitialState {
    [self setupPullToRefresh];
    [self setupTableView];
    
}

- (void)updateViewWithStatisticsData:(NSArray *)statisticsData {
    
}

- (void)showErrorStateWithError:(NSError *)error {
    
}

#pragma mark - private

- (void)setupPullToRefresh {
    
}

- (void)setupTableView {
//    [self.tableView layoutIfNeeded];
//    self.dataDisplayManager.feedType = feedType;
//    self.dataDisplayManager.tableWidth = self.tableView.frame.size.width;
//    self.dataDisplayManager.tableViewAnimator = [RamblerTableViewAnimator objectWithTableView:self.tableView];
//    
//    id <UITableViewDataSource> dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
//    id <UITableViewDelegate> delegate = [self.dataDisplayManager delegateForTableView:self.tableView
//                                                                     withBaseDelegate:nil];
//    self.proxy = [[CDObserversProxy alloc] initWithProtocols:@[@protocol(UITableViewDelegate), @protocol(UIScrollViewDelegate)]
//                                                   observers:@[self.dataDisplayManager, self.scrollingHandler, delegate]];
//    
//    self.tableView.dataSource = dataSource;
//    self.tableView.delegate = (id<UITableViewDelegate>)self.proxy;
}

#pragma mark 

- (void)didPullToRefesh:(UIRefreshControl *)refreshControl {
    [self.output didTriggerPullToRefreshEvent];
}

@end
