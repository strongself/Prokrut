//
//  PlayerStatisticsTableViewCellObject.m
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 27/10/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "PlayerStatisticsTableViewCellObject.h"

#import "PlayerStatisticsTableViewCell.h"
#import "AllUserStats.h"
#import "PFUser.h"

@interface PlayerStatisticsTableViewCellObject ()

@property (nonatomic, assign, readwrite) NSUInteger ratingPosition;
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *email;
@property (nonatomic, strong, readwrite) NSURL *photoUrl;
@property (nonatomic, assign, readwrite) CGFloat winrate;
@property (nonatomic, assign, readwrite) CGFloat winrateDiff;
@property (nonatomic, assign, readwrite) NSUInteger score;
@property (nonatomic, assign, readwrite) NSUInteger stars;
@property (nonatomic, assign, readwrite) NSUInteger antistars;
@property (nonatomic, assign, readwrite) NSUInteger scoreDiff;
@property (nonatomic, assign, readwrite) NSUInteger starsDiff;
@property (nonatomic, assign, readwrite) NSUInteger antistarsDiff;

@end

@implementation PlayerStatisticsTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithStatistics:(AllUserStats *)statistics {
    self = [super init];
    if (self) {
        _ratingPosition = statistics.placeInTop;
        _name = statistics.user.username;
        _email = statistics.user.email;
        _winrate = statistics.winrate;
        _winrateDiff = [self calculateWinrateDiffForStatistics:statistics];
        _score = statistics.points;
        _stars = statistics.stars;
        _antistars = statistics.antiStars;
        _scoreDiff = statistics.lastDateStats.points;
        _starsDiff = statistics.lastDateStats.stars;
        _antistarsDiff = statistics.lastDateStats.antiStars;
    }
    return self;
}

+ (instancetype)objectWithStatistics:(AllUserStats *)statistics {
    return [[self alloc] initWithStatistics:statistics];
}

#pragma mark - NINibCellObject

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([PlayerStatisticsTableViewCell class]) bundle:[NSBundle mainBundle]];
}

- (Class)cellClass {
    return [PlayerStatisticsTableViewCell class];
}

#pragma mark - Private methods

- (CGFloat)calculateWinrateDiffForStatistics:(AllUserStats *)statistics {
    NSInteger previousDayWins = statistics.wins - statistics.lastDateStats.wins;
    NSInteger previousDayLosses = statistics.looses - statistics.lastDateStats.looses;
    CGFloat previousDayWinrate = (CGFloat)previousDayWins / (previousDayWins + previousDayLosses);
    return statistics.winrate - previousDayWinrate;
}

@end
