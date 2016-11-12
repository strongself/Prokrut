//
//  ROSPlayerProfileROSPlayerProfileAssembly.m
//  Prokrut
//
//  Created by Karpushin Artem on 12/11/2016.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import "PlayerProfileAssembly.h"

#import "PlayerProfileViewController.h"
#import "PlayerProfileInteractor.h"
#import "PlayerProfilePresenter.h"
#import "PlayerProfileRouter.h"
#import "PlayerProfileDataDisplayManager.h"
#import "PlayerProfileModuleStateStorage.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayerProfileAssembly

#pragma mark - VIPER

- (PlayerProfileViewController *)viewPlayerProfileModule {
    return [TyphoonDefinition withClass:[PlayerProfileViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterPlayerProfileModule]];
                              [definition injectProperty:@selector(moduleInput)
                                                    with:[self presenterPlayerProfileModule]];
                              [definition injectProperty:@selector(dataDisplayManager)
                                                    with:[self dataDisplayManagerPlayerProfile]];
                          }];
}

- (PlayerProfileInteractor *)interactorPlayerProfileModule {
    return [TyphoonDefinition withClass:[PlayerProfileInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterPlayerProfileModule]];
                          }];
}

- (PlayerProfilePresenter *)presenterPlayerProfileModule {
    return [TyphoonDefinition withClass:[PlayerProfilePresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self viewPlayerProfileModule]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self interactorPlayerProfileModule]];
                              [definition injectProperty:@selector(router)
                                                    with:[self routerPlayerProfileModule]];
                              [definition injectProperty:@selector(moduleStateStorage)
                                                    with:[self moduleStateStoragePlayerProfile]];
                          }];
}

- (PlayerProfileRouter *)routerPlayerProfileModule {
    return [TyphoonDefinition withClass:[PlayerProfileRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(transitionHandler)
                                                    with:[self viewPlayerProfileModule]];
                          }];
}

#pragma mark - Вспомогательные объекты

- (PlayerProfileDataDisplayManager *)dataDisplayManagerPlayerProfile {
    return [TyphoonDefinition withClass:[PlayerProfileDataDisplayManager class]];
}

- (PlayerProfileModuleStateStorage *)moduleStateStoragePlayerProfile {
    return [TyphoonDefinition withClass:[PlayerProfileModuleStateStorage class]];
}

@end

NS_ASSUME_NONNULL_END
