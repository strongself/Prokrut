//
//  ROSPlayerProfileROSPlayerProfileRouter.h
//  Prokrut
//
//  Created by Karpushin Artem on 12/11/2016.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import "ROSPlayerProfileRouterInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RamblerViperModuleTransitionHandlerProtocol;

@interface ROSPlayerProfileRouter : NSObject <ROSPlayerProfileRouterInput>

@property (nonatomic, weak, nullable) id<RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end

NS_ASSUME_NONNULL_END
