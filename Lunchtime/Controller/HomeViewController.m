//
//  ViewController.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-13.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "User.h"
#import "FoursquareAPI.h"
#import "HomeViewController.h"
#import "LunchtimeLocationManager.h"
#import "LunchtimeMaps.h"
#import "LunchtimeGeocoder.h"

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
    [self setupUI];

    self.token = [[RLMRealm defaultRealm] addNotificationBlock:^(NSString *notification, RLMRealm *realm) {
        [self updateUI];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)setupUI {
    [self.suggestionLabel setText:@"Fetching..."];
    [self setRestaurants:[Restaurant allObjects]];
    NSUInteger index = arc4random_uniform((u_int32_t)self.restaurants.count);
    self.currentRestaurant = [self.restaurants objectAtIndex:index];
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

#pragma mark - Actions
- (IBAction)yesButtonPressed:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"I know where it is" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[RLMRealm defaultRealm] beginWriteTransaction];
        [[User objectForPrimaryKey:@1].savedRestaurants addObject:self.currentRestaurant];
        [[RLMRealm defaultRealm] commitWriteTransaction];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"Open Restaurant in Maps" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [LunchtimeMaps openInMapsWithAddress:self.currentRestaurant.address];
    }]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)noButtonPressed:(UIButton *)sender {
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[User objectForPrimaryKey:@1].blacklistedRestaurants addObject:self.currentRestaurant];
    [[RLMRealm defaultRealm] commitWriteTransaction];

    [self setupUI];
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