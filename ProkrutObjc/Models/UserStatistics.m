//
//  UserStatistics.m
//  ProkrutObjc
//
//  Created by Tsyganov Stanislav on 21/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "UserStatistics.h"

@implementation UserStatistics

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@> stats: %@", [self class], self.matchStatisticsArray];
}

@end
