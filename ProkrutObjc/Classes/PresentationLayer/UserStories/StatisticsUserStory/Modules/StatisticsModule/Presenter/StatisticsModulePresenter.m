//
//  StatisticsModuleStatisticsModulePresenter.m
//  Prokrut
//
//  Created by k.zinovyev on 02/09/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "StatisticsModulePresenter.h"

#import "StatisticsModuleViewInput.h"
#import "StatisticsModuleInteractorInput.h"
#import "StatisticsModuleRouterInput.h"

@implementation StatisticsModulePresenter

#pragma mark - Методы StatisticsModuleModuleInput

- (void)configureModule {
    // Стартовая конфигурация модуля, не привязанная к состоянию view
}

#pragma mark - Методы StatisticsModuleViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы StatisticsModuleInteractorOutput

@end
