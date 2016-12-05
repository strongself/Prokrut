//
//  LetterAvatar.h
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 01/12/2016.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LetterAvatarViewModel;

@interface LetterAvatar : UIView

- (void)setupWithViewModel:(LetterAvatarViewModel *)viewModel;

+ (LetterAvatar *)loadFromNib;

@property (weak, nonatomic) IBOutlet UIView *roundView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
