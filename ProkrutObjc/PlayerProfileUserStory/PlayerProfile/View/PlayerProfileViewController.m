//
//  ROSPlayerProfileROSPlayerProfileViewController.m
//  Prokrut
//
//  Created by Karpushin Artem on 12/11/2016.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import "PlayerProfileViewController.h"

#import "PlayerProfileViewOutput.h"
#import "PlayerProfileDataDisplayManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayerProfileViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PlayerProfileViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output didLoadView];
}

#pragma mark - Методы протокола <ROSPlayerProfileViewInput>

- (void)setupWithPlayerStats:(AllUserStats *)stats {
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView
                                                                    playerStats:stats];
    self.tableView.delegate = [self.dataDisplayManager delegateForTableView:self.tableView withBaseDelegate:nil];
}

@end

NS_ASSUME_NONNULL_END
