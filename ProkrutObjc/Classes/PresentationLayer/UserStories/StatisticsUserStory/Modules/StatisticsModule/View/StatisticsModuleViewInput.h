//
//  StatisticsModuleStatisticsModuleViewInput.h
//  Prokrut
//
//  Created by k.zinovyev on 02/09/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StatisticsModuleViewInput <NSObject>

/**
 @author k.zinovyev

 Метод настраивает начальный стейт view
 */
- (void)setupInitialState;

- (void)updateViewWithStatisticsData:(NSArray *)statisticsData;

- (void)showErrorStateWithError:(NSError *)error;

@end
