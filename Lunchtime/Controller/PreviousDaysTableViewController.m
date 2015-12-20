//
//  PreviousDaysTableViewController.m
//  Lunchtime
//
//  Created by Willow Bumby on 2015-11-15.
//  Copyright © 2015 Lighthouse Labs. All rights reserved.
//

#import "PreviousDaysTableViewController.h"
#import "PreviousDaysMapViewController.h"
#import "Lunchtime-Swift.h"
#import "Restaurant.h"
#import "User.h"

static NSString *kSegueToPreviousDaysMapViewController = @"segueToPreviousDaysMapViewController";
static NSString *kReuseIdentifier = @"previousCell";

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

    UIAlertController *alert = [[UIAlertController alloc] initWithTitle:nil preferredStyle:UIAlertControllerStyleActionSheet];
    Restaurant *restaurant = self.user.savedRestaurants[indexPath.row];
    [alert addCancelAction:@"Cancel" handler:nil];

    [alert addDefaultActionWithTitle:@"I didn't go here" handler:^{
        [RLMRealm removeRestaurantFromSavedArrayAtIndex:indexPath.row];
        [self.tableView reloadData];
    }];

    [alert addDefaultActionWithTitle:@"Open Restaurant in Maps" handler:^{
        [CosmicMaps openInMapsWithAddress:restaurant.address];
    }];

    [self presentViewController:alert animated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LunchtimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];

    Restaurant *restaurant = self.user.savedRestaurants[indexPath.row];
    cell.textLabel.text = restaurant.title;
    cell.detailTextLabel.text = restaurant.thoroughfare;

    return cell;
}

@end
