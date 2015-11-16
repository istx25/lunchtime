//
//  FourSquareAPI.h
//  FourSquare
//
//  Created by Alex on 2015-11-15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;
@class User;

@interface FourSquareAPI : NSObject

- (instancetype)initWithLocation:(CLLocation *)location;
- (void)findRestaurantsForUser:(User *)user;

@end
