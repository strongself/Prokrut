//
//  Season.h
//  ProkrutObjc
//
//  Created by Savushkin Maksim on 17/02/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Season : NSObject

@property (nonatomic, strong) NSString *seasonDescription;
@property (nonatomic, strong) NSString *seasonId;

+ (NSArray <Season *>*)seasonsFromExternalRepresentation:(NSArray *)seasons;

@end
