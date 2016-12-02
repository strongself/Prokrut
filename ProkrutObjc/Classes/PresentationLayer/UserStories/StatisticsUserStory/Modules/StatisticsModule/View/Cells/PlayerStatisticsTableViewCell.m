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
#import "LetterAvatarFactory.h"

static CGFloat const kPlayerStatisticsTableViewCellHeight = 226.0f;
static NSString *const kNoPhotoImageName = @"no-avatar";
static NSString *const kArrowUpImageName = @"arrow-up";
static NSString *const kArrowDownImageName = @"arrow-down";

typedef NS_ENUM(NSUInteger, StatisticsDiffStyle) {
    StatisticsDiffDefaultStyle = 0,
    StatisticsDiffRevertStyle = 1
};

@implementation PlayerStatisticsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (BOOL)shouldUpdateCellWithObject:(PlayerStatisticsTableViewCellObject *)object {
    LetterAvatarFactory *factory = [LetterAvatarFactory new];
    UIView *view = [factory generateAvatarForName:object.name];
    [self.letterAvatar addSubview:view];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%tu. %@", object.ratingPosition, object.name];
    self.emailLabel.text = object.email;
    self.winratePercent.text = [NSString stringWithFormat:@"%1.2f%%", object.winrate * 100];
    self.winrateProgress.progress = object.winrate;

    NSNumber *winrateDiff = @(object.winrateDiff);
    NSString *winrateDiffString = [NSString stringWithFormat:@"%1.2f%%", fabs(object.winrateDiff) * 100];
    
    [self setupNumericDataForLabel:nil
                         diffLabel:self.winrateDiffLabel
                    arrowImageView:self.winrateArrowImageView
                      currentValue:@(object.winrate)
                         diffValue:winrateDiff
                        diffString:winrateDiffString
                         diffStyle:StatisticsDiffDefaultStyle];
    [self setupNumericDataForLabel:self.scoreLabel
                         diffLabel:self.scoreDiffLabel
                    arrowImageView:self.scoreArrowImageView
                      currentValue:@(object.score)
                         diffValue:@(object.scoreDiff)
                        diffString:@(object.scoreDiff).stringValue
                         diffStyle:StatisticsDiffDefaultStyle];
    [self setupNumericDataForLabel:self.starLabel
                         diffLabel:self.starDiffLabel
                    arrowImageView:self.starArrowImageView
                      currentValue:@(object.stars)
                         diffValue:@(object.starsDiff)
                        diffString:@(object.starsDiff).stringValue
                         diffStyle:StatisticsDiffDefaultStyle];
    [self setupNumericDataForLabel:self.antistarLabel
                         diffLabel:self.antistarDiffLabel
                    arrowImageView:self.antistarArrowImageView
                      currentValue:@(object.antistars)
                         diffValue:@(object.antistarsDiff)
                        diffString:@(object.antistarsDiff).stringValue
                         diffStyle:StatisticsDiffRevertStyle];
    
    return YES;
}

- (void)setupNumericDataForLabel:(UILabel *)dataLabel
                       diffLabel:(UILabel *)diffLabel
                  arrowImageView:(UIImageView *)arrowImageView
                    currentValue:(NSNumber *)currentValue
                       diffValue:(NSNumber *)diffValue
                      diffString:(NSString *)diffString
                       diffStyle:(StatisticsDiffStyle)diffStyle {
    UIColor *upColor = diffStyle == StatisticsDiffDefaultStyle ? [UIColor prokrutGreenColor] : [UIColor prokrutRedColor];
    UIColor *downColor = diffStyle == StatisticsDiffDefaultStyle ? [UIColor prokrutRedColor] : [UIColor prokrutGreenColor];
    
    dataLabel.text = currentValue.stringValue;
    diffLabel.text = diffString;
    diffLabel.textColor = diffValue.floatValue > 0 ? upColor : downColor;
    NSString *arrowImageName = diffValue.floatValue > 0 ? kArrowUpImageName : kArrowDownImageName;
    UIImage *arrowImage = [UIImage imageNamed:arrowImageName];
    arrowImageView.image = [arrowImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    arrowImageView.tintColor = diffValue.floatValue > 0 ? upColor : downColor;
    
    if (diffValue.floatValue == 0) {
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
