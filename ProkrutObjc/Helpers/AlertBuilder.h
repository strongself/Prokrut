//
//  AlertBuilder.h
//  ProkrutObjc
//
//  Created by Savushkin Maksim on 28/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

@import UIKit;

@interface AlertBuilder : NSObject

+ (void)showDescriptionAlertInViewController:(UIViewController *)vc withTitle:(NSString *)title message:(NSString *)message;

@end
