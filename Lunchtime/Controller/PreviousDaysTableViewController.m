//
//  PreviousDaysTableViewController.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-15.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "PreviousDaysTableViewController.h"
#import "PreviousDaysMapViewController.h"
#import "LunchtimeTableViewCell.h"
#import "LunchtimeMaps.h"
#import "Restaurant.h"
#import "User.h"

static NSString *kReuseIdentifier = @"previousCell";
static NSString *kSegueToPreviousDaysMapViewController = @"segueToPreviousDaysMapViewController";

@interface PreviousDaysTableViewController ()

@property (nonatomic) User *user;

@end

@implementation PreviousDaysTableViewController

#pragma mark - Controller Lifecycle
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];

    if (self) {
        _user = [User objectForPrimaryKey:@1];
    }

    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSegueToPreviousDaysMapViewController]) {
        PreviousDaysMapViewController *previousDaysMapViewController = [segue destinationViewController];
        previousDaysMapViewController.user = self.user;
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.user.savedRestaurants.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"I know where it is" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Open Restaurant in Maps" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
         Restaurant *restaurant = self.user.savedRestaurants[indexPath.row];
        [[RLMRealm defaultRealm] beginWriteTransaction];
        [LunchtimeMaps openInMapsWithAddress:restaurant.address];
        [[RLMRealm defaultRealm] commitWriteTransaction];
    }]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LunchtimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];

     Restaurant *restaurant = self.user.savedRestaurants[indexPath.row];
     cell.textLabel.text = restaurant.name;
     cell.detailTextLabel.text = restaurant.thoroughfare;

    return cell;
}

@end
