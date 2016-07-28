//
//  SplashViewController.m
//  ProkrutObjc
//
//  Created by Beniamin Sarkisyan on 21/07/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "SplashViewController.h"

#import "SegueIdentifiers.h"

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self performSegueWithIdentifier:ShowAuthorizationControllerSegueIdentifier sender:nil];
}

@end
