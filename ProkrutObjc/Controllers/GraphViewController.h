//
//  GraphViewController.h
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 23/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPTGraphHostingView;

@interface GraphViewController : UIViewController

@property (weak, nonatomic) IBOutlet CPTGraphHostingView *hostView;

@end
