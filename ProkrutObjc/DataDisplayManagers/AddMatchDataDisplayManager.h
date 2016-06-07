//
// Created by Tsyganov Stanislav on 12/01/16.
// Copyright (c) 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AddMatchDataDisplayManagerDelegate <NSObject>

- (void)needsUpdateTable;
- (void)playerCellWasPressedAtIndex:(NSInteger)index;
- (void)scoreCellWasPressed:(NSInteger)index;

@end

@interface AddMatchDataDisplayManager : NSObject

@property (nonatomic, weak) id<AddMatchDataDisplayManagerDelegate> ddmDelegate;

- (id<UITableViewDataSource>)dataSource;
- (id<UITableViewDelegate>)delegate;

- (void)updateTitleForUserCellAtIndex:(NSInteger)index title:(NSString *)title;
- (void)updateTitleForScoreCellAtIndex:(NSInteger)index title:(NSString *)title;

@end