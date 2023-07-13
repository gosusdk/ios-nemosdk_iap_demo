# Changelog
All notable changes to this project will be documented in this file.

### Changed
## [v2.0.2](https://github.com/itcgosucorp/nemosdk-ios/releases/tag/v2.0.2)
#### NemoSDKTracking framework
-  Add Tracking with Firebase

## [v2.0.1](https://github.com/itcgosucorp/nemosdk-ios/releases/tag/v2.0.1)
#### NemoSDK Framework
##### Configure NemoSignIn in your project (default info.plist)
1. NemoScope key replaced by AuthorizationScope
2. NemoUrl key replaced by Issuer

##### Initialize NemoSDK
```objectivec
//AppDelegate.m
[[NemoSDK sharedInstance] sdkInit:nil];
//replaced by
[[NemoSDK sharedInstance] sdkInit];
[NemoSDK sharedInstance].loginDelegate = self;
```

##### Authorization Interface
```objectivec
[[NemoSDK sharedInstance] login:self andDelegate:self];
[[NemoSDK sharedInstance] logoutBackground:self andDelegate:self];
//replaced by
[[NemoSDK sharedInstance] login];
[[NemoSDK sharedInstance] logout];
```
#### NemoSDKTracking framework
-  Add Tracking with AppsFlyer
And, Add Tracking functionality to the SDK. [See more](https://github.com/itcgosucorp/nemosdk-ios#integrate-nemosdktracking)
