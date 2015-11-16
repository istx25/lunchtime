//
//  FourSquareAPI.m
//  FourSquare
//
//  Created by Alex on 2015-11-15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import <Realm/Realm.h>
#import "FourSquareAPI.h"
#import "LunchtimeLocationManager.h"
#import "Restaurant.h"
#import "User.h"

static NSString *kResultsLimit = @"&limit=50";
static NSString *kClientID = @"CGH3OKEERY3MSUZGPHQVDS2PCPLQEJ5TLTDPG0GRN02J50GL";
static NSString *kClientSecret =@"1C5YTYJ4JM2Y1OEOIN0WKXMI33TS4Q4LFEEIPW0WSR2TW3FY";
static NSString *kExploreAPIURL = @"https://api.foursquare.com/v2/venues/explore?v=20151101";

@interface FourSquareAPI ()

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end

@implementation FourSquareAPI

- (instancetype)initWithLocation:(CLLocation *)location
{
    self = [super init];
    if (self) {
        _latitude = location.coordinate.latitude;
        _longitude = location.coordinate.longitude;
    }
    return self;
}


- (void)createRestaurants:(NSArray *)restaurants {
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    for (NSDictionary *restaurant in restaurants) {
        
        Restaurant *newRestaurant = [[Restaurant alloc] init];

        newRestaurant.name = restaurant[@"venue"][@"name"];
        newRestaurant.address = restaurant[@"venue"][@"location"][@"address"];
        newRestaurant.URL = restaurant[@"venue"][@"url"];
        newRestaurant.category = restaurant[@"venue"][@"category"][@"name"];
    
        [Restaurant createOrUpdateInRealm:realm withValue:newRestaurant];
    }
    
    [realm commitWriteTransaction];
}

- (void)findRestaurantsForUser:(User *)user {
    
    __block NSArray *restaurantsArray = [NSArray new];
    
    NSString *location = [NSString stringWithFormat:@"&ll=%f,%f", self.latitude, self.longitude];
    NSString *price = [NSString stringWithFormat:@"&price=%u", user.priceLimit + 1];
    NSString *radius = @"&radius=1500";
    
    NSString *exploreAPI = [NSString stringWithFormat:@"%@&client_id=%@&client_secret=%@", kExploreAPIURL, kClientID, kClientSecret];
    
    NSString *URLString = [NSString stringWithFormat:@"%@%@%@%@%@", exploreAPI, kResultsLimit, location, price, radius];
    
    NSLog(@"%@", URLString);
    
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

@end
