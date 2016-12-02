//
//  LetterAvatarFactory.h
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 01/12/2016.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LetterAvatar;

@interface LetterAvatarFactory : NSObject

- (LetterAvatar *)generateAvatarForName:(NSString *)name;

@end
