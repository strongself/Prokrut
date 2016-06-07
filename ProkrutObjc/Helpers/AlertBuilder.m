//
//  AlertBuilder.m
//  ProkrutObjc
//
//  Created by Savushkin Maksim on 28/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "AlertBuilder.h"

@implementation AlertBuilder

+ (void)showDescriptionAlertInViewController:(UIViewController *)vc withTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok"
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
    [alertController addAction:action];
    [vc presentViewController:alertController animated:YES completion:nil];
}

@end
