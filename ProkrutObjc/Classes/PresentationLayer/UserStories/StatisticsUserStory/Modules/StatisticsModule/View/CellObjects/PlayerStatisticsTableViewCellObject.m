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
@property (nonatomic, assign, readwrite) NSUInteger score;
@property (nonatomic, assign, readwrite) NSUInteger stars;
@property (nonatomic, assign, readwrite) NSUInteger antistars;
@property (nonatomic, assign, readwrite) NSUInteger scoreDiff;
@property (nonatomic, assign, readwrite) NSUInteger starsDiff;
@property (nonatomic, assign, readwrite) NSUInteger antistarsDiff;

@end

@implementation PlayerStatisticsTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithStatistics:(AllUserStats *)statistics
                    ratingPosition:(NSUInteger)ratingPosition {
    self = [super init];
    if (self) {
        _ratingPosition = ratingPosition;
        _name = statistics.user.username;
        _email = statistics.user.email;
        _winrate = statistics.winrate;
        _score = statistics.points;
        _stars = statistics.stars;
        _antistars = statistics.antiStars;
        _scoreDiff = statistics.lastDateStats.points;
        _starsDiff = statistics.lastDateStats.stars;
        _antistarsDiff = 1;
    }
    return self;
}

+ (instancetype)objectWithStatistics:(AllUserStats *)statistics
                      ratingPosition:(NSUInteger)ratingPosition {
    return [[self alloc] initWithStatistics:statistics
                             ratingPosition:ratingPosition];
}

#pragma mark - NINibCellObject

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([PlayerStatisticsTableViewCell class]) bundle:[NSBundle mainBundle]];
}

- (Class)cellClass {
    return [PlayerStatisticsTableViewCell class];
}

@end
