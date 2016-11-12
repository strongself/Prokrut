//
//  ROSPlayerProfileROSPlayerProfileInteractor.h
//  Prokrut
//
//  Created by Karpushin Artem on 12/11/2016.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import "PlayerProfileInteractorInput.h"

@protocol PlayerProfileInteractorOutput;

NS_ASSUME_NONNULL_BEGIN

@interface PlayerProfileInteractor : NSObject <PlayerProfileInteractorInput>

@property (nonatomic, weak, nullable) id<PlayerProfileInteractorOutput> output;

@end

NS_ASSUME_NONNULL_END
