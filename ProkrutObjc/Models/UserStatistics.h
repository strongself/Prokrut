//
//  UserStatistics.h
//  ProkrutObjc
//
//  Created by Tsyganov Stanislav on 21/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Parse/Parse.h"
#import "OnDateUserStatisctics.h"

@interface UserStatistics : NSObject

@property (nonatomic, strong) PFUser *user;
@property (nonatomic, strong) NSArray <OnDateUserStatisctics *> *matchStatisticsArray;

@end
