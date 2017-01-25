//
//  AppDelegate.m
//  ProkrutObjc
//
//  Created by Tsyganov Stanislav on 10/01/16.
//  Copyright (c) 2016 DevAlloy. All rights reserved.
//


#import "AppDelegate.h"

#import <Keys/ProkrutobjcKeys.h>
#import <RamblerTyphoonUtils/AssemblyCollector.h>
#import "Parse/Parse.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ProkrutobjcKeys *prokrutKeys = [ProkrutobjcKeys new];
    
    ParseClientConfiguration *parseClientConfiguration = [ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration>  _Nonnull configuration) {
        configuration.applicationId = [prokrutKeys parseApplicationId];
        configuration.clientKey = [prokrutKeys parseClientKey];
        configuration.server = @"https://prokrut-serv.herokuapp.com/parse";
    }];
    
    [Parse initializeWithConfiguration:parseClientConfiguration];
    
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

- (NSArray *)initialAssemblies {
    RamblerInitialAssemblyCollector *collector = [RamblerInitialAssemblyCollector new];
    return [collector collectInitialAssemblyClasses];
}

@end
