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

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *winratePercent;
@property (weak, nonatomic) IBOutlet UIProgressView *winrateProgress;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *winsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lossesLabel;

@end
