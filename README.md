# Introduction

We designed and implemented an app that provides you with a _random_ best restaurant near you. Lunchtime was made by [Willow Bumby](https://github.com/istx25) and [Alex Robertson](https://github.com/dcalexrobertson) for a midterm at Lighthouse Labs during the October 2015 iOS cohort.

# Abstract

The project was thought up by Alex and I when we were thinking about places to go for lunch. We realised we went to the same three restaurants every day and wanted to go somewhere new. Between the time constraints and stress of the bootcamp, we just wanted to find some good grub in Gastown. We asked around and found that other students experienced the same problem. So we designed and built a simple experience for finding a random restaurant near you that's decent.

Lunchtime was originally written in Objective-C, however, we decided to practice our Swift by translating and rethinking our parts of our Objective-C code for the Swift language.

# Appendices
## Who did what?
### Willow

- Overall UI/UX of Lunchtime.
- Implementation for all CoreLocation and Geocoding aspects of the app.
- AutoLayout (both in Interface Builder and in code).
- The Google Maps (and Apple Maps) integrations (for directions and visualisation).
- The Restaurant array randomisation methods. 
- The Realm data models.

### Alex

- Communicating with the FourSquare API
- All of the local notification work.
- The UI for visualising the user's "Saved Restaurants" on a map.
- The custom map annotation for opening a restaurant's website from the map.
- Logic for the settings panel.
- Logic for filtering restaurants in Realm.
- Logic for filtering restaurants against the blocked list. 


## Open Source Modules

**Module Name**: Realm-Cocoa</br>
**Function**: Mobile database for persisting favourites, blocked restaurants and preferences.</br>
**Author**: [Realm](https://realm.io/about/)  

**Module Name**: Foursquare `venues/explore` API</br>
**Function**: Returns a list of recommended venues near the current location.</br>
**Author**: [Foursquare Labs](https://foursquare.com/about/team)  

## Apple Modules

**Module Name**: Core Location</br>
**Function**: Lets you determine the current location or heading associated with a device.

**Module Name**: MapKit</br>
**Function**: Provides an interface for embedding maps directly into your own views.

**Module Name**: Foundation (Networking APIs)</br>
**Function**: Provides crucial infrastructure needed to construct and handle API requests.

**Module Name**: UIKit</br>
**Function**: Provides crucial infrastructure needed to construct and manage iOS and tvOS apps.

# License

Lunchtime is released and distributed under the [MIT License](LICENSE).
