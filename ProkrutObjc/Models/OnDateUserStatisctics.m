//
//  UserStatisctics.m
//  ProkrutObjc
//
//  Created by Tsyganov Stanislav on 15/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "OnDateUserStatisctics.h"

@implementation OnDateUserStatisctics

- (id)copyWithZone:(NSZone *)zone {
    OnDateUserStatisctics *another = [[OnDateUserStatisctics allocWithZone:zone] init];
    another.dateStatistics = _dateStatistics;
    another.user = _user;
    another.wins = _wins;
    another.looses = _looses;
    another.points = _points;
    another.winrate = _winrate;
    another.pointsPerMatch = _pointsPerMatch;
    another.stars = _stars;
    another.antiStars = _antiStars;
    return another;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@> date: %@, wins: %tu, looses: %tu, winrate: %f", [self class], self.dateStatistics, self.wins, self.looses, self.winrate];
}

@end
