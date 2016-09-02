//
//  StatisticsModuleStatisticsModuleInteractor.h
//  Prokrut
//
//  Created by k.zinovyev on 02/09/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "StatisticsModuleInteractorInput.h"

@protocol StatisticsModuleInteractorOutput;

@interface StatisticsModuleInteractor : NSObject <StatisticsModuleInteractorInput>

@property (nonatomic, weak) id<StatisticsModuleInteractorOutput> output;

@end
