//
//  AppDelegate.m
//  ProkrutObjc
//
//  Created by Tsyganov Stanislav on 10/01/16.
//  Copyright (c) 2016 DevAlloy. All rights reserved.
//


#import "AppDelegate.h"

#import <Keys/ProkrutobjcKeys.h>
#import "Parse/Parse.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ProkrutobjcKeys *prokrutKeys = [ProkrutobjcKeys new];
    
    [Parse enableLocalDatastore];
    [Parse setApplicationId:applicationId
                  clientKey:clientKey];
    [self registerPushForApplication:application];
    
    return YES;
}

- (void)registerPushForApplication:(UIApplication *)application {
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Увы и ах");
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
}


@end
