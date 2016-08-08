//
//  UITextField+Inspectable.m
//  ProkrutObjc
//
//  Created by Beniamin Sarkisyan on 21/07/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "UITextField+Inspectable.h"

@implementation UITextField (Inspectable)

@dynamic leftPadding;

- (CGFloat)leftPadding {
    return CGRectGetWidth(self.leftView.bounds);
}

- (void)setLeftPadding:(CGFloat)leftPadding {
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, leftPadding, self.bounds.size.height)];
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end
