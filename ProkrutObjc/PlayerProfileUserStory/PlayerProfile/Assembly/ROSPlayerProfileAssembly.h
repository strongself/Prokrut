//
//  ROSPlayerProfileROSPlayerProfileAssembly.h
//  Prokrut
//
//  Created by Karpushin Artem on 12/11/2016.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import <Typhoon/Typhoon.h>

#import <RamblerTyphoonUtils/AssemblyCollector.h>

NS_ASSUME_NONNULL_BEGIN

@class ROSPlayerProfileViewController;

/**
@author Karpushin Artem

Профиль игрока
*/
@interface ROSPlayerProfileAssembly : TyphoonAssembly <RamblerInitialAssembly>

/**
 @author Karpushin Artem

 Создает view модуля "Профиль игрока"
*/
- (ROSPlayerProfileViewController *)viewPlayerProfileModule;

@end

NS_ASSUME_NONNULL_END
