//
//  ViewController.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-13.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "HomeViewController.h"
#import "Lunchtime-Swift.h"
#import "LunchtimeLocationManager.h"
#import "CurrentRestaurantView.h"
#import "Realm+Convenience.h"
#import "BlockedRestaurantsFilter.h"
#import "LunchtimeMaps.h"
#import "FoursquareAPI.h"
#import "User.h"

static NSString *kLocationLabelConstant = @"Proximity to restaurants is based off of \n your last known location.";
static NSString *kSuggestionLabelConstant = @"We think you're going to like\n";
static NSString *kCheckedInLabelConstant = @"We have checked you in at";

@interface HomeViewController () <LunchtimeLocationManagerDelegate, FoursquareAPIDelegate>

@property (nonatomic, weak) IBOutlet UIButton *checkInOutButton;
@property (nonatomic, weak) IBOutlet UIButton *somethingElseButton;
@property (nonatomic, weak) IBOutlet UIButton *blockButton;
@property (nonatomic, weak) IBOutlet UILabel *locationLabel;

@property (nonatomic, weak) IBOutlet UIView *restaurantViewContainer;
@property (nonatomic, weak) CurrentRestaurantView *restaurantView;

@property (nonatomic) LunchtimeLocationManager *locationManager;

@property (nonatomic) NSMutableArray *restaurants;
@property (nonatomic) Restaurant *currentRestaurant;

@property (nonatomic) BOOL shouldDisplayMapsButton;
@property (nonatomic) BOOL hasUserCheckedIn;
@property (nonatomic) BOOL hasReceivedDataBack;

@end

@implementation HomeViewController

#pragma mark - View Instantiation
- (void)loadView {
    [super loadView];

    [self setRestaurantView:[[CurrentRestaurantView alloc] init]];
    [self.restaurantViewContainer addSubview:self.restaurantView];
    [self.restaurantView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.restaurantView addConstraintsTo:self.restaurantView onContainingView:self.restaurantViewContainer];
}

#pragma mark - Controller Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self instantiateLocationManager];
    [self setupNotificationCenter];
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
- (void)setupNotificationCenter {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openInMapsButtonPressed) name:kOpenInMapsButtonPressed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadButtonPressed) name:kReloadButtonPressed object:nil];
}

- (void)launchSetup {
    [self setHasReceivedDataBack:NO];
    [self.restaurantView.headerTextLabel setText:@"Fetching..."];
    [self.restaurantView.openInMapsButton setHidden:YES];
    [self setShouldDisplayMapsButton:NO];
    [self setHasReceivedDataBack:NO];
    [self setHasUserCheckedIn:NO];
}

- (void)instantiateLocationManager {
    [self setLocationManager:[LunchtimeLocationManager defaultManager]];
    [self.locationManager setDelegate:self];

    [self.locationManager start];
}

#pragma mark - Update/Configure UI Methods
- (void)reloadHeaderLabel {

    if (self.shouldDisplayMapsButton) {
        [self.restaurantView.headerTextLabel setText:[self headerTextLabelWithStateConstant:kCheckedInLabelConstant]];
    } else {
        [self.restaurantView.headerTextLabel setText:[self headerTextLabelWithStateConstant:kSuggestionLabelConstant]];
    }
}

- (void)configureLocationLabel {
    [LunchtimeGeocoder reverseGeocodeRequestWithCoordinate:self.locationManager.currentLocation.coordinate handler:^(CLPlacemark *placemark) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.locationLabel setText:[NSString stringWithFormat:@"%@", placemark.thoroughfare]];
        });
    }];
}

#pragma mark - Actions
- (void)openInMapsButtonPressed {
    [LunchtimeMaps openInMapsWithAddress:self.currentRestaurant.address];
}

- (void)reloadButtonPressed {
    [self launchSetup];
    [self.locationManager start];
}

