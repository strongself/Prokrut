//
//  ChooseScoreViewController.h
//  ProkrutObjc
//
//  Created by Tsyganov Stanislav on 15/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseScoreViewControllerCompletionBlock)(NSInteger score);

@interface ChooseScoreViewController : UITableViewController

@property (nonatomic, copy) ChooseScoreViewControllerCompletionBlock completionBlock;

@end
