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

static NSString *kSuggestionLabelConstant = @"We think you're going to like\n";
static NSString *kCheckedInLabelConstant = @"We have checked you in at";
static NSString *kLocationLabelConstant = @"Proximity to restaurants is based off of \n your last known location.";

@interface HomeViewController () <LunchtimeLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet UIView *currentRestaurantViewContainer;
@property (nonatomic) CurrentRestaurantView *currentRestaurantView;

@property (nonatomic, weak) IBOutlet UILabel *locationLabel;
@property (nonatomic, weak) IBOutlet UIButton *yesButton;
@property (nonatomic, weak) IBOutlet UIButton *noButton;
@property (nonatomic, weak) IBOutlet UIButton *blockButton;

@property (nonatomic) LunchtimeLocationManager *locationManager;
@property (nonatomic) RLMResults<Restaurant *> *restaurants;
@property (nonatomic) RLMNotificationToken *token;
@property (nonatomic) Restaurant *currentRestaurant;

@property (nonatomic) BOOL shouldHideOpenInMapsButton;

@end

@implementation HomeViewController

#pragma mark - Controller Lifecycle
- (void)loadView {
    [super loadView];

    [self setCurrentRestaurantView:[[CurrentRestaurantView alloc] init]];
    [self.currentRestaurantViewContainer addSubview:self.currentRestaurantView];
    [self.currentRestaurantView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.currentRestaurantView addConstraintsTo:self.currentRestaurantView onContainingView:self.currentRestaurantViewContainer];
}

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

- (void)setupUI {
    [self.currentRestaurantView.headerTextLabel setText:@"Fetching..."];
    [self setRestaurants:[Restaurant allObjects]];
    [self findNewRandomRestaurantObject];
}

- (void)updateUI {
    if ([User objectForPrimaryKey:@1].isInvalidated) {
        return;
    }

    if (self.shouldHideOpenInMapsButton) {
        if (self.currentRestaurant.thoroughfare) {
            [self.currentRestaurantView.headerTextLabel setText:[NSString stringWithFormat:@"%@ %@ on %@", kSuggestionLabelConstant, self.currentRestaurant.title, self.currentRestaurant.thoroughfare]];
        } else {
            [self.currentRestaurantView.headerTextLabel setText:[NSString stringWithFormat:@"%@ %@", kSuggestionLabelConstant, self.currentRestaurant.title]];
        }
    } else {
        if (self.currentRestaurant.thoroughfare) {
            [self.currentRestaurantView.headerTextLabel setText:[NSString stringWithFormat:@"%@ %@ on %@", kCheckedInLabelConstant, self.currentRestaurant.title, self.currentRestaurant.thoroughfare]];
        } else {
            [self.currentRestaurantView.headerTextLabel setText:[NSString stringWithFormat:@"%@ %@", kCheckedInLabelConstant, self.currentRestaurant.title]];
        }
    }

}

#pragma mark - Conv
- (void)updateUIWithNewRestaurantObject {
    [self findNewRandomRestaurantObject];
    [self updateUI];
}

- (void)findNewRandomRestaurantObject {
    if (0 < self.restaurants.count > 0) {
        NSUInteger index = arc4random_uniform((u_int32_t)self.restaurants.count);
        self.currentRestaurant = [self.restaurants objectAtIndex:index];
    }
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

#pragma mark - Actions
- (void)openInMapsButtonPressed {
    [LunchtimeMaps openInMapsWithAddress:self.currentRestaurant.address];
}

- (IBAction)yesButtonPressed:(UIButton *)sender {
    self.shouldHideOpenInMapsButton = !self.shouldHideOpenInMapsButton;
    [self checkInStatusDidChange];
    [RealmConvenience addRestaurantToSavedArray:self.currentRestaurant];
    [[UIApplication sharedApplication] scheduleLocalNotification:[EnjoyNotification enjoyNotification]];
}

- (void)checkInStatusDidChange {
    if (self.shouldHideOpenInMapsButton) {
        [self.currentRestaurantView.openInMapsButton setHidden:YES];
        [self.yesButton setTitle:@"Check me in" forState:UIControlStateNormal];
        [self updateUIWithNewRestaurantObject];
        [self.noButton setEnabled:YES];
        [self.noButton setAlpha:1.0];
    } else {
        [self.yesButton setTitle:@"Check me out" forState:UIControlStateNormal];
        [self.currentRestaurantView.openInMapsButton setHidden:NO];
        [self.noButton setEnabled:NO];
        [self.noButton setAlpha:0.7];
    }
}

- (IBAction)noButtonPressed:(UIButton *)sender {
    [self updateUIWithNewRestaurantObject];
}

- (IBAction)blockButtonPressed:(UIButton *)sender {
    self.shouldHideOpenInMapsButton = !self.shouldHideOpenInMapsButton;
    [self checkInStatusDidChange];
    [RealmConvenience addRestaurantToBlacklistedArray:self.currentRestaurant];
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