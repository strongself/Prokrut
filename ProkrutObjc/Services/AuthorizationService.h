//
//  AuthorizationService.h
//  ProkrutObjc
//
//  Created by Beniamin Sarkisyan on 21/07/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFUser;

typedef void(^AuthorizationCompletionBlock)(PFUser *user, NSError *error);

@interface AuthorizationService : NSObject

+ (PFUser *)currentUser;

- (void)authorizeWithLogin:(NSString *)login
                  password:(NSString *)password
                completion:(AuthorizationCompletionBlock)completion;

@end
