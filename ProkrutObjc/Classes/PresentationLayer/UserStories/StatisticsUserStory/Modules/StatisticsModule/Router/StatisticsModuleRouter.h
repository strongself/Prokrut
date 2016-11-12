//
//  StatisticsModuleStatisticsModuleRouter.h
//  Prokrut
//
//  Created by k.zinovyev on 02/09/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "StatisticsModuleRouterInput.h"
#import <ViperMcFlurry/ViperMcFlurry.h>

@protocol RamblerViperModuleTransitionHandlerProtocol;

@interface StatisticsModuleRouter : NSObject <StatisticsModuleRouterInput>

@property (nonatomic, weak) id<RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end
