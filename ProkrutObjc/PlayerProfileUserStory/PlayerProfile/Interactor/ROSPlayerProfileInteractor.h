//
//  ROSPlayerProfileROSPlayerProfileInteractor.h
//  Prokrut
//
//  Created by Karpushin Artem on 12/11/2016.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import "ROSPlayerProfileInteractorInput.h"

@protocol ROSPlayerProfileInteractorOutput;

NS_ASSUME_NONNULL_BEGIN

@interface ROSPlayerProfileInteractor : NSObject <ROSPlayerProfileInteractorInput>

@property (nonatomic, weak, nullable) id<ROSPlayerProfileInteractorOutput> output;

@end

NS_ASSUME_NONNULL_END
