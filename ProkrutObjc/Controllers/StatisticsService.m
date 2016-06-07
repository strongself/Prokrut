//
//  StatisticsService.m
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 23/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "StatisticsService.h"

#import "UserStatistics.h"
#import "OnDateUserStatisctics.h"
#import "DateFormatter.h"
#import <Parse/Parse.h>

static NSInteger const kWinPoints = 4;
static NSInteger const kStarPoints = 20;

@interface StatisticsService ()

@end

@implementation StatisticsService

- (NSArray *)obtainStatisticsForMathes:(NSArray *)matches users:(NSArray *)users {
    NSMutableArray *mutStatistics = [NSMutableArray new];
    for (PFUser *user in users) {
        UserStatistics *userStatistics = [UserStatistics new];
        userStatistics.user = user;
        userStatistics.matchStatisticsArray = @[];
        [mutStatistics addObject:userStatistics];
    }
    NSArray *statArray = [mutStatistics copy];
    
    for (PFObject *match in matches) {
        [self calculateMatch:match withStatArray:statArray];
    }
    
    for (UserStatistics *userStatistics in statArray) {
        for (OnDateUserStatisctics *onDateStatistics in userStatistics.matchStatisticsArray) {
            [self calculateCommonPropertiesForStatistics:onDateStatistics];
        }
    }
    
    return statArray;
}

- (NSInteger)maxWinsForStatistics:(NSArray *)statistics {
    NSInteger maxValue = 0;
    for (UserStatistics *stat in statistics) {
        for (OnDateUserStatisctics *dayStat in stat.matchStatisticsArray) {
            maxValue = maxValue > dayStat.wins ? maxValue : dayStat.wins;
        }
    }
    return maxValue;
}

- (NSInteger)maxLoosesForStatistics:(NSArray *)statistics {
    NSInteger maxValue = 0;
    for (UserStatistics *stat in statistics) {
        for (OnDateUserStatisctics *dayStat in stat.matchStatisticsArray) {
            maxValue = maxValue > dayStat.looses ? maxValue : dayStat.looses;
        }
    }
    return maxValue;
}

- (NSInteger)maxPointsForStatistics:(NSArray *)statistics {
    NSInteger maxValue = 0;
    for (UserStatistics *stat in statistics) {
        for (OnDateUserStatisctics *dayStat in stat.matchStatisticsArray) {
            maxValue = maxValue > dayStat.points ? maxValue : dayStat.points;
        }
    }
    return maxValue;
}

- (NSInteger)maxStarsForStatistics:(NSArray *)statistics {
    NSInteger maxValue = 0;
    for (UserStatistics *stat in statistics) {
        for (OnDateUserStatisctics *dayStat in stat.matchStatisticsArray) {
            maxValue = maxValue > dayStat.stars ? maxValue : dayStat.stars;
        }
    }
    return maxValue;
}

- (NSInteger)maxAntistarsForStatistics:(NSArray *)statistics {
    NSInteger maxValue = 0;
    for (UserStatistics *stat in statistics) {
        for (OnDateUserStatisctics *dayStat in stat.matchStatisticsArray) {
            maxValue = maxValue > dayStat.antiStars ? maxValue : dayStat.antiStars;
        }
    }
    return maxValue;
}

- (void)calculateMatch:(PFObject *)match withStatArray:(NSArray *)statArray {
    NSInteger redScore = [match[@"redTeamScore"] integerValue];
    NSInteger blueScore = [match[@"blueTeamScore"] integerValue];
    
    PFUser *firstRedPlayer = match[@"firstRedPlayer"];
    OnDateUserStatisctics *firstRedPlayerStatistics = [self statisticsForUser:firstRedPlayer withMatch:match statArray:statArray];
    [self calculateUserStatistics:firstRedPlayerStatistics
                   withAliasScore:redScore
                      andFoeScore:blueScore];
    
    PFUser *secondRedPlayer = match[@"secondRedPlayer"];
    OnDateUserStatisctics *secondRedPlayerStatistics = [self statisticsForUser:secondRedPlayer withMatch:match statArray:statArray];
    [self calculateUserStatistics:secondRedPlayerStatistics
                   withAliasScore:redScore
                      andFoeScore:blueScore];
    
    PFUser *firstBluePlayer = match[@"firstBluePlayer"];
    OnDateUserStatisctics *firstBluePlayerStatistics = [self statisticsForUser:firstBluePlayer withMatch:match statArray:statArray];
    [self calculateUserStatistics:firstBluePlayerStatistics
                   withAliasScore:blueScore
                      andFoeScore:redScore];
    
    PFUser *secondBluePlayer = match[@"secondBluePlayer"];
    OnDateUserStatisctics *secondBluePlayerStatistics = [self statisticsForUser:secondBluePlayer withMatch:match statArray:statArray];
    [self calculateUserStatistics:secondBluePlayerStatistics
                   withAliasScore:blueScore
                      andFoeScore:redScore];
    
    
}

- (void)calculateUserStatistics:(OnDateUserStatisctics *)statistics
                 withAliasScore:(NSInteger)aliasScore
                    andFoeScore:(NSInteger)foeScore {
    statistics.points += aliasScore;
    if (aliasScore == 8) {
        statistics.wins += 1;
        statistics.points += kWinPoints;
        if (foeScore == 0) {
            statistics.stars += 1;
            statistics.points += kStarPoints;
        }
    } else {
        statistics.looses += 1;
        if (aliasScore == 0) {
            statistics.antiStars += 1;
        }
    }
}

- (OnDateUserStatisctics *)statisticsForUser:(PFUser *)user withMatch:(PFObject *)match statArray:(NSArray *)statArray {
    for (UserStatistics *statistics in statArray) {
        if ([statistics.user.objectId isEqualToString:user.objectId]) {
            OnDateUserStatisctics *lastOnDateStat = statistics.matchStatisticsArray.lastObject;
            NSDate *dateOfLastMatch = lastOnDateStat.dateStatistics;
            if (isSameDay(dateOfLastMatch, match[@"createdDate"])) {
                return statistics.matchStatisticsArray.lastObject;
            }
            
            OnDateUserStatisctics *onMatchStatistics = lastOnDateStat ? [lastOnDateStat copy] : [OnDateUserStatisctics new];
            onMatchStatistics.dateStatistics = match[@"createdDate"];
            onMatchStatistics.user = statistics.user;
            statistics.matchStatisticsArray = [statistics.matchStatisticsArray arrayByAddingObject:onMatchStatistics];
            return onMatchStatistics;
        }
    }
    NSLog(@"Не найдена статистика!");
    return nil;
}

- (void)calculateCommonPropertiesForStatistics:(OnDateUserStatisctics *)statistics {
    NSInteger matches = (statistics.wins + statistics.looses);
    if (matches == 0) {
        return;
    }
    statistics.winrate = (double)statistics.wins / matches;
    statistics.pointsPerMatch = (double)statistics.points / matches;
}

@end
