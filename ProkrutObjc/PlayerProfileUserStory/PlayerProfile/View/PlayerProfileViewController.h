//
//  ROSPlayerProfileROSPlayerProfileViewController.h
//  Prokrut
//
//  Created by Karpushin Artem on 12/11/2016.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PlayerProfileViewInput.h"

@class PlayerProfileDataDisplayManager;

NS_ASSUME_NONNULL_BEGIN

@protocol PlayerProfileViewOutput;

@interface PlayerProfileViewController : UIViewController <PlayerProfileViewInput>

@property (nonatomic, strong) id<PlayerProfileViewOutput> output;
@property (nonatomic, strong) PlayerProfileDataDisplayManager *dataDisplayManager;

@end

NS_ASSUME_NONNULL_END
