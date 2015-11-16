//
//  LunchtimeGeocoder.h
//  Lunchtime
//
//  Created by Willow Belle on 2015-11-15.
//  Copyright © 2015 Cosmic Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LunchtimeGeocoder : NSObject

- (void)reverseGeocodeLocationWithCoordinate:(CLLocationCoordinate2D)coordinate withCompletionHandler:(void (^)(CLPlacemark *placemark))completionHandler;

@end
