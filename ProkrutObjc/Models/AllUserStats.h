//
//  AllUserStats.h
//  ProkrutObjc
//
//  Created by Maxim Savushkin on 30/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

@interface AllUserStats : NSObject

@property (nonatomic, strong) PFUser *user;
@property (nonatomic) NSInteger wins;
@property (nonatomic) NSInteger looses;
@property (nonatomic) NSInteger points;
@property (nonatomic) NSInteger stars;
@property (nonatomic) NSInteger antiStars;
@property (nonatomic, readonly) CGFloat winrate;
@property (nonatomic, readonly) CGFloat pointsPerMatch;
@property (nonatomic) AllUserStats *lastDateStats;

+ (NSArray <AllUserStats *>*)userStatisticsFromExternalRepresentation:(NSArray *)externalStats;

@end
