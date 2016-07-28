//
//  AuthorizationViewController.m
//  ProkrutObjc
//
//  Created by Beniamin Sarkisyan on 21/07/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "AuthorizationViewController.h"

#import <InputValidators/LKEmailValidator.h>

@implementation AuthorizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInitialState];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setupInitialState {
    self.enterButton.enabled = NO;
}

- (BOOL)loginIsValid {
    return [[LKEmailValidator validator] validate:self.loginTextField.text error:nil];
}

- (BOOL)passwordIsValid {
    return self.passwordTextField.text.length > 0;
}

- (IBAction)textFieldValueChanged {
    self.enterButton.enabled = [self loginIsValid] && [self passwordIsValid];
}

- (IBAction)enterButtonAction {
    
}

- (IBAction)tapGestureRecognizerAction {
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.returnKeyType == UIReturnKeyNext) {
        [self.passwordTextField becomeFirstResponder];
    }
    
    [textField resignFirstResponder];
    return YES;
}

@end
