//
//  BlockedRestaurantsFilter.h
//  Lunchtime
//
//  Created by Alex on 2015-11-19.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockedRestaurantsFilter : NSObject

+ (NSMutableArray *)filterBlockedRestaurantsFromArray:(NSArray *)restaurants;

@end
