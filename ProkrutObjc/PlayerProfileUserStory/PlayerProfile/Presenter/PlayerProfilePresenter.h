//
//  ROSPlayerProfileROSPlayerProfilePresenter.h
//  Prokrut
//
//  Created by Karpushin Artem on 12/11/2016.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import "PlayerProfileViewOutput.h"
#import "PlayerProfileInteractorOutput.h"
#import "PlayerProfileModuleInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PlayerProfileModuleOutput;

@protocol PlayerProfileViewInput;
@protocol PlayerProfileInteractorInput;
@protocol PlayerProfileRouterInput;

@interface PlayerProfilePresenter :
    NSObject <PlayerProfileModuleInput, PlayerProfileViewOutput, PlayerProfileInteractorOutput>

@property (nonatomic, weak, nullable) id<PlayerProfileModuleOutput> moduleOutput;

@property (nonatomic, weak, nullable) id<PlayerProfileViewInput> view;
@property (nonatomic, strong) id<PlayerProfileInteractorInput> interactor;
@property (nonatomic, strong) id<PlayerProfileRouterInput> router;

@end

NS_ASSUME_NONNULL_END
