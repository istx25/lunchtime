//
//  ViewController.m
//  Lunchtime
//
//  Created by Willow Bumby on 2015-11-13.
//  Copyright © 2015 Lighthouse Labs. All rights reserved.
//

#import "HomeViewController.h"
#import "UILocalNotification+ScheduleEnjoyNotification.h"
#import "LunchtimeLocationManager.h"
#import "BlockedRestaurantsFilter.h"
#import "Lunchtime-Swift.h"
#import "FoursquareAPI.h"
#import "User.h"

static NSString *kLocationLabelConstant = @"Proximity to restaurants is based off of \n your last known location.";
static NSString *kSuggestionLabelConstant = @"We think you're going to like\n";
static NSString *kCheckedInLabelConstant = @"We have checked you in at";
static NSString *kFetchingLabelConstant = @"Fetching...";

@interface HomeViewController () <LunchtimeLocationManagerDelegate, FoursquareAPIDelegate>

@property (nonatomic, weak) IBOutlet UIButton *checkInOutButton;
@property (nonatomic, weak) IBOutlet UIButton *somethingElseButton;
@property (nonatomic, weak) IBOutlet UIButton *blockButton;
@property (nonatomic, weak) IBOutlet UILabel *locationLabel;

@property (nonatomic) LunchtimeLocationManager *locationManager;

@property (nonatomic) NSMutableArray *restaurants;
@property (nonatomic) Restaurant *currentRestaurant;

@property (nonatomic) BOOL isCheckedIn;
@property (nonatomic) BOOL hasReceivedDataBack;

@property (nonatomic, weak) IBOutlet UIBarButtonItem *reloadButton;
@property (nonatomic, weak) IBOutlet UIButton *openInMapsButton;
@property (nonatomic, weak) IBOutlet UILabel *headerTextLabel;

@end

@implementation HomeViewController

#pragma mark - Controller Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.locationManager = [LunchtimeLocationManager defaultManager];
    self.locationManager.delegate = self;
    [self.locationManager start];

    [self launchSetup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:NO];

    if (!self.restaurants) {
        [self.locationManager start];
    }
}

#pragma mark - Setup Methods
- (void)launchSetup {
    self.hasReceivedDataBack = NO;
    self.isCheckedIn = NO;
    self.headerTextLabel.text = kFetchingLabelConstant;
    self.openInMapsButton.hidden = YES;
}

- (void)reloadLayout {
    if (self.isCheckedIn) {
        [UILocalNotification scheduleEnjoyNotification];
        [self.checkInOutButton setTitle:@"Check me out" forState:UIControlStateNormal];
        self.headerTextLabel.text = [self headerTextLabelWithStateConstant:kCheckedInLabelConstant];
        self.openInMapsButton.hidden = NO;
        self.somethingElseButton.enabled = NO;
        self.somethingElseButton.alpha = 0.7;
    } else {
        [self restaurantObjectAtRandomIndex];
        [self.checkInOutButton setTitle:@"Check me in" forState:UIControlStateNormal];
        self.headerTextLabel.text = [self headerTextLabelWithStateConstant:kSuggestionLabelConstant];
        self.openInMapsButton.hidden = YES;
        self.somethingElseButton.enabled = YES;
        self.somethingElseButton.alpha = 1.0;
    }
}

#pragma mark - Actions
- (IBAction)openInMapsButtonPressed:(UIButton *)sender {
    [CosmicMaps openInMapsWithAddress:self.currentRestaurant.address];
}

- (IBAction)reloadButtonPressed:(UIBarButtonItem *)sender {
    [self reload];
}

- (void)reload {
    [self.locationManager start];
    [self launchSetup];
}

- (IBAction)checkInOutButtonPressed:(UIButton *)sender {
    if (!self.isCheckedIn) {
        [RLMRealm addRestaurantToSavedArray:self.currentRestaurant];
    }

    self.isCheckedIn = !self.isCheckedIn;
    [self reloadLayout];
}

- (IBAction)somethingElseButtonPressed:(UIButton *)sender {
    if (self.restaurants.count <= 1) {
        NSString *title = @"Please Refresh";
        NSString *message = @"We have ran out of places to display. Please refresh for a new list.";

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        alert.view.tintColor = [UIColor blackColor];
        [alert addCancelAction:@"Okay" handler:nil];
        [alert addDefaultActionWithTitle:@"Refresh" handler:^{
            [self reload];
        }];

        [self presentViewController:alert animated:YES completion:^{
            alert.view.tintColor = [UIColor blackColor];
        }];
    }


    [self.restaurants removeObject:self.currentRestaurant];
    [self restaurantObjectAtRandomIndex];
    [self reloadLayout];
}

- (IBAction)blockButtonPressed:(UIButton *)sender {
    NSString *title = [NSString stringWithFormat:@"This will block %@ from ever being presented again.", self.currentRestaurant.title];
    UIAlertController *alert = [[UIAlertController alloc] initWithTitle:title preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addCancelAction:@"Cancel" handler:nil];

    [alert addDestructiveActionWithTitle:@"Block Restaurant" handler:^{
        [RLMRealm addRestaurantToBlacklistedArray:self.currentRestaurant];
        if (self.isCheckedIn) {
            self.isCheckedIn = NO;
        }

        [self restaurantObjectAtRandomIndex];
        [self reloadLayout];
    }];

    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Data Methods
- (void)restaurantObjectAtRandomIndex {
    if (self.restaurants.count <= 0) {
        NSLog(@"The restaurants array is empty.");

        return;
    }

    NSUInteger index = arc4random_uniform((u_int32_t)self.restaurants.count);
    self.currentRestaurant = [self.restaurants objectAtIndex:index];
}

#pragma mark - LunchtimeLocationManagerDelegate
- (void)receivedLocation {
    FoursquareAPI *request = [[FoursquareAPI alloc] initWithLocation:self.locationManager.currentLocation];
    request.delegate = self;
    [request findRestaurantsForUser:[User objectForPrimaryKey:@1]];

    [LunchtimeGeocoder reverseGeocodeRequestWithCoordinate:self.locationManager.currentLocation.coordinate handler:^(CLPlacemark *placemark) {
        [self.locationLabel setText:[NSString stringWithFormat:@"%@", placemark.thoroughfare]];
    }];
}

#pragma mark - FoursquareAPIDelegate
- (void)requestDidFinishWithRestaurants:(NSMutableArray *)restaurants {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.hasReceivedDataBack) {
            return;
        }

        self.hasReceivedDataBack = YES;
        self.restaurants = [BlockedRestaurantsFilter filterBlockedRestaurantsFromArray:restaurants];
        [self restaurantObjectAtRandomIndex];
        [self reloadLayout];
    });

    [self.locationManager stop];
}

#pragma mark - State Selection
- (NSString *)headerTextLabelWithStateConstant:(NSString *)constant {
    if (!self.currentRestaurant.thoroughfare) {
        return [NSString stringWithFormat:@"%@ %@", constant, self.currentRestaurant.title];
    }

    return [NSString stringWithFormat:@"%@ %@ on %@", constant, self.currentRestaurant.title, self.currentRestaurant.thoroughfare];
}

@end