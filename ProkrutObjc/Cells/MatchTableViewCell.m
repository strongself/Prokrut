//
//  MatchTableViewCell.m
//  ProkrutObjc
//
//  Created by Tsyganov Stanislav on 17/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "MatchTableViewCell.h"

#import "MatchCellObject.h"

@implementation MatchTableViewCell

- (BOOL)shouldUpdateCellWithObject:(MatchCellObject *)object {
    self.firstRedLabel.text = object.firstRedPlayer;
    self.secondRedLabel.text = object.secondRedPlayer;
    self.firstBlueLabel.text = object.firstBluePlayer;
    self.secondBlueLabel.text = object.secondBluePlayer;
    self.redScoreLabel.text = object.redScore;
    self.blueScoreLabel.text = object.blueScore;
    return YES;
}

@end
