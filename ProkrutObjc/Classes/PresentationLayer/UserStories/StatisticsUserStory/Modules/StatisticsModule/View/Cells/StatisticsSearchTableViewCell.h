//
//  StatisticsSearchTableViewCell.h
//  ProkrutObjc
//
//  Created by Egor Tolstoy on 05/11/2016.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Nimbus/NimbusModels.h>

@interface StatisticsSearchTableViewCell : UITableViewCell <NICell>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
