//
//  UIView+Inspectable.h
//  ProkrutObjc
//
//  Created by Beniamin Sarkisyan on 21/07/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Inspectable)

@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

@property (nonatomic, assign) IBInspectable UIColor *borderColor;

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

@end
