//
//  StatisticsSeparatorCellObject.m
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 27/10/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "StatisticsSeparatorCellObject.h"

#import "StatisticsSeparatorTableViewCell.h"

@implementation StatisticsSeparatorCellObject

#pragma mark - <NINibCellObject>

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([StatisticsSeparatorTableViewCell class]) bundle:[NSBundle mainBundle]];
}

- (Class)cellClass {
    return [StatisticsSeparatorTableViewCell class];
}

@end
