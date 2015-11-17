//
//  Restaurant.m
//  Lunchtime
//
//  Created by Alex on 2015-11-16.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

+ (NSString *)primaryKey {
    return @"name";
}

+ (NSArray *)ignoredProperties {
    return @[@"coordinate"];
}

@end
