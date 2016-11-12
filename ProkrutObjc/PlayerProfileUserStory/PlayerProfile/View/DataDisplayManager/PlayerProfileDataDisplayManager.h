//
//  PlayerProfileDataDisplayManager.h
//  ProkrutObjc
//
//  Created by Karpushin Artem on 12/11/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataDisplayManager.h"

@class AllUserStats;

NS_ASSUME_NONNULL_BEGIN

@interface PlayerProfileDataDisplayManager : NSObject <UITableViewDelegate>
/**
 @author Artem Karpushin
 
 Отдает dataSource для таблицы
 */
- (id<UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView
                                        playerStats:(AllUserStats *)stats;
/**
 @author Artem Karpushin
 
 Отдает делегата таблицы
 */
- (id<UITableViewDelegate>)delegateForTableView:(UITableView *)tableView
                               withBaseDelegate:(nullable id<UITableViewDelegate>)baseTableViewDelegate;

@end

NS_ASSUME_NONNULL_END
