//
//  StatisticsDataDisplayManager.h
//  ProkrutObjc
//
//  Created by k.zinovyev on 02.09.16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DataDisplayManager.h"
#import "StatisticsDataDisplayManagerDelegate.h"

@interface StatisticsDataDisplayManager : NSObject <DataDisplayManager, UITableViewDelegate>

@property (nonatomic, weak) id<StatisticsDataDisplayManagerDelegate> delegate;

- (void)updateTableViewModelWithObjects:(NSArray *)statistics;

- (NSIndexPath *)obtainStartIndexPath;

@end
