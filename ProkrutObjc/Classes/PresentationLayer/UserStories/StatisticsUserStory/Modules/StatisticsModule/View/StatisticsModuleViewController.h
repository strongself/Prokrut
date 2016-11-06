//
//  StatisticsModuleStatisticsModuleViewController.h
//  Prokrut
//
//  Created by k.zinovyev on 02/09/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StatisticsModuleViewInput.h"
#import "StatisticsDataDisplayManager.h"
#import "StatisticsDataDisplayManagerDelegate.h"

@protocol StatisticsModuleViewOutput;

@interface StatisticsModuleViewController : UIViewController <StatisticsModuleViewInput, StatisticsDataDisplayManagerDelegate>

#pragma mark - Зависимости

@property (nonatomic, strong) StatisticsDataDisplayManager *dataDisplayManager;
@property (nonatomic, strong) id<StatisticsModuleViewOutput> output;

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;

@end
