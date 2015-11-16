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
@property (nonatomic) NSString *address;
@property (nonatomic) NSString *category;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Restaurant>
RLM_ARRAY_TYPE(Restaurant)
