//
//  ROSPlayerProfileROSPlayerProfilePresenter.m
//  Prokrut
//
//  Created by Karpushin Artem on 12/11/2016.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import "ROSPlayerProfilePresenter.h"

#import "ROSPlayerProfileViewInput.h"
#import "ROSPlayerProfileInteractorInput.h"
#import "ROSPlayerProfileRouterInput.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ROSPlayerProfilePresenter

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
