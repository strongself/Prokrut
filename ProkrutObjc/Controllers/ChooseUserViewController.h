//
//  ChooseUserViewController.h
//  ProkrutObjc
//
//  Created by Tsyganov Stanislav on 14/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Parse/Parse.h"

typedef void(^ChooseUserViewControllerCompletionBlock)();

@interface ChooseUserViewController : UITableViewController

@property (nonatomic, copy) ChooseUserViewControllerCompletionBlock completionBlock;

@end
