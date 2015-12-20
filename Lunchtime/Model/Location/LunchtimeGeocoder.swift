//
//  LunchtimeGeocoder.swift
//  Lunchtime
//
//  Created by Willow Bumby on 2015-11-19.
//  Copyright © 2015 Lighthouse Labs. All rights reserved.
//

import UIKit

public class LunchtimeGeocoder: NSObject {

    class func reverseGeocodeRequestWithCoordinate(coordinate: CLLocationCoordinate2D, handler: ((placemark: CLPlacemark) -> Void)) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard let placemarks = placemarks else {
                return
            }

            let placemark = placemarks[0]
            handler(placemark: placemark)
        }
    }

    class func geocodeRequestWithAddress(address: String, handler: ((latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> Void)) {
        let geocoder = CLGeocoder()

        geocoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in
            guard error != nil else {
                print("Geocode request failed with \(error)")

                return
            }

            guard let placemarks = placemarks else {
                print("The placemarks array is nil")

                return
            }

            guard let coordinate = placemarks[0].location?.coordinate else {
                print("The coordinate struct is nil")

                return
            }

            handler(latitude: coordinate.latitude, longitude: coordinate.longitude)
        })
    }
}