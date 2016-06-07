//
//  SeasonViewController.m
//  ProkrutObjc
//
//  Created by Savushkin Maksim on 17/02/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "SeasonViewController.h"
#import "Parse/Parse.h"
#import "Season.h"

@interface SeasonViewController ()

@property (nonatomic, strong) NSArray <Season *> *seasons;
@property (nonatomic, strong) NSString *currentSeasonId;

@end

@implementation SeasonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentSeasonId = [[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentSeasonId"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    PFQuery *query = [PFQuery queryWithClassName:@"Season"];
    __weak typeof(self) weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        typeof(weakSelf) strongSelf = weakSelf;
        if (objects.count > 0) {
            strongSelf.seasons = [Season seasonsFromExternalRepresentation:objects];
            [strongSelf.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.seasons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCell"];
    }
    Season *season = self.seasons[indexPath.row];
    cell.textLabel.text = season.seasonDescription;
    if ([season.seasonId isEqualToString:self.currentSeasonId]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Season *season = self.seasons[indexPath.row];
    self.currentSeasonId = season.seasonId;
    [[NSUserDefaults standardUserDefaults] setObject:season.seasonId forKey:@"CurrentSeasonId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
}

@end
