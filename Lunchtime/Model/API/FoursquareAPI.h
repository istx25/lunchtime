//
//  FoursquareAPI.h
//  Lunchtime
//
//  Created by Alex on 2015-11-15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import <Realm/Realm.h>
#import <Foundation/Foundation.h>

@class CLLocation;
@class User;

@interface FoursquareAPI : NSObject

- (instancetype)initWithLocation:(CLLocation *)location;
- (void)findRestaurantsForUser:(User *)user withCompletionHandler:(void (^)(void))completionHandler;

@end
