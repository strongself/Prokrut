//
//  ROSPlayerProfileROSPlayerProfilePresenter.h
//  Prokrut
//
//  Created by Karpushin Artem on 12/11/2016.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import "ROSPlayerProfileViewOutput.h"
#import "ROSPlayerProfileInteractorOutput.h"
#import "ROSPlayerProfileModuleInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ROSPlayerProfileModuleOutput;

@protocol ROSPlayerProfileViewInput;
@protocol ROSPlayerProfileInteractorInput;
@protocol ROSPlayerProfileRouterInput;

@interface ROSPlayerProfilePresenter : 
    NSObject <ROSPlayerProfileModuleInput, ROSPlayerProfileViewOutput, ROSPlayerProfileInteractorOutput>

@property (nonatomic, weak, nullable) id<ROSPlayerProfileModuleOutput> moduleOutput;

@property (nonatomic, weak, nullable) id<ROSPlayerProfileViewInput> view;
@property (nonatomic, strong) id<ROSPlayerProfileInteractorInput> interactor;
@property (nonatomic, strong) id<ROSPlayerProfileRouterInput> router;

@end

NS_ASSUME_NONNULL_END
