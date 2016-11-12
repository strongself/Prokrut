//
//  ROSPlayerProfileROSPlayerProfileViewController.h
//  Prokrut
//
//  Created by Karpushin Artem on 12/11/2016.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ROSPlayerProfileViewInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ROSPlayerProfileViewOutput;

@interface ROSPlayerProfileViewController : UIViewController <ROSPlayerProfileViewInput>

@property (nonatomic, strong) id<ROSPlayerProfileViewOutput> output;

@end

NS_ASSUME_NONNULL_END
