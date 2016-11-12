//
//  ROSPlayerProfileROSPlayerProfileViewInput.h
//  Prokrut
//
//  Created by Karpushin Artem on 12/11/2016.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AllUserStats;

NS_ASSUME_NONNULL_BEGIN

@protocol PlayerProfileViewInput <NSObject>

@required

/**
 @author Karpushin Artem

 Метод настраивает view
 */
- (void)setupWithPlayerStats:(AllUserStats *)stats;

@end

NS_ASSUME_NONNULL_END
