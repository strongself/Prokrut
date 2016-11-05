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
static NSString *const kArrowGreenUpImageName = @"arrow-green-up";
static NSString *const kArrowGreenDownImageName = @"arrow-green-down";
static NSString *const kArrowRedUpImageName = @"arrow-red-up";
static NSString *const kArrowRedDownImageName = @"arrow-red-down";

typedef NS_ENUM(NSUInteger, StatisticsDiffStyle) {
    StatisticsDiffDefaultStyle = 0,
    StatisticsDiffRevertStyle = 1
};

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
                         diffValue:object.scoreDiff
                         diffStyle:StatisticsDiffDefaultStyle];
    [self setupNumericDataForLabel:self.starLabel
                         diffLabel:self.starDiffLabel
                    arrowImageView:self.starArrowImageView
                      currentValue:object.stars
                         diffValue:object.starsDiff
                         diffStyle:StatisticsDiffDefaultStyle];
    [self setupNumericDataForLabel:self.antistarLabel
                         diffLabel:self.antistarDiffLabel
                    arrowImageView:self.antistarArrowImageView
                      currentValue:object.antistars
                         diffValue:object.antistarsDiff
                         diffStyle:StatisticsDiffRevertStyle];
    
    return YES;
}

- (void)setupNumericDataForLabel:(UILabel *)dataLabel
                       diffLabel:(UILabel *)diffLabel
                  arrowImageView:(UIImageView *)arrowImageView
                    currentValue:(NSUInteger)currentValue
                       diffValue:(NSUInteger)diffValue
                       diffStyle:(StatisticsDiffStyle)diffStyle {
    UIColor *upColor = diffStyle == StatisticsDiffDefaultStyle ? [UIColor prokrutGreenColor] : [UIColor prokrutRedColor];
    UIColor *downColor = diffStyle == StatisticsDiffDefaultStyle ? [UIColor prokrutRedColor] : [UIColor prokrutGreenColor];
    
    NSString *upArrowImageName = diffStyle == StatisticsDiffDefaultStyle ? kArrowGreenUpImageName : kArrowRedUpImageName;
    NSString *downArrowImageName = diffStyle == StatisticsDiffDefaultStyle ? kArrowGreenDownImageName : kArrowRedDownImageName;
    
    dataLabel.text = [NSString stringWithFormat:@"%tu", currentValue];
    diffLabel.text = [NSString stringWithFormat:@"%tu", diffValue];
    diffLabel.textColor = diffValue > 0 ? upColor : downColor;
    NSString *arrowImageName = diffValue > 0 ? upArrowImageName : downArrowImageName;
    arrowImageView.image = [UIImage imageNamed:arrowImageName];
    
    if (diffValue == 0) {
        arrowImageView.hidden = YES;
        diffLabel.hidden = YES;
    } else {
        arrowImageView.hidden = NO;
        diffLabel.hidden = NO;
    }
}

+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
    return kPlayerStatisticsTableViewCellHeight;
}

@end
