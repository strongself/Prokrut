//
//  StatisticsModuleStatisticsModuleAssembly.m
//  Prokrut
//
//  Created by k.zinovyev on 02/09/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "StatisticsModuleAssembly.h"
#import <ViperMcFlurry/ViperMcFlurry.h>

#import "StatisticsModuleViewController.h"
#import "StatisticsModuleInteractor.h"
#import "StatisticsModulePresenter.h"
#import "StatisticsModuleRouter.h"

#import "StatisticsDataDisplayManager.h"
#import "StatisticsProcessor.h"

@implementation StatisticsModuleAssembly

- (StatisticsModuleViewController *)viewStatisticsModule {
    return [TyphoonDefinition withClass:[StatisticsModuleViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterStatisticsModule]];
                              [definition injectProperty:@selector(dataDisplayManager)
                                                    with:[self dataDisplayManagerStatisticsModule]];
                          }];
}

- (StatisticsModuleInteractor *)interactorStatisticsModule {
    return [TyphoonDefinition withClass:[StatisticsModuleInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterStatisticsModule]];
                              [definition injectProperty:@selector(statisticsProcessor)
                                                    with:[self statisticsProcessorStatisticsModule]];
                          }];
}

- (StatisticsModulePresenter *)presenterStatisticsModule {
    return [TyphoonDefinition withClass:[StatisticsModulePresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self viewStatisticsModule]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self interactorStatisticsModule]];
                              [definition injectProperty:@selector(router)
                                                    with:[self routerStatisticsModule]];
                          }];
}

- (StatisticsModuleRouter *)routerStatisticsModule {
    return [TyphoonDefinition withClass:[StatisticsModuleRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(transitionHandler)
                                                    with:[self viewStatisticsModule]];
                          }];
}

#pragma mark - private

- (StatisticsDataDisplayManager *)dataDisplayManagerStatisticsModule {
    return [TyphoonDefinition withClass:[StatisticsDataDisplayManager class]];
}

- (StatisticsProcessor *)statisticsProcessorStatisticsModule {
    return [TyphoonDefinition withClass:[StatisticsProcessor class]];
}

@end
