//
//  StatisticsModuleStatisticsModuleViewController.h
//  Prokrut
//
//  Created by k.zinovyev on 02/09/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StatisticsModuleViewInput.h"
#import "StatisticsDataDisplayManager.h"

@protocol StatisticsModuleViewOutput;

@interface StatisticsModuleViewController : UIViewController <StatisticsModuleViewInput>

#pragma mark - Зависимости

@property (strong, nonatomic) StatisticsDataDisplayManager *dataDisplayManager;
@property (nonatomic, strong) id<StatisticsModuleViewOutput> output;

@end
