//
//  StatisticsSeparatorTableViewCell.m
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 27/10/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "StatisticsSeparatorTableViewCell.h"

static CGFloat const kStatisticsSeparatorTableViewCellHeight = 11.0f;

@implementation StatisticsSeparatorTableViewCell

+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
    return kStatisticsSeparatorTableViewCellHeight;
}

@end
