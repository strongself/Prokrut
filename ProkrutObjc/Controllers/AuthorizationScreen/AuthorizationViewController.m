//
//  AuthorizationViewController.m
//  ProkrutObjc
//
//  Created by Beniamin Sarkisyan on 21/07/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "AuthorizationViewController.h"

#import "AuthorizationService.h"

#import "SegueIdentifiers.h"
#import "LocalizableConstants.h"

#import <MBProgressHUD/MBProgressHUD.h>

@interface AuthorizationViewController ()

@property (nonatomic, strong) AuthorizationService *authorizationService;

@end

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
    return self.loginTextField.text.length > 0;
}

- (BOOL)passwordIsValid {
    return self.passwordTextField.text.length > 0;
}

- (void)showAlertControllerWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:NSLocalizedString(message, nil)
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(OkayTitle, nil)
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)textFieldValueChanged {
    self.enterButton.enabled = [self loginIsValid] && [self passwordIsValid];
}

- (IBAction)enterButtonAction {
    NSString *login = self.loginTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self.authorizationService authorizeWithLogin:login password:password completion:^(PFUser *user, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (user) {
            [self performSegueWithIdentifier:ShowTabControllerSegueIdentifier sender:nil];
        } else {
            [self showAlertControllerWithMessage:InvalidLoginOrPassword];
        }
    }];
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

- (AuthorizationService *)authorizationService {
    if (!_authorizationService) {
        _authorizationService = [AuthorizationService new];
    }
    
    return _authorizationService;
}

@end
