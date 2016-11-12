//
//  ROSPlayerProfileROSPlayerProfileViewInput.h
//  Prokrut
//
//  Created by Karpushin Artem on 12/11/2016.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PlayerProfileViewInput <NSObject>

@required

/**
 @author Karpushin Artem

 Метод настраивает начальное состояние view
 */
- (void)setupInitialState;

@end

NS_ASSUME_NONNULL_END
