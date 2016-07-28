//
//  AuthorizationViewController.h
//  ProkrutObjc
//
//  Created by Beniamin Sarkisyan on 21/07/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthorizationViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *loginTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UIButton *enterButton;

- (IBAction)textFieldValueChanged;
- (IBAction)enterButtonAction;
- (IBAction)tapGestureRecognizerAction;

@end
