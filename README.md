# Lunchtime

Lunchtime was built for a midterm project during the October 2015 iOS cohort at [Lighthouse Labs](https://lighthouselabs.ca/). The duo behind this app is [Alex Robertson](https://github.com/dcalexrobertson) and [Willow Bumby](http://www.github.com/istx25).

### What is Lunchtime?

The project was thought up by Alex and I when we were thinking about places to go for lunch. We realised there was no variety when choosing where to eat because we had no idea what else was here. We asked around and found that other students also went to the same food spot because they didn't know where else to go. We wanted to solve this problem with an adaptable, yet simple experience.

### Technologies Used

Lunchtime was originally written in Objective-C. However, we returned to the project later on to practise our Swift language and interpolation skills by translating and rethinking our code for Swift. We used Realm, CoreLocation, MapKit, Foundation's networking APIs and UIKit. We also used FourSquare's [venues/explore](https://developer.foursquare.com/docs/venues/explore) endpoint to fetch restaurants. 

I primarily worked on...

- Overall UI/UX of Lunchtime.
- Implementation for all CoreLocation and Geocoding aspects of the app.
- AutoLayout (both in Interface Builder and in code).
- The Google Maps (and Apple Maps) integrations (for directions and visualisation).
- The Restaurant array randomisation methods. 
- The Realm data models.

Alex primarily worked on...

- Communicating with the FourSquare API
- All of the local notification work.
- The UI for visualising the user's "Saved Restaurants" on a map.
- The custom map annotation for opening a restaurant's website from the map.
- Logic for the settings panel.
- Logic for filtering restaurants in Realm.
- Logic for filtering restaurants against the blocked list. 

### Build and Run

This project is no longer maintained, but was in working condition on December 22nd, 2015. We were using Xcode 7.2 on mac OS 10.11.2. To build and run Lunchtime, run `carthage update --platform ios`. 

**Don't have Xcode?** Watch [this brief video demo](https://dl.dropboxusercontent.com/u/162794740/Demos/lunchtime-demo.mp4).

# License

This project (Lunchtime) is released and licensed under the [MIT License](LICENSE.txt).
