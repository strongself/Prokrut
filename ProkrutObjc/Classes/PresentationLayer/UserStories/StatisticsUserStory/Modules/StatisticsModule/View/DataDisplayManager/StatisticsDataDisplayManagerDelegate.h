//
//  StatisticsDataDisplayManagerDelegate.h
//  ProkrutObjc
//
//  Created by k.zinovyev on 05.09.16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

@class AllUserStats;

@protocol StatisticsDataDisplayManagerDelegate
/**
 @author Artem Karpushin
 
 Оповещает делегата о том, что была нажата ячейка со статистикой игрока
 */
- (void)didSelectCellWithPlayerStats:(AllUserStats *)stats;

@end
