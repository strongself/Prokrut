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
#import "UIColor+ProkrutPalette.h"

static CGFloat const kPlayerStatisticsTableViewCellHeight = 226.0f;
static NSString *const kNoPhotoImageName = @"no-avatar";
static NSString *const kArrowUpImageName = @"arrow-up";
static NSString *const kArrowDownImageName = @"arrow-down";

@implementation PlayerStatisticsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.width / 2;
    self.photoImageView.clipsToBounds = YES;
}

- (BOOL)shouldUpdateCellWithObject:(PlayerStatisticsTableViewCellObject *)object {
    if (!object.photoUrl) {
        self.photoImageView.image = [UIImage imageNamed:kNoPhotoImageName];
    }
    
    self.nameLabel.text = [NSString stringWithFormat:@"%tu. %@", object.ratingPosition, object.name];
    self.emailLabel.text = object.email;
    self.winratePercent.text = [NSString stringWithFormat:@"%1.2f%%", object.winrate * 100];
    self.winrateProgress.progress = object.winrate;
    
    [self setupNumericDataForLabel:self.scoreLabel
                         diffLabel:self.scoreDiffLabel
                    arrowImageView:self.scoreArrowImageView
                      currentValue:object.score
                         diffValue:object.scoreDiff];
    [self setupNumericDataForLabel:self.winsLabel
                         diffLabel:self.winsDiffLabel
                    arrowImageView:self.winsArrowImageView
                      currentValue:object.wins
                         diffValue:object.winsDiff];
    [self setupNumericDataForLabel:self.lossesLabel
                         diffLabel:self.lossesDiffLabel
                    arrowImageView:self.lossesArrowImageView
                      currentValue:object.losses
                         diffValue:object.lossesDiff];
    
    return YES;
}

- (void)setupNumericDataForLabel:(UILabel *)dataLabel
                       diffLabel:(UILabel *)diffLabel
                  arrowImageView:(UIImageView *)arrowImageView
                    currentValue:(NSUInteger)currentValue
                       diffValue:(NSUInteger)diffValue {
    dataLabel.text = [NSString stringWithFormat:@"%tu", currentValue];
    diffLabel.text = [NSString stringWithFormat:@"%tu", diffValue];
    diffLabel.textColor = diffValue > 0 ? [UIColor prokrutGreenColor] : [UIColor prokrutRedColor];
    NSString *arrowImageName = diffValue > 0 ? kArrowUpImageName : kArrowDownImageName;
    arrowImageView.image = [UIImage imageNamed:arrowImageName];
    
    if (diffValue == 0) {
        arrowImageView.hidden = YES;
        diffLabel.hidden = YES;
    }
}

+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
    return kPlayerStatisticsTableViewCellHeight;
}

@end
