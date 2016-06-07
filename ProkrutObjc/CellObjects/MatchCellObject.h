//
//  MatchCellObject.h
//  ProkrutObjc
//
//  Created by Tsyganov Stanislav on 17/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NICellFactory.h"

@interface MatchCellObject : NSObject <NINibCellObject, NICellObject>

@property (strong, nonatomic) NSString *firstRedPlayer;
@property (strong, nonatomic) NSString *secondRedPlayer;
@property (strong, nonatomic) NSString *firstBluePlayer;
@property (strong, nonatomic) NSString *secondBluePlayer;
@property (strong, nonatomic) NSString *redScore;
@property (strong, nonatomic) NSString *blueScore;

@end
