//
//  ROSPlayerProfileROSPlayerProfileViewController.h
//  Prokrut
//
//  Created by Karpushin Artem on 12/11/2016.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PlayerProfileViewInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PlayerProfileViewOutput;

@interface PlayerProfileViewController : UIViewController <PlayerProfileViewInput>

@property (nonatomic, strong) id<PlayerProfileViewOutput> output;

@end

NS_ASSUME_NONNULL_END
