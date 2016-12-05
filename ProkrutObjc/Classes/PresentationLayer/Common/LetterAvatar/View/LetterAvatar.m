//
//  LetterAvatar.m
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 01/12/2016.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "LetterAvatar.h"

#import "LetterAvatarViewModel.h"

static CGFloat const kLetterAvatarBorderWidth = 2.0f;

@implementation LetterAvatar

+ (LetterAvatar *)loadFromNib {
    return [[[NSBundle bundleForClass:self] loadNibNamed:NSStringFromClass([self class])
                                                   owner:self
                                                 options:NULL] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self layoutIfNeeded];
    self.roundView.layer.cornerRadius = self.roundView.frame.size.width / 2;
    self.roundView.layer.borderWidth = kLetterAvatarBorderWidth;
    self.roundView.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)setupWithViewModel:(LetterAvatarViewModel *)viewModel {
    self.nameLabel.text = viewModel.name;
    self.nameLabel.textColor = viewModel.nameColor;
}

@end
