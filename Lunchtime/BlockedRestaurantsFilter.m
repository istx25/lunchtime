//
//  BlockedRestaurantsFilter.m
//  Lunchtime
//
//  Created by Alex on 2015-11-19.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "BlockedRestaurantsFilter.h"
#import "User.h"


@implementation BlockedRestaurantsFilter

+ (NSMutableArray *)filterBlockedRestaurantsFromArray:(NSMutableArray *)restaurants {
    
    User *user = [User objectForPrimaryKey:@1];
    
    NSMutableArray *filteredRestaurants = [NSMutableArray new];
    
    for (Restaurant *restaurant in restaurants) {
        
        for (Restaurant *blockedRestaurant in user.blacklistedRestaurants) {
            
            if ([restaurant.title isEqualToString:blockedRestaurant.title]) {
                [filteredRestaurants addObject:restaurant];
            }
            
        }
        
    }
    
    [restaurants removeObjectsInArray:filteredRestaurants];
    return restaurants;
}


@end
