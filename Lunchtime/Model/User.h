//
//  User.h
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-13.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import <Realm/Realm.h>

typedef enum NSInteger {
    PriceLimitLessThanTenDollars,
    PriceLimitTenToTwentyDollars,
    PriceLimitTwentyToThirtyDollars,
    PriceLimitGreaterThanThirtyDollars
} PriceLimit;

@interface User : RLMObject

@property (nonatomic) NSDate *lunchtime;
@property (nonatomic) PriceLimit priceLimit;
@property (nonatomic) NSNumber<RLMInt> *identifier;

@end

RLM_ARRAY_TYPE(User)
