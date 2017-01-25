//
//  ChooseUserViewController.m
//  ProkrutObjc
//
//  Created by Tsyganov Stanislav on 14/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "ChooseUserViewController.h"

#import "NimbusModels.h"

@interface ChooseUserViewController ()

@property (nonatomic, strong) NITableViewActions *tableViewActions;
@property (nonatomic, strong) NITableViewModel *model;
@property (nonatomic, strong) NSArray *users;

@end

@implementation ChooseUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createActions];
    [self receiveUsers:YES];
    
    [self.tableView reloadData];
}

- (void)needToUpdate {
    self.tableView.delegate = [self.tableViewActions forwardingTo:self];
    self.tableView.dataSource = self.model;
    [self.tableView reloadData];
}

- (void)createActions {
    _tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
    _tableViewActions.tableViewCellSelectionStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self)weakSelf = self;
    [self.tableViewActions attachToClass:[NITitleCellObject class]
                                tapBlock:^BOOL(NITitleCellObject *object, id target,
                                               NSIndexPath *indexPath) {
                                    __strong typeof(self)self = weakSelf;
                                    PFUser *user = [self.users objectAtIndex:indexPath.row];
                                    self.completionBlock(user);
                                    [self.navigationController popViewControllerAnimated:YES];
                                    return YES;
                                }];
}

- (void)receiveUsers:(BOOL)fromLocalStorage {
    PFQuery *query = [PFUser query];
//    if (fromLocalStorage) {
//        [query fromLocalDatastore];
//    }
    __weak typeof(self)weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        __strong typeof(self)self = weakSelf;
        if (objects.count == 0 && fromLocalStorage) {
            // пробуем получить из сети
            [self receiveUsers:NO];
        } else {
            NSMutableArray *tableContents = [NSMutableArray new];
            for (PFUser *user in objects) {
                [tableContents addObject:[NITitleCellObject objectWithTitle:user.username]];
            }
            self.model = [[NITableViewModel alloc] initWithListArray:tableContents
                                                            delegate:(id)[NICellFactory class]];
            self.users = objects;
            [PFUser pinAllInBackground:objects];
            [self needToUpdate];
        }
        [self.refreshControl endRefreshing];
    }];
}

- (IBAction)refreshDidPull:(id)sender {
    [self receiveUsers:NO];
}

@end
