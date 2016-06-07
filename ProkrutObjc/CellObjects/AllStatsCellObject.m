//
//  AllStatsCellObject.m
//  ProkrutObjc
//
//  Created by Maxim Savushkin on 30/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "AllStatsCellObject.h"
#import "AllStatsCell.h"

@implementation AllStatsCellObject

+ (instancetype)cellObjectWithAllStats:(AllUserStats *)stats {
  AllStatsCellObject *result = [[AllStatsCellObject alloc] init];
  result.stats = stats;
  return result;
}

#pragma mark <NINibCellObject, NICellObject>
- (UINib *)cellNib {
  return [UINib nibWithNibName:@"AllStatsCell" bundle:nil];
}

- (Class)cellClass {
  return [AllStatsCell class];
}

@end
