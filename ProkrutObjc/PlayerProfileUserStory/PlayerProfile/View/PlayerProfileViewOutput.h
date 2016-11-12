//
//  ROSPlayerProfileROSPlayerProfileViewOutput.h
//  Prokrut
//
//  Created by Karpushin Artem on 12/11/2016.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PlayerProfileViewOutput <NSObject>

@required

/**
 @author Karpushin Artem

 Метод сообщает презентеру о том, что view готов к работе
 */
- (void)didLoadView;

@end

NS_ASSUME_NONNULL_END
