//
//  StatisticsService.h
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 23/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatisticsService : NSObject

- (NSArray *)obtainStatisticsForMathes:(NSArray *)matches users:(NSArray *)users;

- (NSInteger)maxWinsForStatistics:(NSArray *)statistics;
- (NSInteger)maxLoosesForStatistics:(NSArray *)statistics;
- (NSInteger)maxPointsForStatistics:(NSArray *)statistics;
- (NSInteger)maxStarsForStatistics:(NSArray *)statistics;
- (NSInteger)maxAntistarsForStatistics:(NSArray *)statistics;

@end
