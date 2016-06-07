//
//  UserStatiscticsCellObject.h
//  ProkrutObjc
//
//  Created by Tsyganov Stanislav on 15/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NICellFactory.h"

#import "OnDateUserStatisctics.h"

@interface UserStatiscticsCellObject : NSObject <NINibCellObject, NICellObject>

@property (nonatomic, strong) OnDateUserStatisctics *userStatistics;
@property (nonatomic, strong) OnDateUserStatisctics *prevUserStatistics;

@end
