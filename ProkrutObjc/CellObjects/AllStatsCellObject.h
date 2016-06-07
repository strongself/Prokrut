//
//  AllStatsCellObject.h
//  ProkrutObjc
//
//  Created by Maxim Savushkin on 30/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NICellFactory.h"
@class AllUserStats;

@interface AllStatsCellObject : NSObject <NINibCellObject, NICellObject>

@property (nonatomic, strong) AllUserStats *stats;

+ (instancetype)cellObjectWithAllStats:(AllUserStats *)stats;

@end
