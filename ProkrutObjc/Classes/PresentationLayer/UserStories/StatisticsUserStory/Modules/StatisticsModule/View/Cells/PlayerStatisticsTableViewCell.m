//
//  PlayerStatisticsTableViewCell.m
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 26/10/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "PlayerStatisticsTableViewCell.h"

#import "PlayerStatisticsTableViewCellObject.h"
#import "OnDateUserStatisctics.h"

static CGFloat const kPlayerStatisticsTableViewCellHeight = 226.0f;

@implementation PlayerStatisticsTableViewCell

- (BOOL)shouldUpdateCellWithObject:(PlayerStatisticsTableViewCellObject *)object {
    self.nameLabel.text = [NSString stringWithFormat:@"%tu. %@", object.ratingPosition, object.name];
    self.emailLabel.text = object.email;
    self.winratePercent.text = [NSString stringWithFormat:@"%1.2f%%", object.winrate * 100];
    self.winrateProgress.progress = object.winrate;
    self.scoreLabel.text = [NSString stringWithFormat:@"%tu", object.score];
    self.winsLabel.text = [NSString stringWithFormat:@"%tu", object.wins];
    self.lossesLabel.text = [NSString stringWithFormat:@"%tu", object.losses];
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
    return kPlayerStatisticsTableViewCellHeight;
}

@end
