//
//  CosmicMaps.swift
//  Lunchtime
//
//  Created by Willow Bumby on 2015-12-20.
//  Copyright © 2015 Lighthouse Labs. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class CosmicMaps: NSObject {

    // MARK: Constants
    private static let BaseGoogleMapsURL = "comgooglemaps://?"

    // MARK: Methods
    static func openInMapsWithAddress(address: String) {
        if address.characters.count == 0 {
            return
        }

        let encodedAddress = address.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLUserAllowedCharacterSet())
        let mapsURL = NSURL(string: "\(CosmicMaps.BaseGoogleMapsURL)daddr=\(encodedAddress!)&directionsmode=transit")!

        if UIApplication.sharedApplication().openURL(mapsURL) {
            UIApplication.sharedApplication().openURL(mapsURL)

            return
        }

        LunchtimeGeocoder.geocodeRequestWithAddress(address) { (latitude, longitude) in
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let endLocation = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
            let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeTransit]
            MKMapItem(placemark: endLocation).openInMapsWithLaunchOptions(options)
        }
    }
}
