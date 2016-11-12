//
//  ROSPlayerProfileROSPlayerProfileModuleInput.h
//  Prokrut
//
//  Created by Karpushin Artem on 12/11/2016.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ViperMcFlurry/ViperMcFlurry.h>

@class PlayerProfileModuleConfiguration;

NS_ASSUME_NONNULL_BEGIN

@protocol PlayerProfileModuleInput <RamblerViperModuleInput>

@required

/**
 @author Karpushin Artem

 Метод инициирует стартовую конфигурацию текущего модуля
 */
- (void)configureModuleWithConfig:(PlayerProfileModuleConfiguration *)config;

@end

NS_ASSUME_NONNULL_END
