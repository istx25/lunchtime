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
#import "LunchtimeGeocoder.h"
#import "LunchtimeMaps.h"
#import "FoursquareAPI.h"
#import "User.h"

static NSString *kLocationLabelConstant = @"Proximity to restaurants is based off of \n your last known location.";
static NSString *kSuggestionLabelConstant = @"We think you're going to like\n";
static NSString *kCheckedInLabelConstant = @"We have checked you in at";

@interface HomeViewController () <LunchtimeLocationManagerDelegate>

// Custom CurrentRestaurantView Properties
@property (nonatomic, weak) IBOutlet UIView *currentRestaurantViewContainer;
@property (nonatomic) CurrentRestaurantView *currentRestaurantView;

// Controller Outlets
@property (nonatomic, weak) IBOutlet UILabel *locationLabel;
@property (nonatomic, weak) IBOutlet UIButton *checkInOutButton;
@property (nonatomic, weak) IBOutlet UIButton *somethingElseButton;
@property (nonatomic, weak) IBOutlet UIButton *blockButton;

@property (nonatomic) BOOL shouldHideOpenInMapsButton;
@property (nonatomic) BOOL isCheckedIn;

// Model Properties
@property (nonatomic) LunchtimeLocationManager *locationManager;
@property (nonatomic) RLMResults<Restaurant *> *restaurants;
@property (nonatomic) RLMNotificationToken *token;
@property (nonatomic) Restaurant *currentRestaurant;

@end

@implementation HomeViewController

#pragma mark - View Instantiation
- (void)loadView {
    [super loadView];

    [self setCurrentRestaurantView:[[CurrentRestaurantView alloc] init]];
    [self.currentRestaurantViewContainer addSubview:self.currentRestaurantView];
    [self.currentRestaurantView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.currentRestaurantView addConstraintsTo:self.currentRestaurantView onContainingView:self.currentRestaurantViewContainer];
}

#pragma mark - Controller Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setShouldHideOpenInMapsButton:YES];
    [self checkInStatusDidChange];
    [self setLocationManager:[LunchtimeLocationManager defaultManager]];
    [self.locationManager setDelegate:self];
    [self.locationManager setup];
    [self.locationManager start];
    [self setupUI];

    self.token = [[RLMRealm defaultRealm] addNotificationBlock:^(NSString *notification, RLMRealm *realm) {
        [self updateUI];
    }];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openInMapsButtonPressed) name:kOpenInMapsButtonPressed object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - Setup
- (void)setupUI {
    [self.currentRestaurantView.headerTextLabel setText:@"Fetching..."];
    [self setRestaurants:[Restaurant allObjects]];
    [self restaurantObjectAtRandomIndex];
}

- (void)configureLayout {
    CLLocationCoordinate2D coordinate = self.locationManager.currentLocation.coordinate;
    LunchtimeGeocoder *geocoder = [LunchtimeGeocoder new];
    [geocoder reverseGeocodeLocationWithCoordinate:coordinate withCompletionHandler:^(CLPlacemark *placemark) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.locationLabel setText:[NSString stringWithFormat:@"%@", placemark.thoroughfare]];
        });
    }];
}

#pragma mark - Convenience Update View Methods
- (void)updateUIWithNewRestaurantObject {
    [self restaurantObjectAtRandomIndex];
    [self updateUI];
}

- (void)updateUI {
    if ([User objectForPrimaryKey:@1].isInvalidated) {
        return;
    }

    if (self.shouldHideOpenInMapsButton) {
        if (self.currentRestaurant.thoroughfare) {
            NSString *headerText = [NSString stringWithFormat:@"%@ %@ on %@", kSuggestionLabelConstant, self.currentRestaurant.title, self.currentRestaurant.thoroughfare];
            [self.currentRestaurantView.headerTextLabel setText:headerText];

            return;
        }

        [self.currentRestaurantView.headerTextLabel setText:[NSString stringWithFormat:@"%@ %@", kSuggestionLabelConstant, self.currentRestaurant.title]];
    }

    if (!self.shouldHideOpenInMapsButton) {
        if (self.currentRestaurant.thoroughfare) {
            NSString *headerText = [NSString stringWithFormat:@"%@ %@ on %@", kCheckedInLabelConstant, self.currentRestaurant.title, self.currentRestaurant.thoroughfare];
            [self.currentRestaurantView.headerTextLabel setText:headerText];

            return;
        }

        [self.currentRestaurantView.headerTextLabel setText:[NSString stringWithFormat:@"%@ %@", kCheckedInLabelConstant, self.currentRestaurant.title]];
    }
}

