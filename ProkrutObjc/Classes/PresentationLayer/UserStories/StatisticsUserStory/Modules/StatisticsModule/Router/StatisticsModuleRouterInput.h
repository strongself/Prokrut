//
//  StatisticsModuleStatisticsModuleRouterInput.h
//  Prokrut
//
//  Created by k.zinovyev on 02/09/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlayerProfileModuleConfiguration;

@protocol StatisticsModuleRouterInput <NSObject>

/**
 @author Artem Karpushin
 
 Открывает модуль "Профиль игрока"
 */
- (void)openPlayerProfileModuleWithConfig:(PlayerProfileModuleConfiguration *)config;

@end
