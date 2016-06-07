//
//  AllStatsCell.h
//  ProkrutObjc
//
//  Created by Maxim Savushkin on 30/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NimbusModels.h"

@interface AllStatsCell : UITableViewCell <NICell>

@property (weak, nonatomic) IBOutlet UILabel *userNameTitle;
@property (weak, nonatomic) IBOutlet UILabel *winsLable;
@property (weak, nonatomic) IBOutlet UILabel *losesLabel;
@property (weak, nonatomic) IBOutlet UILabel *winrateLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsPerMatch;
@property (weak, nonatomic) IBOutlet UILabel *starsLabel;
@property (weak, nonatomic) IBOutlet UILabel *antiStarsLabel;

@property (weak, nonatomic) IBOutlet UILabel *winsChange;
@property (weak, nonatomic) IBOutlet UILabel *losesChange;
@property (weak, nonatomic) IBOutlet UILabel *pointsChange;
@property (weak, nonatomic) IBOutlet UILabel *winrateChange;
@property (weak, nonatomic) IBOutlet UILabel *pountsPerMatchChange;
@property (weak, nonatomic) IBOutlet UILabel *starsChange;
@property (weak, nonatomic) IBOutlet UILabel *antiStarsChange;

@end
