//
//  StatisticsModuleStatisticsModulePresenter.h
//  Prokrut
//
//  Created by k.zinovyev on 02/09/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import "StatisticsModuleViewOutput.h"
#import "StatisticsModuleInteractorOutput.h"
#import "StatisticsModuleModuleInput.h"

@protocol StatisticsModuleViewInput;
@protocol StatisticsModuleInteractorInput;
@protocol StatisticsModuleRouterInput;

@interface StatisticsModulePresenter : NSObject <StatisticsModuleModuleInput, StatisticsModuleViewOutput, StatisticsModuleInteractorOutput>

@property (nonatomic, weak) id<StatisticsModuleViewInput> view;
@property (nonatomic, strong) id<StatisticsModuleInteractorInput> interactor;
@property (nonatomic, strong) id<StatisticsModuleRouterInput> router;
@property (nonatomic, weak) LetterHelper* helpeer;

@end
