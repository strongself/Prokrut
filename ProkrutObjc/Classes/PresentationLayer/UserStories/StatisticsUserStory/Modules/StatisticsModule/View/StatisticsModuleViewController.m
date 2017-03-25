//
//  StatisticsModuleStatisticsModuleViewController.m
//  Prokrut
//
//  Created by k.zinovyev on 02/09/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "StatisticsModuleViewController.h"

#import "StatisticsModuleViewOutput.h"

@interface StatisticsModuleViewController () <UISearchBarDelegate>

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation StatisticsModuleViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - <StatisticsModuleViewInput>

- (void)setupInitialState {
    [self setupPullToRefresh];
    [self setupTableView];
}

- (void)updateViewWithStatisticsData:(NSArray *)statisticsData {
    [self.dataDisplayManager updateTableViewModelWithObjects:statisticsData];
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    
//      NSIndexPath *startIndexPath = [self.dataDisplayManager obtainStartIndexPath];
    [self.tableView scrollToRowAtIndexPath:startIndexPath
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:NO];
    self.searchBar.hidden = NO;
}

- (void)showErrorStateWithError:(NSError *)error {
}

#pragma mark - <UISearchBarDelegate>

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self updateStatisticsWithText:searchText];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self updateStatisticsWithText:searchBar.text];
}

#pragma mark - Private

- (void)updateStatisticsWithText:(NSString *)searchText {
    NSArray *data = [self.output obtainStatisticsFilteredWithTerm:searchText];
    [self.dataDisplayManager updateTableViewModelWithObjects:data];
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                  withRowAnimation:UITableViewRowAnimationAutomatic];
}

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
    self.searchBar.delegate = self;
}

#pragma mark 

- (void)didPullToRefesh:(UIRefreshControl *)refreshControl {
    [self.output didTriggerPullToRefreshEvent];
}

@end
