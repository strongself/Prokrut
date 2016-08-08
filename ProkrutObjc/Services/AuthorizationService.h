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

/**
 @author Beniamin Sarkisyan
 
 Метод для авторизации в приложении.
 В качестве логина можно передавать email или имя фамилию
 
 @param login      - логин
 @param password   - пароль
 @param completion - блок, который будет вызван, когда придет ответ от сервера
 */
- (void)authorizeWithLogin:(NSString *)login
                  password:(NSString *)password
                completion:(AuthorizationCompletionBlock)completion;

@end
