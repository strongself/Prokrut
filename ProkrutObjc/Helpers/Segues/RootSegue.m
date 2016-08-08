//
//  RootSegue.m
//  ProkrutObjc
//
//  Created by Beniamin Sarkisyan on 21/07/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "RootSegue.h"

@implementation RootSegue

- (void)perform {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIViewController *oldRootVC = window.rootViewController;
    window.rootViewController = self.destinationViewController;
    
    [UIView transitionWithView:window
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:nil
                    completion:^(BOOL finished) {
                        // See http://stackoverflow.com/questions/26763020/leaking-views-when-changing-rootviewcontroller-inside-transitionwithview
                        for (UIView *subview in window.subviews) {
                            if ([subview isKindOfClass:NSClassFromString (@"UITransitionView")]) {
                                [subview removeFromSuperview];
                            }
                        }
                        
                        [oldRootVC dismissViewControllerAnimated:NO completion:^{
                            [oldRootVC.view removeFromSuperview];
                        }];
                    }];
}

@end
