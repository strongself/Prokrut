//
//  StatisticsModuleStatisticsModuleInteractorOutput.h
//  Prokrut
//
//  Created by k.zinovyev on 02/09/2016.
//  Copyright © 2016 Rambler&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StatisticsModuleInteractorOutput <NSObject>

- (void)didObtainStatisticsFromNetworkWithData:(id)statistics
                                         error:(NSError *)error;

@end
