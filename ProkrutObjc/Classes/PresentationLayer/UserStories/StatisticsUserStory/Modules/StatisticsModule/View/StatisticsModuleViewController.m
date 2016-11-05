//
//  StatisticsModuleStatisticsModuleViewController.m
//  Prokrut
//
//  Created by k.zinovyev on 02/09/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "StatisticsModuleViewController.h"

#import "StatisticsModuleViewOutput.h"

@interface StatisticsModuleViewController ()

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

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
    [self.dataDisplayManager updateTableViewModelWithObjects:statisticsData];
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    
    NSIndexPath *startIndexPath = [self.dataDisplayManager obtainStartIndexPath];
    [self.tableView scrollToRowAtIndexPath:startIndexPath
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:NO];
}

- (void)showErrorStateWithError:(NSError *)error {
}

#pragma mark - private

- (void)setupPullToRefresh {
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(didPullToRefesh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)setupTableView {
    self.dataDisplayManager.delegate = self;
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    self.tableView.delegate = [self.dataDisplayManager delegateForTableView:self.tableView
                                                           withBaseDelegate:nil];
}

#pragma mark 

- (void)didPullToRefesh:(UIRefreshControl *)refreshControl {
    [self.output didTriggerPullToRefreshEvent];
}

@end
