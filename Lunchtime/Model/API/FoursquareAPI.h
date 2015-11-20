//
//  FoursquareAPI.h
//  Lunchtime
//
//  Created by Alex on 2015-11-15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol FoursquareAPIDelegate <NSObject>

- (void)requestDidFinishWithRestaurants:(NSMutableArray *)restaurants;

@end

@class User;

@interface FoursquareAPI : NSObject

@property (nonatomic, weak) id <FoursquareAPIDelegate> delegate;

- (instancetype)initWithLocation:(CLLocation *)location;
- (void)findRestaurantsForUser:(User *)user;

@end