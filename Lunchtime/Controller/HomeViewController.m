//
//  ViewController.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-13.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "HomeViewController.h"
#import "LunchtimeLocationManager.h"
#import "LunchtimeGeocoder.h"

static NSString *kSuggestionLabelConstant = @"We think you're going to like";
static NSString *kLocationLabelConstant = @"Proximity to restaurants is based off of \n your last known location.";

@interface HomeViewController () <LunchtimeLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *suggestionLabel;
@property (nonatomic, weak) IBOutlet UILabel *locationLabel;
@property (nonatomic, weak) IBOutlet UIButton *yesButton;
@property (nonatomic, weak) IBOutlet UIButton *noButton;

@property (nonatomic) LunchtimeLocationManager *locationManager;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.locationManager = [LunchtimeLocationManager defaultManager];
    [self.locationManager setup];
    [self.locationManager start];
    [self.locationManager setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
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
    [alert addAction:[UIAlertAction actionWithTitle:@"I know where it is" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Open in Google Maps" style:UIAlertActionStyleDefault handler:nil]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)noButtonPressed:(UIButton *)sender {

}

#pragma mark - <LunchtimeLocationManagerDelegate>
- (void)receivedLocation {
    [self configureLayout];
}


@end
