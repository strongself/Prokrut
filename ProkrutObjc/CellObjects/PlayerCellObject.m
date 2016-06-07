//
// Created by Tsyganov Stanislav on 12/01/16.
// Copyright (c) 2016 DevAlloy. All rights reserved.
//

#import "PlayerCellObject.h"

#import "PlayerCell.h"

@implementation PlayerCellObject

+ (instancetype)cellObjectWithTitle:(NSString *)title {
    PlayerCellObject *cellObject = [[[self class] alloc] init];
    if (cellObject != nil) {
        cellObject.title = title;
    }
    return cellObject;
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([PlayerCell class]) bundle:[NSBundle mainBundle]];
}

- (Class)cellClass {
    return [PlayerCell class];
}

@end