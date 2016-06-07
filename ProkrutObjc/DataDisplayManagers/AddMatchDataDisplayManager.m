//
// Created by Tsyganov Stanislav on 12/01/16.
// Copyright (c) 2016 DevAlloy. All rights reserved.
//

#import "AddMatchDataDisplayManager.h"

#import "NimbusModels.h"

#import "PlayerCellObject.h"

typedef BOOL(^AddMatchScoreBlock)(id object, id target, NSIndexPath *indexPath);

@interface AddMatchDataDisplayManager() <UITableViewDelegate>

@property (nonatomic, strong) NITableViewActions *tableViewActions;
@property (nonatomic, strong) NITableViewModel *model;
@property (nonatomic, strong) NSArray *playersTitles;
@property (nonatomic, strong) NSArray *scoreTitles;

@end

@implementation AddMatchDataDisplayManager

- (instancetype)init {
    if (self = [super init]) {
        _tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
        _tableViewActions.tableViewCellSelectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self)weakSelf = self;
        [self.tableViewActions attachToClass:[PlayerCellObject class]
                                    tapBlock:^BOOL(PlayerCellObject *object, id target,
                                                   NSIndexPath *indexPath) {
                                        __strong typeof(self)self = weakSelf;
                                        [self.ddmDelegate playerCellWasPressedAtIndex:indexPath.row];
                                        return YES;
                                    }];
        
    }
    return self;
}

- (NSArray *)playersTitles {
    if (!_playersTitles) {
        _playersTitles = @[@"Красный игрок 1", @"Красный игрок 2", @"Синий игрок 1", @"Синий игрок 2"];
    }
    return _playersTitles;
}

- (NSArray *)scoreTitles {
    if (!_scoreTitles) {
        _scoreTitles = @[@"Счет красной команды", @"Счет синей команды"];
    }
    return _scoreTitles;
}

- (id <UITableViewDataSource>)dataSource {
    
    NSMutableArray *tableContents = [NSMutableArray new];
    [tableContents addObject:@"Игроки"];
    
    for (NSString *title in self.playersTitles) {
        PlayerCellObject *cellObject = [self createPlayerCellObjectWithTitle:title];
        [tableContents addObject:cellObject];
    }
    
    [tableContents addObject:@"Счет"];
    AddMatchScoreBlock scoreBlock = ^BOOL(id object, id target, NSIndexPath *indexPath) {
        [self.ddmDelegate scoreCellWasPressed:indexPath.row];
        return YES;
    };
    
    
    for (NSString *title in self.scoreTitles) {
        NITitleCellObject *teamScore = [NITitleCellObject objectWithTitle:title];
        [tableContents addObject:teamScore];
        [self.tableViewActions attachToObject:teamScore
                                     tapBlock:scoreBlock];
    }
    
    [tableContents addObject:@"Детали матча"];

    self.model = [[NITableViewModel alloc] initWithSectionedArray:tableContents
                                                         delegate:(id)[NICellFactory class]];

    return self.model;
}

- (id <UITableViewDelegate>)delegate {
    return self.tableViewActions;
}

- (PlayerCellObject *)createPlayerCellObjectWithTitle:(NSString *)title {
    PlayerCellObject *cellObject = [PlayerCellObject cellObjectWithTitle:title];
    return cellObject;
}

- (void)updateTitleForUserCellAtIndex:(NSInteger)index title:(NSString *)title {
    NSMutableArray *tempPlayerTitles = [self.playersTitles mutableCopy];
    tempPlayerTitles[index] = title;
    self.playersTitles = tempPlayerTitles;
    [self.ddmDelegate needsUpdateTable];
}

- (void)updateTitleForScoreCellAtIndex:(NSInteger)index title:(NSString *)title {
    NSMutableArray *tempScoreTitles = [self.scoreTitles mutableCopy];
    tempScoreTitles[index] = title;
    self.scoreTitles = tempScoreTitles;
    [self.ddmDelegate needsUpdateTable];
}


@end