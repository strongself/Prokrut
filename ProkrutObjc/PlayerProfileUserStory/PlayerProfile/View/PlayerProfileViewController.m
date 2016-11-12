//
//  ROSPlayerProfileROSPlayerProfileViewController.m
//  Prokrut
//
//  Created by Karpushin Artem on 12/11/2016.
//  Copyright © 2016 RAMBLER&Co. All rights reserved.
//

#import "PlayerProfileViewController.h"

#import "PlayerProfileViewOutput.h"
#import "PlayerProfileDataDisplayManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayerProfileViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PlayerProfileViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.output didLoadView];
}

#pragma mark - Методы протокола <ROSPlayerProfileViewInput>

- (void)setupInitialState {
    // В этом методе происходит настройка параметров view, зависящих от ее жизненного цикла (создание элементов, анимации и пр.)
}

@end

NS_ASSUME_NONNULL_END
