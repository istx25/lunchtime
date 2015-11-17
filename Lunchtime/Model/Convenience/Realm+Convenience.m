//
//  Realm+Convenience.m
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-16.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "Realm+Convenience.h"
#import "Restaurant.h"
#import "User.h"

@implementation RealmConvenience

+ (void)addRestaurantToSavedArray:(Restaurant *)restaurant {
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[User objectForPrimaryKey:@1].savedRestaurants addObject:restaurant];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

+ (void)addRestaurantToBlacklistedArray:(Restaurant *)restaurant {
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[User objectForPrimaryKey:@1].blacklistedRestaurants addObject:restaurant];
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

@end