#pragma mark - Actions
- (void)openInMapsButtonPressed {
    [LunchtimeMaps openInMapsWithAddress:self.currentRestaurant.address];
}

- (IBAction)checkInOutButtonPressed:(UIButton *)sender {
    [self setShouldHideOpenInMapsButton:!self.shouldHideOpenInMapsButton];
    [RealmConvenience addRestaurantToSavedArray:self.currentRestaurant];
    [self checkInStatusDidChange];
    [self setEnjoyNotification];
}

- (IBAction)somethingElseButtonPressed:(UIButton *)sender {
    [self updateUIWithNewRestaurantObject];
}

- (IBAction)blockButtonPressed:(UIButton *)sender {
    NSString *alertTitle = [NSString stringWithFormat:@"This will block %@ from ever being presented again.", self.currentRestaurant.title];
    UIAlertController *alert = [[UIAlertController alloc] initWithTitle:alertTitle preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addCancelAction:@"Cancel" handler:nil];
    [alert addDestructiveActionWithTitle:@"Block Restaurant" handler:^{
        [self setShouldHideOpenInMapsButton:!self.shouldHideOpenInMapsButton];
        [RealmConvenience addRestaurantToBlacklistedArray:self.currentRestaurant];
        
        if (self.isCheckedIn) {
            [self checkInStatusDidChange];
        }
    }];

    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Data
- (void)restaurantObjectAtRandomIndex {
    if (0 < self.restaurants.count > 0) {
        NSUInteger index = arc4random_uniform((u_int32_t)self.restaurants.count);
        self.currentRestaurant = [self.restaurants objectAtIndex:index];
    }
}

- (void)checkInStatusDidChange {
    if (self.shouldHideOpenInMapsButton) {
        [self.currentRestaurantView.openInMapsButton setHidden:YES];
        [self.checkInOutButton setTitle:@"Check me in" forState:UIControlStateNormal];
        [self updateUIWithNewRestaurantObject];
        [self.somethingElseButton setEnabled:YES];
        [self.somethingElseButton setAlpha:1.0];
        [self setIsCheckedIn:NO];
    } else {
        [self.checkInOutButton setTitle:@"Check me out" forState:UIControlStateNormal];
        [self.currentRestaurantView.openInMapsButton setHidden:NO];
        [self.somethingElseButton setEnabled:NO];
        [self.somethingElseButton setAlpha:0.7];
        [self setIsCheckedIn:YES];
    }
}

#pragma mark - Notifications
- (void)setEnjoyNotification {
    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *notification in notifications) {
        NSDictionary *userInfo = notification.userInfo;
        if ([[userInfo objectForKey:@"notification"] isEqualToString:@"enjoy"]) {
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
        }
    }

    EnjoyNotification *notification = [EnjoyNotification enjoyNotification];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    NSLog(@"%@ \n total = %lu", notification.fireDate, [[[UIApplication sharedApplication] scheduledLocalNotifications] count]);
}

#pragma mark - <LunchtimeLocationManagerDelegate>
- (void)receivedLocation {
    FoursquareAPI *fourSquareRequest = [[FoursquareAPI alloc] initWithLocation:self.locationManager.currentLocation];
    [fourSquareRequest findRestaurantsForUser:[User objectForPrimaryKey:@1] withCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self configureLayout];
            [self.locationManager stop];
        });
    }];
}

@end