//
//  ROSPlayerProfileROSPlayerProfilePresenter.m
//  Prokrut
//
//  Created by Karpushin Artem on 12/11/2016.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import "PlayerProfilePresenter.h"

#import "PlayerProfileViewInput.h"
#import "PlayerProfileInteractorInput.h"
#import "PlayerProfileRouterInput.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayerProfilePresenter

#pragma mark - Методы протокола <ROSPlayerProfileModuleInput>

- (void)configureModule {
    // Стартовая конфигурация модуля, не привязанная к состоянию view
}

#pragma mark - Методы протокола <ROSPlayerProfileViewOutput>

- (void)didLoadView {
    [self.view setupInitialState];
}

#pragma mark - Методы протокола <ROSPlayerProfileInteractorOutput>

@end

NS_ASSUME_NONNULL_END
