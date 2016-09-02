//
//  StatisticsDataDisplayManager.m
//  ProkrutObjc
//
//  Created by k.zinovyev on 02.09.16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "StatisticsDataDisplayManager.h"

@interface StatisticsDataDisplayManager () <UITableViewDataSource>

@end

@implementation StatisticsDataDisplayManager

#pragma mark - Методы DataDisplayManager

- (id<UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView {
    return self;
}

- (id<UITableViewDelegate>)delegateForTableView:(UITableView *)tableView
                               withBaseDelegate:(id<UITableViewDelegate>)baseTableViewDelegate {
    return self;
}



@end
