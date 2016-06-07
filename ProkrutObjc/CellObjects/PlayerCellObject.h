//
// Created by Tsyganov Stanislav on 12/01/16.
// Copyright (c) 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NICellFactory.h"

@interface PlayerCellObject : NSObject <NINibCellObject, NICellObject>

@property (nonatomic, strong) NSString *title;

+ (instancetype)cellObjectWithTitle:(NSString *)title;

@end