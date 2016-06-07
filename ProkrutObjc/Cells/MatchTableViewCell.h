//
//  MatchTableViewCell.h
//  ProkrutObjc
//
//  Created by Tsyganov Stanislav on 17/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NimbusModels.h"

@interface MatchTableViewCell : UITableViewCell <NICell>
@property (weak, nonatomic) IBOutlet UILabel *firstRedLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondRedLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstBlueLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondBlueLabel;
@property (weak, nonatomic) IBOutlet UILabel *redScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *blueScoreLabel;

@end
