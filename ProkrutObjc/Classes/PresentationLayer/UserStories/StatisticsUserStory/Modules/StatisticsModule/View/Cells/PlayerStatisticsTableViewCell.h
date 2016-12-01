//
//  PlayerStatisticsTableViewCell.h
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 26/10/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Nimbus/NimbusModels.h>

@interface PlayerStatisticsTableViewCell : UITableViewCell <NICell>

@property (weak, nonatomic) IBOutlet UIView *letterAvatar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (weak, nonatomic) IBOutlet UILabel *winratePercent;
@property (weak, nonatomic) IBOutlet UIImageView *winrateArrowImageView;
@property (weak, nonatomic) IBOutlet UILabel *winrateDiffLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *winrateProgress;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *scoreArrowImageView;
@property (weak, nonatomic) IBOutlet UILabel *scoreDiffLabel;

@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starArrowImageView;
@property (weak, nonatomic) IBOutlet UILabel *starDiffLabel;

@property (weak, nonatomic) IBOutlet UILabel *antistarLabel;
@property (weak, nonatomic) IBOutlet UIImageView *antistarArrowImageView;
@property (weak, nonatomic) IBOutlet UILabel *antistarDiffLabel;

@end
