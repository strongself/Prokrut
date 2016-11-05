//
//  StatisticsProcessor.h
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 19/07/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AllUserStats;

/**
 @author Egor Tolstoy
 
 This object is responsible for filtering and sorting statistics data
 */
@interface StatisticsProcessor : NSObject

- (NSArray *)processStatistics:(NSArray <AllUserStats *> *)statistics;
- (NSArray *)processStatistics:(NSArray <AllUserStats *> *)statistics
                  withUsername:(NSString *)username;

@end
