//
//  Restaurant.h
//  Lunchtime
//
//  Created by Alex on 2015-11-16.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Realm/Realm.h>

@interface Restaurant : RLMObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@property (nonatomic, copy) NSString *title;
@property (nonatomic) NSString *category;
@property (nonatomic) NSString *thoroughfare;
@property (nonatomic) NSString *address;
@property (nonatomic) NSString *url;

@end

RLM_ARRAY_TYPE(Restaurant)
