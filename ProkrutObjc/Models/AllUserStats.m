//
//  AllUserStats.m
//  ProkrutObjc
//
//  Created by Maxim Savushkin on 30/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "AllUserStats.h"

@implementation AllUserStats

- (CGFloat)winrate {
    return (CGFloat)self.wins / (self.wins + self.looses);
}

- (CGFloat)pointsPerMatch {
    return (CGFloat)self.points / (self.wins + self.looses);
}

+ (NSArray <AllUserStats *>*)userStatisticsFromExternalRepresentation:(NSArray *)externalStats {
    NSMutableArray <AllUserStats *>*result = [[NSMutableArray alloc] init];
    
    for (NSDictionary *stat in externalStats) {
        AllUserStats *currentStats = [[AllUserStats alloc] init];
    
        currentStats.stars = [stat[@"stars"] integerValue];
        currentStats.antiStars = [stat[@"antiStars"] integerValue];
        currentStats.wins = [stat[@"wins"] integerValue];
        currentStats.looses = [stat[@"looses"] integerValue];
        currentStats.points = [stat[@"points"] integerValue];
        currentStats.user = stat[@"user"];
    
        NSDictionary *externalLastDateStats = stat[@"statisticsForLastDate"];
    
        AllUserStats *lastDateStats = [[AllUserStats alloc] init];
        lastDateStats.stars = [externalLastDateStats[@"stars"] integerValue];
        lastDateStats.antiStars = [externalLastDateStats[@"antiStars"] integerValue];
        lastDateStats.wins = [externalLastDateStats[@"wins"] integerValue];
        lastDateStats.looses = [externalLastDateStats[@"looses"] integerValue];
        lastDateStats.points = [externalLastDateStats[@"points"] integerValue];
    
        currentStats.lastDateStats = lastDateStats;
        [result addObject:currentStats];
    }
    
    return [result copy];
}

@end
