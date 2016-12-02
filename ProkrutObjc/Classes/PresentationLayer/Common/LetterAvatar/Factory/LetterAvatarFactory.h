//
//  LetterAvatarFactory.h
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 01/12/2016.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LetterAvatarFactory : NSObject

- (UIView *)generateAvatarForName:(NSString *)name;

@end
