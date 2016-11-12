//
//  StatisticsModuleStatisticsModuleRouter.m
//  Prokrut
//
//  Created by k.zinovyev on 02/09/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "StatisticsModuleRouter.h"
#import "PlayerProfileModuleInput.h"

static NSString * const StatisticsToPlayerProfileSegueId = @"StatisticsToPlayerProfileSegueId";

@implementation StatisticsModuleRouter

#pragma mark - Методы StatisticsModuleRouterInput

- (void)openPlayerProfileModuleWithConfig:(PlayerProfileModuleConfiguration *)config {
    [[self.transitionHandler openModuleUsingSegue:StatisticsToPlayerProfileSegueId] thenChainUsingBlock:^id<RamblerViperModuleOutput>(id<PlayerProfileModuleInput> moduleInput) {
        [moduleInput configureModuleWithConfig:config];
        return nil;
    }];
}

@end
