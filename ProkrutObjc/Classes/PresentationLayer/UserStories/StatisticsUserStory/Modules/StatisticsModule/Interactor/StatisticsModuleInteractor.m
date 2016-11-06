//
//  StatisticsModuleStatisticsModuleInteractor.m
//  Prokrut
//
//  Created by k.zinovyev on 02/09/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "StatisticsModuleInteractor.h"
#import <Parse/Parse.h>

#import "StatisticsModuleInteractorOutput.h"
#import "AllUserStats.h"

@implementation StatisticsModuleInteractor

#pragma mark - Методы StatisticsModuleInteractorInput

- (void)obtainStatisticsFromNetwork {
    NSString *currentSeasonId = [[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentSeasonId"];
    NSDictionary *params;
    if (currentSeasonId) {
        params = @{@"seasonId" : currentSeasonId};
    }
    [PFCloud callFunctionInBackground:@"matchesStatistics"
                       withParameters:params
                                block:^(id  _Nullable object, NSError * _Nullable error)
     {
         NSArray *filteredStatistics = nil;
         if (object) {
             NSArray *allStats = [AllUserStats userStatisticsFromExternalRepresentation:object];
             filteredStatistics = [self.statisticsProcessor processStatistics:allStats];
         } else if (error) {
             NSLog(@"%@", error.localizedDescription);
         }
         [self.output didObtainStatisticsFromNetworkWithData:filteredStatistics
                                                       error:error];
     }];
}

- (NSArray *)obtainFilteredStatisticsWithFullStatistics:(NSArray *)fullStatistics
                                                   term:(NSString *)term {
    NSArray *filteredStatistics = [self.statisticsProcessor processStatistics:fullStatistics
                                                                 withUsername:term];
    return filteredStatistics;
}

@end
