//
//  PlayerProfileModuleConfiguration.h
//  ProkrutObjc
//
//  Created by Karpushin Artem on 12/11/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AllUserStats;

/**
 @author Artem Karpushin
 
 Cодержит данные необходимые для конфигурации модуля "Профиль игрока"
 */
@interface PlayerProfileModuleConfiguration : NSObject

@property (nonatomic, strong) AllUserStats *stats;

@end
