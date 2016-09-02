//
//  StatisticsModuleStatisticsModuleAssembly.m
//  Prokrut
//
//  Created by k.zinovyev on 02/09/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "StatisticsModuleAssembly.h"

#import "StatisticsModuleViewController.h"
#import "StatisticsModuleInteractor.h"
#import "StatisticsModulePresenter.h"
#import "StatisticsModuleRouter.h"

#import <ViperMcFlurry/ViperMcFlurry.h>

@implementation StatisticsModuleAssembly

- (StatisticsModuleViewController *)viewStatisticsModuleModule {
    return [TyphoonDefinition withClass:[StatisticsModuleViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterStatisticsModuleModule]];
                              [definition injectProperty:@selector(moduleInput)
                                                    with:[self presenterStatisticsModuleModule]];
                          }];
}

- (StatisticsModuleInteractor *)interactorStatisticsModuleModule {
    return [TyphoonDefinition withClass:[StatisticsModuleInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterStatisticsModuleModule]];
                          }];
}

- (StatisticsModulePresenter *)presenterStatisticsModuleModule {
    return [TyphoonDefinition withClass:[StatisticsModulePresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self viewStatisticsModuleModule]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self interactorStatisticsModuleModule]];
                              [definition injectProperty:@selector(router)
                                                    with:[self routerStatisticsModuleModule]];
                          }];
}

- (StatisticsModuleRouter *)routerStatisticsModuleModule {
    return [TyphoonDefinition withClass:[StatisticsModuleRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(transitionHandler)
                                                    with:[self viewStatisticsModuleModule]];
                          }];
}

@end
