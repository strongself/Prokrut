//
//  ProkrutNavigationController.m
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 27/10/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "ProkrutNavigationController.h"

#import "UIColor+ProkrutPalette.h"

@interface ProkrutNavigationController ()

@end

@implementation ProkrutNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = [UIColor prokrutBlueColor];
    self.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationBar.translucent = NO;
}

@end
