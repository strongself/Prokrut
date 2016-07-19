//
//  StatisticsProcessor.m
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 19/07/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "StatisticsProcessor.h"

#import "AllUserStats.h"

static NSUInteger const kMinimumGamesCount = 12;

@implementation StatisticsProcessor

#pragma mark - Public methods

- (NSArray *)processStatistics:(NSArray<AllUserStats *> *)statistics {
    NSArray *filteredStatistics = [self filterPlayerStatistics:statistics];
    NSArray *sortedStatistics = [self sortPlayerStatistics:filteredStatistics];
    return sortedStatistics;
}

#pragma mark - Private methods

- (NSArray *)filterPlayerStatistics:(NSArray<AllUserStats *> *)statistics {
    NSMutableArray *mutableStatistics = [NSMutableArray new];
    for (AllUserStats *model in statistics) {
        NSUInteger games = model.wins + model.looses;
        if (games >= kMinimumGamesCount) {
            [mutableStatistics addObject:model];
        }
    }
    return [mutableStatistics copy];
}

- (NSArray *)sortPlayerStatistics:(NSArray<AllUserStats *> *)statistics {
    NSString *sortKey = NSStringFromSelector(@selector(winrate));
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:sortKey
                                                                     ascending:NO];
    NSArray *orderedStatistics = [statistics sortedArrayUsingDescriptors:@[sortDescriptor]];
    return orderedStatistics;
}

@end
