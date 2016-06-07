//
//  UserStatiscticsCellObject.m
//  ProkrutObjc
//
//  Created by Tsyganov Stanislav on 15/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "UserStatiscticsCellObject.h"

#import "UserStatisticsCell.h"

@implementation UserStatiscticsCellObject

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([UserStatisticsCell class]) bundle:[NSBundle mainBundle]];
}

- (Class)cellClass {
    return [UserStatisticsCell class];
}

@end
