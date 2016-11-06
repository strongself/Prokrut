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

@property (nonatomic, assign) NSUInteger placeInTop;
@property (nonatomic, strong) PFUser *user;
@property (nonatomic, assign) NSInteger wins;
@property (nonatomic, assign) NSInteger looses;
@property (nonatomic, assign) NSInteger points;
@property (nonatomic, assign) NSInteger stars;
@property (nonatomic, assign) NSInteger antiStars;
@property (nonatomic, readonly) CGFloat winrate;
@property (nonatomic, readonly) CGFloat pointsPerMatch;
@property (nonatomic, strong) AllUserStats *lastDateStats;

+ (NSArray <AllUserStats *>*)userStatisticsFromExternalRepresentation:(NSArray *)externalStats;

@end
