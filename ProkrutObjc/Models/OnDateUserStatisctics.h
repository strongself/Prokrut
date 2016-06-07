//
//  UserStatisctics.h
//  ProkrutObjc
//
//  Created by Tsyganov Stanislav on 15/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

/**
 @author Цыганов Станислав
 
 Статистика пользователя к определенному матчу
 */
@interface OnDateUserStatisctics : NSObject <NSCopying>

@property (nonatomic, strong) NSDate *dateStatistics;
@property (nonatomic, strong) PFUser *user;
@property (nonatomic) NSInteger wins;
@property (nonatomic) NSInteger looses;
@property (nonatomic) NSInteger points;
@property (nonatomic) CGFloat winrate;
@property (nonatomic) CGFloat pointsPerMatch;
@property (nonatomic) NSInteger stars;
@property (nonatomic) NSInteger antiStars;

@end
