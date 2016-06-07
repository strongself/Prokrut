//
//  Season.m
//  ProkrutObjc
//
//  Created by Savushkin Maksim on 17/02/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "Season.h"
#import "Parse/Parse.h"

@implementation Season

+ (NSArray <Season *>*)seasonsFromExternalRepresentation:(NSArray *)seasons {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (PFObject *season in seasons) {
        Season *object = [[Season alloc] init];
        object.seasonId = [season objectId];
        object.seasonDescription = season[@"description"];
        [result addObject:object];
    }
    return [result copy];
}

@end
