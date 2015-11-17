//
//  ViewController.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-13.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "HomeViewController.h"
#import "UIAlertController+Extras.h"
#import "LunchtimeLocationManager.h"
#import "Realm+Convenience.h"
#import "LunchtimeGeocoder.h"
#import "LunchtimeMaps.h"
#import "FoursquareAPI.h"
#import "User.h"

static NSString *kSuggestionLabelConstant = @"We think you're going to like\n";
static NSString *kLocationLabelConstant = @"Proximity to restaurants is based off of \n your last known location.";

@interface HomeViewController () <LunchtimeLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *suggestionLabel;
@property (nonatomic, weak) IBOutlet UILabel *locationLabel;
@property (nonatomic, weak) IBOutlet UIButton *yesButton;
@property (nonatomic, weak) IBOutlet UIButton *noButton;

@property (nonatomic) LunchtimeLocationManager *locationManager;
@property (nonatomic) RLMResults<Restaurant *> *restaurants;
@property (nonatomic) RLMNotificationToken *token;
@property (nonatomic) Restaurant *currentRestaurant;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setLocationManager:[LunchtimeLocationManager defaultManager]];
    [self.locationManager setDelegate:self];
    [self.locationManager setup];
    [self.locationManager start];

    self.token = [[RLMRealm defaultRealm] addNotificationBlock:^(NSString *notification, RLMRealm *realm) {
        [self updateUI];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self setupUI];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)setupUI {
    [self.suggestionLabel setText:@"Fetching..."];
    [self setRestaurants:[Restaurant allObjects]];

    if (0 < self.restaurants.count) {
        NSUInteger index = arc4random_uniform((u_int32_t)self.restaurants.count);
        self.currentRestaurant = [self.restaurants objectAtIndex:index];
    }
}

- (void)updateUI {
    if (self.currentRestaurant.thoroughfare) {
        [self.suggestionLabel setText:[NSString stringWithFormat:@"%@ %@ on %@", kSuggestionLabelConstant, self.currentRestaurant.name, self.currentRestaurant.thoroughfare]];
    } else {
        [self.suggestionLabel setText:[NSString stringWithFormat:@"%@ %@", kSuggestionLabelConstant, self.currentRestaurant.name]];
    }
}

- (void)configureLayout {
    CLLocationCoordinate2D coordinate = self.locationManager.currentLocation.coordinate;
    LunchtimeGeocoder *geocoder = [LunchtimeGeocoder new];
    [geocoder reverseGeocodeLocationWithCoordinate:coordinate withCompletionHandler:^(CLPlacemark *placemark) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.locationLabel setText:[NSString stringWithFormat:@"%@ (%@)", kLocationLabelConstant, placemark.thoroughfare]];
        });
    }];
}
//
#pragma mark - Actions
- (IBAction)yesButtonPressed:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addCancelAction];

    [alert addDefaultAction:@"I know where it is" withHandler:^(UIAlertAction *action) {
        [RealmConvenience addRestaurantToSavedArray:self.currentRestaurant];
    }];

    [alert addDefaultAction:@"Open Restaurant in Maps" withHandler:^(UIAlertAction *action) {
        [RealmConvenience addRestaurantToSavedArray:self.currentRestaurant];
        [LunchtimeMaps openInMapsWithAddress:self.currentRestaurant.address];
    }];

    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)noButtonPressed:(UIButton *)sender {
    [self setupUI];
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