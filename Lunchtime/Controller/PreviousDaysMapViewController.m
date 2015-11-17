//
//  PreviousDaysMapViewController.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-16.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "PreviousDaysMapViewController.h"
#import "LunchtimeLocationManager.h"
#import "LunchtimeGeocoder.h"
#import "Restaurant.h"
#import "User.h"
#import <MapKit/MapKit.h>

static int const kMapZoomValue = 2100;

@interface PreviousDaysMapViewController ()

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic) LunchtimeLocationManager *locationManager;

@end

@implementation PreviousDaysMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setLocationManager:[LunchtimeLocationManager defaultManager]];
    [self.mapView setShowsUserLocation:YES];
    [self.locationManager setup];
    [self zoomMapToUserLocation];
}

- (void)addRestaurantAnnotationsToMapView {
    if (self.user.savedRestaurants.count <= 0) {
        return;
    }

    for (Restaurant *restaurant in self.user.savedRestaurants) {
        [self.mapView addAnnotation:restaurant];
    }
}

- (void)zoomMapToUserLocation {
    CLLocationCoordinate2D coordinate = self.locationManager.currentLocation.coordinate;
    CLLocationCoordinate2D zoomLocation = coordinate;
    MKCoordinateRegion adjustedRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, kMapZoomValue, kMapZoomValue);

    [self.mapView setRegion:adjustedRegion animated:YES];
    [self addRestaurantAnnotationsToMapView];
}

@end
