# Lunchtime

Lunchtime was built as a midterm project during the October 2015 iOS cohort at Lighthouse Labs. The team behind Lunchtime is [Alex Robertson](https://github.com/dcalexrobertson) and [Willow Belle](http://www.github.com/istx25) *(also known as Douglas)*. 

## License
Lunchtime is released under the terms of the MIT license. See LICENSE.txt for more information or see http://opensource.org/licenses/MIT.

## Development process
The idea came to be when we realised that there was no variety when choosing where to go for lunch while attending Lighthouse Labs. Students find themselves going to the same food spot every day because they don't know where else to go. We wanted to solve this problem with a simple, yet functional iOS application.

Lunchtime was written in Objective-C and Swift using APIs in Realm, CoreLocation, MapKit, Foundation and UIKit. We used NSURLSession to fetch restaurant data from Foursquare's [venues/explore](https://developer.foursquare.com/docs/venues/explore) endpoint. 

#### Alex primarily worked on...
- Communicating with the Foursquare API.
- Implementing the notifications aspect of the application.
- Laying out the users "saved restaurants" on an map.
- A custom map annotation that enabled users to open the restaurant's website from the map.
- The logic for the settings panel.
- The logic for filtering restaurants (in Realm).
- The logic for filtering restaurants against the blocked list.

Relevant Keywords: `NSURLSession`, `MKMapView`, `MKAnnotationView`, `UILocalNotification`, Delegate pattern, Realm, Objective-C, Swift

#### Willow primarily worked on...
- The overall user interace of Lunchtime.
- The overall user experience and user interaction for Lunchtime.
- CoreLocation and Geocoder implementations.
- AutoLayout (both in IB and in code)
- The Google Maps (and Apple Maps) integration for directions to the restaurant.
- The Realm models.
- The randomisation mechanism.

Relevant Keywords: `UIPageViewController`, `CLGeocoder`, Custom `UIView`, `UIViewController`, `NSLayoutConstraint`, `NSNotificationCenter`, Delegate pattern, Singleton pattern, Swift, Realm, Objective-C

## Demo
If you would like to test out Lunchtime on your own device, feel free to follow the instructions below. You will need Xcode 7.1 to compile the project.

1. Clone the project. :octocat:
2. Run `carthage update --platform ios` *(Related: [Installing Carthage on OS X](https://github.com/carthage/carthage))*.
3. Build and run. :dancer:

**Don't have Xcode? Watch [this brief video demo](https://dl.dropboxusercontent.com/u/162794740/Demos/lunchtime-demo.mp4).**
