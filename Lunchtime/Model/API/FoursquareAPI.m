//
//  FoursquareAPI.m
//  Lunchtime
//
//  Created by Alex on 2015-11-15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "FoursquareAPI.h"
#import "Lunchtime-Swift.h"
#import "Restaurant.h"
#import "User.h"

static NSString *kClientID = @"CGH3OKEERY3MSUZGPHQVDS2PCPLQEJ5TLTDPG0GRN02J50GL";
static NSString *kClientSecret =@"1C5YTYJ4JM2Y1OEOIN0WKXMI33TS4Q4LFEEIPW0WSR2TW3FY";
static NSString *kExploreAPIURL = @"https://api.foursquare.com/v2/venues/explore?v=20151101";
static NSString *kResultsLimit = @"&limit=50";

@interface FoursquareAPI ()

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end

@implementation FoursquareAPI

- (instancetype)initWithLocation:(CLLocation *)location {
    self = [super init];

    if (self) {
        _latitude = location.coordinate.latitude;
        _longitude = location.coordinate.longitude;
    }

    return self;
}

- (void)findRestaurantsForUser:(User *)user {

    __block NSArray *restaurantsArray = [NSArray new];

    NSString *location = [NSString stringWithFormat:@"&ll=%f,%f", self.latitude, self.longitude];
    NSString *price = [NSString stringWithFormat:@"&price=%ld", user.priceLimit + 1];
    NSString *radius = [NSString stringWithFormat:@"&radius=%@", user.preferredDistance];
    NSString *category = [NSString stringWithFormat:@"&section=%@", user.category];

    NSString *exploreAPI = [NSString stringWithFormat:@"%@&client_id=%@&client_secret=%@", kExploreAPIURL, kClientID, kClientSecret];

    NSString *URLString = [NSString stringWithFormat:@"%@%@%@%@%@%@", exploreAPI, kResultsLimit, location, price, radius, category];


    NSURL *url = [NSURL URLWithString:URLString];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (!error) {

            NSError *jsonError = nil;

            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

            restaurantsArray = jsonDict[@"response"][@"groups"][0][@"items"];

            [self createRestaurants:restaurantsArray];

        }
    }];

    [task resume];
}

- (void)createRestaurants:(NSArray *)restaurants {

    NSMutableArray *finishedRestaurants = [NSMutableArray new];

    for (NSDictionary *restaurant in restaurants) {

        Restaurant *newRestaurant = [[Restaurant alloc] init];

        newRestaurant.title = restaurant[@"venue"][@"name"];
        newRestaurant.category = restaurant[@"venue"][@"categories"][0][@"name"];
        newRestaurant.url = restaurant[@"venue"][@"url"];
        newRestaurant.identifier = [NSString stringWithFormat:@"%i", arc4random_uniform(1215752191)];

        NSNumber *latitude = restaurant[@"venue"][@"location"][@"lat"];
        NSNumber *longitude = restaurant[@"venue"][@"location"][@"lng"];
        newRestaurant.latitude = [latitude doubleValue];
        newRestaurant.longitude = [longitude doubleValue];

        NSArray *formattedAddress = restaurant[@"venue"][@"location"][@"formattedAddress"];

        if (formattedAddress.count >= 2) {
            newRestaurant.address = [NSString stringWithFormat:@"%@ %@", formattedAddress[0], formattedAddress[1]];
        } else {
            newRestaurant.address = formattedAddress[0];
        }

        [LunchtimeGeocoder reverseGeocodeRequestWithCoordinate:CLLocationCoordinate2DMake(newRestaurant.latitude, newRestaurant.longitude) handler:^(CLPlacemark *placemark) {
            dispatch_async(dispatch_get_main_queue(), ^{

                [[RLMRealm defaultRealm] beginWriteTransaction];
                newRestaurant.thoroughfare = placemark.thoroughfare;
                [[RLMRealm defaultRealm] commitWriteTransaction];
           });
        }];
        
        [finishedRestaurants addObject:newRestaurant];
        
        }

    [self.delegate requestDidFinishWithRestaurants:finishedRestaurants];
}

@end