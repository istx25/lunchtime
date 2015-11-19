//
//  User.h
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-13.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import <Realm/Realm.h>
#import "Restaurant.h"


// PriceLimitLessThanTenDollars = 0
// PriceLimitTenToTwentyDollars = 1
// PriceLimitTwentyToThirtyDollars = 2
// PriceLimitGreaterThanThirtyDollars = 3

@interface User : RLMObject

@property (nonatomic) NSDate *lunchtime;
@property (nonatomic) NSNumber<RLMInt> *preferredDistance;
@property (nonatomic) NSInteger priceLimit;
@property (nonatomic) NSNumber<RLMInt> *identifier;

@property (nonatomic) RLMArray<Restaurant *><Restaurant> *blacklistedRestaurants;
@property (nonatomic) RLMArray<Restaurant *><Restaurant> *savedRestaurants;

@end

RLM_ARRAY_TYPE(User)
