//
//  PreviousDaysTableViewController.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-15.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "PreviousDaysTableViewController.h"
#import "LunchtimeTableViewCell.h"

static NSString *kReuseIdentifier = @"previousCell";

@interface PreviousDaysTableViewController ()

@end

@implementation PreviousDaysTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // Model *model = self.models[indexPath.row];
    // model.address (used for Google Maps search)

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"I know where it is" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Open in Google Maps" style:UIAlertActionStyleDefault handler:nil]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LunchtimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];

    // Model *model = self.models[indexPath.row];
    // cell.textLabel.text = model.title;
    // cell.detailTextLabel.text = model.location;

    return cell;
}

@end
