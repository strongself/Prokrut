//
//  ROSPlayerProfileROSPlayerProfileAssembly.m
//  Prokrut
//
//  Created by Karpushin Artem on 12/11/2016.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import "ROSPlayerProfileAssembly.h"

#import "ROSPlayerProfileViewController.h"
#import "ROSPlayerProfileInteractor.h"
#import "ROSPlayerProfilePresenter.h"
#import "ROSPlayerProfileRouter.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ROSPlayerProfileAssembly

#pragma mark - VIPER

- (ROSPlayerProfileViewController *)viewPlayerProfileModule {
    return [TyphoonDefinition withClass:[ROSPlayerProfileViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterPlayerProfileModule]];
                              [definition injectProperty:@selector(moduleInput)
                                                    with:[self presenterPlayerProfileModule]];
                          }];
}

- (ROSPlayerProfileInteractor *)interactorPlayerProfileModule {
    return [TyphoonDefinition withClass:[ROSPlayerProfileInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterPlayerProfileModule]];
                          }];
}

- (ROSPlayerProfilePresenter *)presenterPlayerProfileModule {
    return [TyphoonDefinition withClass:[ROSPlayerProfilePresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(view)
                                                    with:[self viewPlayerProfileModule]];
                              [definition injectProperty:@selector(interactor)
                                                    with:[self interactorPlayerProfileModule]];
                              [definition injectProperty:@selector(router)
                                                    with:[self routerPlayerProfileModule]];
                          }];
}

- (ROSPlayerProfileRouter *)routerPlayerProfileModule {
    return [TyphoonDefinition withClass:[ROSPlayerProfileRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(transitionHandler)
                                                    with:[self viewPlayerProfileModule]];
                          }];
}

@end

NS_ASSUME_NONNULL_END
