//
//  AllStatsCell.m
//  ProkrutObjc
//
//  Created by Maxim Savushkin on 30/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "AllStatsCell.h"
#import "AllStatsCellObject.h"
#import "AllUserStats.h"

@implementation AllStatsCell

- (BOOL)shouldUpdateCellWithObject:(AllStatsCellObject *)object {
  AllUserStats *stats = object.stats;
  self.userNameTitle.text = stats.user.username;
  self.winsLable.text = [NSString stringWithFormat:@"%zd", stats.wins];
  self.losesLabel.text = [NSString stringWithFormat:@"%zd", stats.looses];
  self.winrateLabel.text = [NSString stringWithFormat:@"%.2f%%", stats.winrate * 100];
  self.pointsLabel.text = [NSString stringWithFormat:@"%zd", stats.points];
  self.pointsPerMatch.text = [NSString stringWithFormat:@"%.2f", stats.pointsPerMatch];
  self.starsLabel.text = [NSString stringWithFormat:@"%zd", stats.stars];
  self.antiStarsLabel.text = [NSString stringWithFormat:@"%zd", stats.antiStars];
  [self tuneChangesByStats:stats];
  return YES;
}

- (void)tuneChangesByStats:(AllUserStats *)stats {
  AllUserStats *lastStats = stats.lastDateStats;
  
  UIColor *positiveColor = [UIColor colorWithRed:34./255 green:192./255 blue:100./255 alpha:1];
  UIColor *negativeColor = [UIColor colorWithRed:1 green:83./255 blue:83./255 alpha:1];
  
  [self tuneLabel:self.starsChange byStats:lastStats withPropertyName:@"stars"];
  [self tuneLabel:self.antiStarsChange byStats:lastStats withPropertyName:@"antiStars"];
  [self tuneLabel:self.winsChange byStats:lastStats withPropertyName:@"wins"];
  [self tuneLabel:self.losesChange byStats:lastStats withPropertyName:@"looses"];
  [self tuneLabel:self.pointsChange byStats:lastStats withPropertyName:@"points"];
  
  NSInteger currentMatchCount = stats.wins + stats.looses;
  NSInteger matchCountWithoutLastDate = lastStats.wins + lastStats.looses;
  NSInteger deltaMatches = currentMatchCount - matchCountWithoutLastDate;
  
  CGFloat currentWinrate = stats.winrate;
  CGFloat winRateWithoutLastDate = (CGFloat)(stats.wins - lastStats.wins) / deltaMatches;
  
  CGFloat deltaWinRate = currentWinrate - winRateWithoutLastDate;
  if (deltaWinRate != 0) {
    self.winrateChange.text = [NSString stringWithFormat:@" (%.2f%%)", deltaWinRate * 100];
    self.winrateChange.textColor = deltaWinRate > 0 ? positiveColor : negativeColor;
  } else {
    self.winrateChange.text = @"";
  }
  
  CGFloat currentPointPerMatch = stats.pointsPerMatch;
  CGFloat pointsPerMatchWithoutLastDate = (CGFloat)(stats.points - lastStats.points) / deltaMatches;
  
  CGFloat deltaPointsPerMatch = currentPointPerMatch - pointsPerMatchWithoutLastDate;
  if (deltaPointsPerMatch != 0) {
    self.pountsPerMatchChange.text = [NSString stringWithFormat:@" (%.2f)", deltaPointsPerMatch];
    self.pountsPerMatchChange.textColor = deltaPointsPerMatch > 0 ? positiveColor : negativeColor;
  } else {
    self.pountsPerMatchChange.text = @"";
  }
}

- (void)tuneLabel:(UILabel *)label
          byStats:(AllUserStats *)stat
 withPropertyName:(NSString *)propertyName {
  NSInteger value = [[stat valueForKey:propertyName] integerValue];
  if (value > 0) {
    label.text = [NSString stringWithFormat:@" (%zd)", value];
  } else {
    label.text = @"";
  }
}

@end
