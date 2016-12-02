//
//  LetterAvatarFactory.m
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 01/12/2016.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "LetterAvatarFactory.h"

#import "LetterAvatar.h"
#import "LetterAvatarViewModel.h"
#import "UIColor+ProkrutPalette.h"

static NSUInteger const kMaxNameLength = 2;

@implementation LetterAvatarFactory

- (LetterAvatar *)generateAvatarForName:(NSString *)name {
    LetterAvatarViewModel *viewModel = [LetterAvatarViewModel new];
    viewModel.name = [self generateLettersForName:name]; //генерировать строку
    viewModel.nameColor = [self generateColorForName:name]; //генерировать цвет
    
    LetterAvatar *avatar = [LetterAvatar loadFromNib];
    [avatar setupWithViewModel:viewModel];
    return avatar;
}

- (NSString *)generateLettersForName:(NSString *)name {
    NSArray *components = [name componentsSeparatedByString:@" "];
    NSString *result = @"";
    for (NSString *component in components) {
        NSString *firstLetter = [component substringToIndex:1];
        result = [result stringByAppendingString:firstLetter];
    }
    
    if (result.length > kMaxNameLength) {
        result = [result substringToIndex:kMaxNameLength];
    }
    
    return result;
}

- (UIColor *)generateColorForName:(NSString *)name {
    int stringNumber = 0;
    for (int i = 0; i < name.length; i++) {
        char currentChar = [name characterAtIndex:i];
        stringNumber += currentChar;
    }
    
    NSArray *nameColors = [self nameColors];
    NSInteger colorIndex = stringNumber % nameColors.count;
    UIColor *color = nameColors[colorIndex];
    return color;
}

- (NSArray *)nameColors {
    return @[
             [UIColor prokrutNameGreenColor],
             [UIColor prokrutNameBlueColor],
             [UIColor prokrutNameYellowColor]
             ];
}

@end