- (IBAction)checkInOutButtonPressed:(UIButton *)sender {

    if (!self.hasUserCheckedIn) {
        [RealmConvenience addRestaurantToSavedArray:self.currentRestaurant];
    }

    [self setShouldDisplayMapsButton:!self.shouldDisplayMapsButton];
    [self setHasUserCheckedIn:!self.hasUserCheckedIn];
    
    [self checkinStatusDidChange];
}

- (IBAction)somethingElseButtonPressed:(UIButton *)sender {
    
    [self.restaurants removeObject:self.currentRestaurant];
    [self newRestaurant];
}

- (IBAction)blockButtonPressed:(UIButton *)sender {
    NSString *title = [NSString stringWithFormat:@"This will block %@ from ever being presented again.", self.currentRestaurant.title];
    UIAlertController *alert = [[UIAlertController alloc] initWithTitle:title preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addCancelAction:@"Cancel" handler:nil];

    [alert addDestructiveActionWithTitle:@"Block Restaurant" handler:^{

        [RealmConvenience addRestaurantToBlacklistedArray:self.currentRestaurant];
        
        if (self.shouldDisplayMapsButton) {
            
            self.shouldDisplayMapsButton = NO;
            [self checkinStatusDidChange];
        }
        
        [self newRestaurant];
    }];

    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - State Selection
- (NSString *)headerTextLabelWithStateConstant:(NSString *)constant {
    if (!self.currentRestaurant.thoroughfare) {
        return [NSString stringWithFormat:@"%@ %@", constant, self.currentRestaurant.title];
    }

    return [NSString stringWithFormat:@"%@ %@ on %@", constant, self.currentRestaurant.title, self.currentRestaurant.thoroughfare];
}

- (void)checkinStatusDidChange {
    if (self.shouldDisplayMapsButton) {
        [self.checkInOutButton setTitle:@"Check me out" forState:UIControlStateNormal];
        [self.restaurantView.openInMapsButton setHidden:NO];
        [self.somethingElseButton setEnabled:NO];
        [self.somethingElseButton setAlpha:0.7];
        [self scheduleEnjoyNotification];
    } else {
        [self.checkInOutButton setTitle:@"Check me in" forState:UIControlStateNormal];
        [self.restaurantView.openInMapsButton setHidden:YES];
        [self.somethingElseButton setEnabled:YES];
        [self.somethingElseButton setAlpha:1.0];
        [self newRestaurant];
    }

    [self reloadHeaderLabel];
}

- (void)newRestaurant {
    [self restaurantObjectAtRandomIndex];
    [self reloadHeaderLabel];
}

#pragma mark - Notifications
- (void)scheduleEnjoyNotification {
    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];

    for (UILocalNotification *notification in notifications) {
        NSDictionary *userInfo = notification.userInfo;

        if ([[userInfo objectForKey:@"notification"] isEqualToString:@"enjoy"]) {
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
        }
    }

    EnjoyNotification *notification = [EnjoyNotification enjoyNotification];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
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

- (void)dispatchFoursquareRequest {
    FoursquareAPI *request = [[FoursquareAPI alloc] initWithLocation:self.locationManager.currentLocation];
    [request setDelegate:self];
    [request findRestaurantsForUser:[User objectForPrimaryKey:@1]];
}

#pragma mark - LunchtimeLocationManagerDelegate
- (void)receivedLocation {
    [self dispatchFoursquareRequest];
}

#pragma mark - FoursquareAPIDelegate
- (void)requestDidFinishWithRestaurants:(NSMutableArray *)restaurants {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.hasReceivedDataBack) {
            return;
        }

        [self configureLocationLabel];
        [self setHasReceivedDataBack:YES];
        [self.locationManager stop];
        [self setRestaurants:[BlockedRestaurantsFilter filterBlockedRestaurantsFromArray:restaurants]];
        [self restaurantObjectAtRandomIndex];
        [self reloadHeaderLabel];
    });
}

@end