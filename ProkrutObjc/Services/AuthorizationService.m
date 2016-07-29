//
//  AuthorizationService.m
//  ProkrutObjc
//
//  Created by Beniamin Sarkisyan on 21/07/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "AuthorizationService.h"

#import <Parse/Parse.h>
#import <InputValidators/LKEmailValidator.h>

static NSString *const kEmailParameter = @"email";
static NSString *const kUserNameParameter = @"username";

@implementation AuthorizationService

+ (PFUser *)currentUser {
    return [PFUser currentUser];
}

- (void)authorizeWithLogin:(NSString *)login
                  password:(NSString *)password
                completion:(AuthorizationCompletionBlock)completion {
    if ([[LKEmailValidator validator] validate:login error:nil]) {
        PFQuery *query = [PFUser query];
        [query whereKey:kEmailParameter equalTo:login];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
            NSString *username = [object objectForKey:kUserNameParameter];
            [self authorizeWithUserName:username
                               password:password
                             completion:completion];
        }];
    } else {
        [self authorizeWithUserName:login
                           password:password
                         completion:completion];
    }
}

- (void)authorizeWithUserName:(NSString *)userName password:(NSString *)password completion:(AuthorizationCompletionBlock)completion {
    [PFUser logInWithUsernameInBackground:userName password:password block:^(PFUser *user, NSError *error) {
        if (completion) {
            completion(user, error);
        }
    }];
}

@end
