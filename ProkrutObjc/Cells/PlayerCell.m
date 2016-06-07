//
// Created by Tsyganov Stanislav on 12/01/16.
// Copyright (c) 2016 DevAlloy. All rights reserved.
//

#import "PlayerCell.h"

#import "PlayerCellObject.h"

@interface PlayerCell ()

@property (weak, nonatomic) IBOutlet UILabel *cellTitle;

@end

@implementation PlayerCell

#pragma mark - <NICell>

- (BOOL)shouldUpdateCellWithObject:(PlayerCellObject *)object {
//    [self updateFonts];
//
//    RDNDrawerTableViewCellObject *cellObject = (RDNDrawerTableViewCellObject *)object;
//    [self showSeparator:cellObject.isShowingSeparator];
//    self.labelText.text = cellObject.title;

    self.cellTitle.text = object.title;
    
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
//    return RDNDrawerTableViewCellHeight;
    return 100.f;
}

@end