//
//  SettingsViewController.m
//  Lunchtime
//
//  Created by Alex on 2015-11-17.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "ConfigurationViewController.h"
#import "Lunchtime-Swift.h"
#import "LunchtimeNotification.h"
#import "User.h"

static NSString *kAlertTitle = @"This will delete all restaurant data and reset all settings.";
static NSString *kDistanceLabel = @"Search Distance";

static NSString *kSegueToOnboardingFlowAfterDestruction = @"segueToOnboardingFlowAfterDestruction";
static NSString *kUserCreatedFlag = @"USER_CREATED";

@interface ConfigurationViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *lunchtimeDatePicker;
@property (nonatomic, weak) IBOutlet UISegmentedControl *priceLimitSegmentedControl;
@property (nonatomic, weak) IBOutlet UISlider *distanceSlider;
@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;

@property (nonatomic) User *user;

@end

@implementation ConfigurationViewController

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
    [self configureLayout];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self commitRealmChanges];
}

#pragma mark - Actions
- (IBAction)distanceSliderValueDidChange:(UISlider *)sender {
    NSNumber *distance = [NSNumber numberWithInt:(int)self.distanceSlider.value];
    self.distanceLabel.text = [NSString stringWithFormat:@"%@ (%@ meters)", kDistanceLabel, [distance stringValue]];
}

#pragma mark - Data
- (void)configureLayout {
    self.distanceSlider.value = [self.user.preferredDistance floatValue];
    self.distanceLabel.text = [NSString stringWithFormat:@"%@ (%@ meters)", kDistanceLabel, [self.user.preferredDistance stringValue]];
    self.priceLimitSegmentedControl.selectedSegmentIndex = self.user.priceLimit;
    self.lunchtimeDatePicker.date = self.user.lunchtime;
    self.lunchtimeDatePicker.datePickerMode = UIDatePickerModeTime;
}

- (void)commitRealmChanges {
    if ([RLMRealm defaultRealm].isEmpty) {
        return;
    }

    [[RLMRealm defaultRealm] beginWriteTransaction];
    [self.user setPreferredDistance:[NSNumber numberWithFloat:self.distanceSlider.value]];
    [self.user setPriceLimit:(unsigned)self.priceLimitSegmentedControl.selectedSegmentIndex];
    [self.user setLunchtime:self.lunchtimeDatePicker.date];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

#pragma mark - <UITableViewDataSource>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 4:
        {
            UIAlertController *alert = [[UIAlertController alloc] initWithTitle:kAlertTitle preferredStyle:UIAlertControllerStyleActionSheet];
            [alert addCancelAction:@"Cancel" handler:nil];
            [alert addDestructiveActionWithTitle:@"Erase All Restaurant Data" handler:^{


                NSLog(@"%@", [User objectForPrimaryKey:@1]);
                RLMRealm *realm = [RLMRealm defaultRealm];
                [realm beginWriteTransaction];
                [realm deleteAllObjects];
                [realm commitWriteTransaction];
                

                [self performSegueWithIdentifier:kSegueToOnboardingFlowAfterDestruction sender:self];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserCreatedFlag];
            }];

            [self presentViewController:alert animated:YES completion:nil];
        }
            break;
        default:
            NSLog(@"Default state");
            break;
    }
}

@end
