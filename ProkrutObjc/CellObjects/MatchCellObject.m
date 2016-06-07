//
//  MatchCellObject.m
//  ProkrutObjc
//
//  Created by Tsyganov Stanislav on 17/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "MatchCellObject.h"

#import "MatchTableViewCell.h"

@implementation MatchCellObject

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([MatchTableViewCell class]) bundle:[NSBundle mainBundle]];
}

- (Class)cellClass {
    return [MatchTableViewCell class];
}

@end
