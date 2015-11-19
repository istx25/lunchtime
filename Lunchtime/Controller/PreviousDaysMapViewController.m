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
#import <MapKit/MapKit.h>
#import "Restaurant.h"
#import "User.h"

@import SafariServices;

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
        restaurant.coordinate = CLLocationCoordinate2DMake(restaurant.latitude, restaurant.longitude);
//        restaurant.title = restaurant.name;
        [self.mapView addAnnotation:restaurant];
    }
}

- (void)zoomMapToUserLocation {
    CLLocationCoordinate2D zoomLocation = self.locationManager.currentLocation.coordinate;
    MKCoordinateRegion adjustedRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, kMapZoomValue, kMapZoomValue);

    [self.mapView setRegion:adjustedRegion animated:YES];
    [self addRestaurantAnnotationsToMapView];
}

#pragma mark Map Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *identifier = @"MyAnnotationView";
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKPinAnnotationView *view = (id)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (view) {
        view.annotation = annotation;
    } else {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        view.canShowCallout = true;
        view.animatesDrop = true;
        
        UIImage *image = [UIImage imageNamed:@"internet54"];
        
        UIButton *openURLButton = [UIButton buttonWithType:UIButtonTypeCustom];
        openURLButton.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [openURLButton setImage:image forState:UIControlStateNormal];
        
        view.rightCalloutAccessoryView = openURLButton;
    }
    
    return view;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    Restaurant *restaurant = view.annotation;
    
    SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:restaurant.url]];
    
    [self presentViewController:safariViewController animated:YES completion:nil];
}

@end
