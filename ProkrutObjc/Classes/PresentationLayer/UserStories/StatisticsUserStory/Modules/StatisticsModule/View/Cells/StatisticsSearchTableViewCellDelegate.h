//
//  StatisticsSearchTableViewCellDelegate.h
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 05/11/2016.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StatisticsSearchTableViewCellDelegate <NSObject>

- (void)didUpdateSearchBarWithTerm:(NSString *)term;

@end
