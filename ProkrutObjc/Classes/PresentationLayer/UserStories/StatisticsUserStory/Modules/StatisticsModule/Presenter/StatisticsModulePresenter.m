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

@interface StatisticsModulePresenter ()

@property (nonatomic, strong) NSArray *fullStatistics;

@end

@implementation StatisticsModulePresenter

#pragma mark - Методы StatisticsModuleModuleInput

- (void)configureModule {
    // Стартовая конфигурация модуля, не привязанная к состоянию view
}

#pragma mark - Методы StatisticsModuleViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
    [self.interactor obtainStatisticsFromNetwork];
}

- (void)didTriggerPullToRefreshEvent {
    [self.interactor obtainStatisticsFromNetwork];
}

- (NSArray *)obtainStatisticsFilteredWithTerm:(NSString *)term {
    if (term.length == 0) {
        return self.fullStatistics;
    }
    NSArray *filteredStatistics = [self.interactor obtainFilteredStatisticsWithFullStatistics:self.fullStatistics
                                                                                         term:term];
    return filteredStatistics;
}

#pragma mark - Методы StatisticsModuleInteractorOutput

- (void)didObtainStatisticsFromNetworkWithData:(NSArray *)statistics
                                         error:(NSError *)error{
    if (statistics) {
        self.fullStatistics = statistics;
        [self.view updateViewWithStatisticsData:self.fullStatistics];
    } else {
        [self.view showErrorStateWithError:error];
    }
}

@end
