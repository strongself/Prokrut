//
//  ChooseScoreViewController.m
//  ProkrutObjc
//
//  Created by Tsyganov Stanislav on 15/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "ChooseScoreViewController.h"

#import "NimbusModels.h"

@interface ChooseScoreViewController ()

@property (nonatomic, strong) NITableViewActions *tableViewActions;
@property (nonatomic, strong) NITableViewModel *model;

@end

@implementation ChooseScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createActions];
    [self createScoreCellObjects];
    
    self.tableView.delegate = self.tableViewActions;
    self.tableView.dataSource = self.model;
}

- (void)createActions {
    _tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
    _tableViewActions.tableViewCellSelectionStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self)weakSelf = self;
    [self.tableViewActions attachToClass:[NITitleCellObject class]
                                tapBlock:^BOOL(NITitleCellObject *object, id target,
                                               NSIndexPath *indexPath) {
                                    __strong typeof(self)self = weakSelf;
                                    self.completionBlock(8-indexPath.row);
                                    [self.navigationController popViewControllerAnimated:YES];
                                    return YES;
                                }];
}

- (void)createScoreCellObjects {
    NSMutableArray *contents = [NSMutableArray new];
    for (int i = 8; i >= 0; i--) {
        NITitleCellObject *cellObject = [NITitleCellObject objectWithTitle:[@(i) stringValue]];
        [contents addObject:cellObject];
    }
    self.model = [[NITableViewModel alloc] initWithListArray:contents
                                                    delegate:(id)[NICellFactory class]];
}

@end
