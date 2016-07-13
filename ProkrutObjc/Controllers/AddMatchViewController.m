//
// Created by Tsyganov Stanislav on 12/01/16.
// Copyright (c) 2016 DevAlloy. All rights reserved.
//

#import <Parse/PFObject.h>
#import "AddMatchViewController.h"

#import "ChooseUserViewController.h"
#import "ChooseScoreViewController.h"

#import "AddMatchDataDisplayManager.h"
#import "AlertBuilder.h"

@interface AddMatchViewController() <AddMatchDataDisplayManagerDelegate>

@property (nonatomic, strong) AddMatchDataDisplayManager *addMatchDataDisplayManager;
@property (nonatomic) NSInteger lastUserIndex;
@property (nonatomic) NSInteger lastScoreIndex;
@property (nonatomic) BOOL isNewMatch;

@end

@implementation AddMatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.addMatchDataDisplayManager = [AddMatchDataDisplayManager new];
    self.addMatchDataDisplayManager.ddmDelegate = self;
    self.tableView.dataSource = [self.addMatchDataDisplayManager dataSource];
    self.tableView.delegate = [self.addMatchDataDisplayManager delegate];

    if (self.match) {
        [self updateWithMatch];
        self.isNewMatch = NO;
    } else {
        self.isNewMatch = YES;
        self.match = [PFObject objectWithClassName:@"Match"];
    }

    [self.tableView reloadData];
}

#pragma mark - IBActions
- (IBAction)saveButtonPressed:(id)sender {
    if (![self matchIsValid]) {
        [AlertBuilder showDescriptionAlertInViewController:self
                                                 withTitle:@"Что пошло не так"
                                                   message:@"Неверно указаны данные матча"];
        return;
    }

    if (self.isNewMatch) {
        self.match[@"createdDate"] = [NSDate date];
    }
    self.match[@"seasonId"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentSeasonId"];
    
    [self.match saveEventually];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <AddMatchDataDisplayManagerDelegate>

- (void)playerCellWasPressedAtIndex:(NSInteger)index {
    self.lastUserIndex = index;
    [self performSegueWithIdentifier:@"choosePlayer" sender:self];
}

- (void)scoreCellWasPressed:(NSInteger)index {
    self.lastScoreIndex = index;
    [self performSegueWithIdentifier:@"chooseScore" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"choosePlayer"]) {
        ChooseUserViewController *chooseViewController = segue.destinationViewController;
        chooseViewController.completionBlock = ^(PFUser *user) {
            [self fillMatchWithUser:user];
            [self.addMatchDataDisplayManager updateTitleForUserCellAtIndex:self.lastUserIndex title:user.username];
        };
    } else if ([segue.identifier isEqualToString:@"chooseScore"]) {
        ChooseScoreViewController *chooseViewController = segue.destinationViewController;
        chooseViewController.completionBlock = ^(NSInteger score) {
            [self fillMatchWithScore:score];
            [self.addMatchDataDisplayManager updateTitleForScoreCellAtIndex:self.lastScoreIndex title:[@(score) stringValue]];
        };
    }
}

- (void)updateWithMatch {
    [self.addMatchDataDisplayManager updateTitleForScoreCellAtIndex:0 title:[self.match[@"redTeamScore"] stringValue]];
    [self.addMatchDataDisplayManager updateTitleForScoreCellAtIndex:1 title:[self.match[@"blueTeamScore"] stringValue]];

    [self.addMatchDataDisplayManager updateTitleForUserCellAtIndex:0 title:[self.match[@"firstRedPlayer"] username]];
    [self.addMatchDataDisplayManager updateTitleForUserCellAtIndex:1 title:[self.match[@"secondRedPlayer"] username]];
    [self.addMatchDataDisplayManager updateTitleForUserCellAtIndex:2 title:[self.match[@"firstBluePlayer"] username]];
    [self.addMatchDataDisplayManager updateTitleForUserCellAtIndex:3 title:[self.match[@"secondBluePlayer"] username]];
}

- (void)fillMatchWithUser:(PFUser *)user {
    switch (self.lastUserIndex) {
        case 0:
            self.match[@"firstRedPlayer"] = user;
            break;
        case 1:
            self.match[@"secondRedPlayer"] = user;
            break;
        case 2:
            self.match[@"firstBluePlayer"] = user;
            break;
        case 3:
            self.match[@"secondBluePlayer"] = user;
            break;
        default:
            break;
    }
}

- (void)fillMatchWithScore:(NSInteger)score {
    switch (self.lastScoreIndex) {
        case 0:
            self.match[@"redTeamScore"] = @(score);
            break;
        case 1:
            self.match[@"blueTeamScore"] = @(score);
            break;
        default:
            break;
    }
}

- (void)needsUpdateTable {
    self.tableView.delegate = [self.addMatchDataDisplayManager delegate];
    self.tableView.dataSource = [self.addMatchDataDisplayManager dataSource];
    [self.tableView reloadData];
}

- (BOOL)matchIsValid {
    if (self.match[@"firstRedPlayer"] == nil ||
        self.match[@"secondRedPlayer"] == nil ||
        self.match[@"firstBluePlayer"] == nil ||
        self.match[@"secondBluePlayer"] == nil) {
        return NO;
    }
    
    NSArray * players = @[self.match[@"firstRedPlayer"],
                          self.match[@"secondRedPlayer"],
                          self.match[@"firstBluePlayer"],
                          self.match[@"secondBluePlayer"]];
    
    NSArray *playerNames = [players valueForKeyPath:@"@unionOfObjects.username"];
    NSSet *setPlayerNames = [NSSet setWithArray:playerNames];
    
    if (setPlayerNames.count != playerNames.count) {
        NSLog(@"пользователи повторяются");
        return NO;
    }
    
    NSInteger redScore = [self.match[@"redTeamScore"] integerValue];
    NSInteger blueScore = [self.match[@"blueTeamScore"] integerValue];
    if (redScore != 8 && blueScore != 8) {
        NSLog(@"Один из счетов должен быть 8");
        return NO;
    } else if (redScore == 8 && blueScore == 8) {
        NSLog(@"Оба счета равны 8");
        return NO;
    }
    
    return YES;
}

@end