//
//  Restaurant.m
//  Lunchtime
//
//  Created by Alex on 2015-11-16.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

- (instancetype)init {
    self = [super init];

    if (self) {
        _coordinate = CLLocationCoordinate2DMake(_latitude, _longitude);
    }

    return self;
}

+ (NSString *)primaryKey {
    return @"name";
}

@end
