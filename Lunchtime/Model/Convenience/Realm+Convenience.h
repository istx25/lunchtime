//
//  Realm+Convenience.h
//  Lunchtime
//
//  Created by Willow Bumby on 2015-11-16.
//  Copyright © 2015 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@class Restaurant;

@interface RealmConvenience : NSObject

+ (void)addRestaurantToSavedArray:(Restaurant *)restaurant;
+ (void)addRestaurantToBlacklistedArray:(Restaurant *)restaurant;

+ (void)removeRestaurantFromSavedArrayAtIndex:(NSUInteger)index;
+ (void)removeRestaurantFromBlacklistedArrayAtIndex:(NSUInteger)index;

@end
