//
//  Restaurant.h
//  Lunchtime
//
//  Created by Alex on 2015-11-16.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import <Realm/Realm.h>

@interface Restaurant : RLMObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *category;
@property (nonatomic) NSString *thoroughfare;
@property (nonatomic) NSString *address;

@end

RLM_ARRAY_TYPE(Restaurant)
