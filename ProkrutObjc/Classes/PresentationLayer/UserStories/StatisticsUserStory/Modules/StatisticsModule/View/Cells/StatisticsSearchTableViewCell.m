//
//  StatisticsSearchTableViewCell.m
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 05/11/2016.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "StatisticsSearchTableViewCell.h"
#import "StatisticsSearchCellObject.h"
#import "StatisticsSearchTableViewCellDelegate.h"

static CGFloat const kStatisticsSearchTableViewCellHeight = 46.0f;

@interface StatisticsSearchTableViewCell () <UISearchBarDelegate>

@property (nonatomic, weak) id<StatisticsSearchTableViewCellDelegate> delegate;

@end

@implementation StatisticsSearchTableViewCell

#pragma mark - <NICell>

- (BOOL)shouldUpdateCellWithObject:(StatisticsSearchCellObject *)object {
    self.delegate = object.delegate;
    self.searchBar.delegate = self;
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object
               atIndexPath:(NSIndexPath *)indexPath
                 tableView:(UITableView *)tableView {
    return kStatisticsSearchTableViewCellHeight;
}

#pragma mark - <UISearchBarDelegate>

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.delegate didUpdateSearchBarWithTerm:searchText];
}

@end
