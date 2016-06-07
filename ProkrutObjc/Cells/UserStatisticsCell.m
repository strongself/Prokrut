//
//  UserStatisticsCell.m
//  ProkrutObjc
//
//  Created by Tsyganov Stanislav on 15/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "UserStatisticsCell.h"

#import "UserStatiscticsCellObject.h"

@implementation UserStatisticsCell

- (BOOL)shouldUpdateCellWithObject:(UserStatiscticsCellObject *)object {
    self.userNameTitle.text = object.userStatistics.user.username;
    self.winsLable.text = [@(object.userStatistics.wins) stringValue];
    self.losesLabel.text = [@(object.userStatistics.looses) stringValue];
    self.pointsLabel.text = [@(object.userStatistics.points) stringValue];
    
    double winrateInPercents = (double)object.userStatistics.winrate * 100;
    self.winrateLabel.text = [NSString stringWithFormat:@"%1.2f%%", winrateInPercents];
    self.pointsPerMatch.text = [NSString stringWithFormat:@"%1.2f", object.userStatistics.pointsPerMatch];
    self.starsLabel.text = [@(object.userStatistics.stars) stringValue];
    self.antiStarsLabel.text = [@(object.userStatistics.antiStars) stringValue];
    [self updateChangeTitleWithObject:object];
    
    return YES;
}

- (void)updateChangeTitleWithObject:(UserStatiscticsCellObject *)object {
    BOOL objectExists = object.prevUserStatistics != nil;
    UIColor *clearColor = [UIColor clearColor];
    
    if (objectExists) {
        [self updateIntChangeValueWithCellObject:object propertyName:@"wins" andLabel:self.winsChange reverseColor:NO];
        [self updateIntChangeValueWithCellObject:object propertyName:@"looses" andLabel:self.losesChange reverseColor:YES];
        [self updateIntChangeValueWithCellObject:object propertyName:@"points" andLabel:self.pointsChange reverseColor:NO];
        [self updateIntChangeValueWithCellObject:object propertyName:@"stars" andLabel:self.starsChange reverseColor:NO];
        [self updateIntChangeValueWithCellObject:object propertyName:@"antiStars" andLabel:self.antiStarsChange reverseColor:YES];
        [self updateDoubleChangeValueWithCellObject:object propertyName:@"winrate" andLabel:self.winrateChange inPercents:YES];
        [self updateDoubleChangeValueWithCellObject:object propertyName:@"pointsPerMatch" andLabel:self.pountsPerMatchChange inPercents:NO];
    } else {
        self.losesChange.textColor = clearColor;
        self.winsChange.textColor = clearColor;
    }
}

- (void)updateIntChangeValueWithCellObject:(UserStatiscticsCellObject *)cellObject propertyName:(NSString *)propName andLabel:(UILabel *)label reverseColor:(BOOL)reverseColor {
    OnDateUserStatisctics *curStat = cellObject.userStatistics;
    OnDateUserStatisctics *prevStat = cellObject.prevUserStatistics;
    NSInteger curValue = [[curStat valueForKey:propName] integerValue];
    NSInteger prevValue = [[prevStat valueForKey:propName] integerValue];
    NSInteger deltaValue = curValue - prevValue;
    if (deltaValue == 0) {
        label.textColor = [UIColor clearColor];
        return;
    }
    
    label.text = [NSString stringWithFormat:@" (%@)", [@(deltaValue) stringValue]];
    UIColor *greenColor = [UIColor colorWithRed:6.f/255.f green:117.f/255.f blue:20.f/255.f alpha:1.f];
    UIColor *redColor = [UIColor colorWithRed:151.f/255.f green:15.f/255.f blue:8.f/255.f alpha:1.f];
    label.textColor = ((deltaValue > 0) & !reverseColor) ? greenColor : redColor;
}

- (void)updateDoubleChangeValueWithCellObject:(UserStatiscticsCellObject *)cellObject propertyName:(NSString *)propName andLabel:(UILabel *)label inPercents:(BOOL)inPercents {
    OnDateUserStatisctics *curStat = cellObject.userStatistics;
    OnDateUserStatisctics *prevStat = cellObject.prevUserStatistics;
    double curValue = [[curStat valueForKey:propName] doubleValue];
    double prevValue = [[prevStat valueForKey:propName] doubleValue];
    double deltaValue = curValue - prevValue;
    if (fabs(deltaValue) < 0.001) {
        label.textColor = [UIColor clearColor];
        return;
    }
    
    if (inPercents) {
        label.text = [NSString stringWithFormat:@" (%1.2f%%)", deltaValue * 100];
    } else {
        label.text = [NSString stringWithFormat:@" (%1.2f)", deltaValue];
    }
    UIColor *greenColor = [UIColor colorWithRed:6.f/255.f green:117.f/255.f blue:20.f/255.f alpha:1.f];
    UIColor *redColor = [UIColor colorWithRed:151.f/255.f green:15.f/255.f blue:8.f/255.f alpha:1.f];
    label.textColor = deltaValue > 0 ? greenColor : redColor;
}

@end
