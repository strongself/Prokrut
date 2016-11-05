//
//  StatisticsSearchTableViewCell.m
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 05/11/2016.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "StatisticsSearchTableViewCell.h"

static CGFloat const kStatisticsSearchTableViewCellHeight = 46.0f;

@implementation StatisticsSearchTableViewCell

+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
    return kStatisticsSearchTableViewCellHeight;
}

@end
