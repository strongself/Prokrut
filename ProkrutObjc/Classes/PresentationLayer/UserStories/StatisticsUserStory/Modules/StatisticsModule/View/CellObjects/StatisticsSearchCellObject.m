//
//  StatisticsSearchCellObject.m
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 05/11/2016.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "StatisticsSearchCellObject.h"
#import "StatisticsSearchTableViewCell.h"

@implementation StatisticsSearchCellObject

#pragma mark - <NINibCellObject>

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([StatisticsSearchTableViewCell class]) bundle:[NSBundle mainBundle]];
}

- (Class)cellClass {
    return [StatisticsSearchTableViewCell class];
}


@end
