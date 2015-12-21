////
////  PreviousDaysMapViewController.swift
////  Lunchtime
////
////  Created by Willow Bumby on 2015-12-20.
////  Copyright © 2015 Lighthouse Labs. All rights reserved.
////
//
//import UIKit
//import MapKit
//import SafariServices
//
//class PreviousDaysMapViewController: UIViewController {
//
//    // MARK: Constants
//    private static let MapZoomValue: Int = 2100
//
//    // MARK: Properties
//    @IBOutlet weak var mapView: MKMapView!
//    let locationManager = LunchtimeLocationManager.defaultManager()
//    var user: User?
//
//    // MARK: Controller Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        mapView.showsUserLocation = true
//        locationManager.setup()
//
//    }
//
//    // MARK: Layout
//    func addRestaurantAnnotationsToMapView() {
//        guard let user = user where user.savedRestaurants.count > 0 else { return }
//
////
//        for restaurant in user.savedRestaurants {
//            restaurant.coordinate
//        }
//    }
//
//
//}
//
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    [self setLocationManager:[LunchtimeLocationManager defaultManager]];
//    [self.mapView setShowsUserLocation:YES];
//    [self.locationManager setup];
//    [self zoomMapToUserLocation];
//    }
//
//    - (void)addRestaurantAnnotationsToMapView {
//        if (self.user.savedRestaurants.count <= 0) {
//            return;
//        }
//
//        for (Restaurant *restaurant in self.user.savedRestaurants) {
//            restaurant.coordinate = CLLocationCoordinate2DMake(restaurant.latitude, restaurant.longitude);
//            [self.mapView addAnnotation:restaurant];
//        }
//        }
//
//        - (void)zoomMapToUserLocation {
//            CLLocationCoordinate2D zoomLocation = self.locationManager.currentLocation.coordinate;
//            MKCoordinateRegion adjustedRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, kMapZoomValue, kMapZoomValue);
//
//            [self.mapView setRegion:adjustedRegion animated:YES];
//            [self addRestaurantAnnotationsToMapView];
//}
//
//#pragma mark Map Delegate
//
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//    static NSString *identifier = @"MyAnnotationView";
//
//    if ([annotation isKindOfClass:[MKUserLocation class]]) {
//        return nil;
//    }
//
//    MKPinAnnotationView *view = (id)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
//    if (view) {
//        view.annotation = annotation;
//    } else {
//
//        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
//        view.canShowCallout = true;
//        view.animatesDrop = true;
//
//        Restaurant *restaurant = view.annotation;
//        if (!restaurant.url) {
//            return view;
//        }
//
//        UIImage *image = [UIImage imageNamed:@"internet54"];
//        UIButton *openURLButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        openURLButton.frame = CGRectMake(0, 0, image.size.width, image.size.height);
//        [openURLButton setImage:image forState:UIControlStateNormal];
//
//        view.rightCalloutAccessoryView = openURLButton;
//    }
//
//    return view;
//    }
//
//    - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
//        Restaurant *restaurant = view.annotation;
//        SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:restaurant.url]];
//        [self presentViewController:safariViewController animated:YES completion:nil];
//}
