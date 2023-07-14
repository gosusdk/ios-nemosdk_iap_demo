# Nemo-IAP iOS SDK (version 2.1.1)

**This guide shows you how to integrate your iOS app using the NemoSDK for iOS. The NemoSDK for iOS consists of the following component SDKs:**
  - [The NemoSDK Core includes in-app purchases](https://github.com/gosusdk/ios-nemosdk_iap_demo/releases)
  - Nemo OpenId: [AppAuth.framework](https://github.com/gosusdk/ios-nemosdk_iap_demo/releases)
  - Grpc framework
  - Appsflyer framework
  - Firebase framework

#### FEATURES:
  - [Nemo Login: Authenticate people with NemoID credentials.](#integrate-nemosdk)
  - [Nemo in-app purchase](#integrate-nemosdk-iap)
  - Nemo Tracking: 
    * [Tracking with AppsFlyer](#integrate-nemosdktracking-appsflyer)
    * [Tracking with Firebase](#integrate-nemosdktracking-firebase)

<a name="integrate-nemosdk"></a>
## Integrate NemoSDK with in-app purchase

- Embed NemoSDK latest version and Third party framework into your project
- Some other libraries: 
  - AppAuth.framework
  - absl.framework
  - grpc.framework
  - GRPCClient.framework
  - openssl_grpc.framework
  - Protobuf.framework
  - ProtoRPC.framework
  - RxLibrary.framework
  - uv.framework

#### 1. Configure NemoSDK in your project (default info.plist)
  ```xml
    <key>CFBundleURLTypes</key>
    <array>
      <dict>
        <key>CFBundleURLSchemes</key>
        <array>
          <string>[RedirectURL/EndSessionEndpoint]</string>
        </array>
      </dict>
    </array>
    <key>ClientID</key>
    <string>[ClientID]</string>
    <key>AuthorizationScope</key>
    <string>openid email phone_number profile offline_access</string>
    <key>Issuer</key>
    <string>[Issuer]</string>
    <key>GameClientID</key>
    <string>[GameClientID]</string>
    <key>SdkSignature</key>
    <string>[SdkSignature]</string>
  ```
- **Issuer**: The fully qualified issuer URL of the server (example: https://gid-uat.nemoverse.io)
- **[RedirectURL/EndSessionEndpoint]**: URL Schemes (example: nemo.app.demo.app)
- **GameClientID, SdkSignature:** will provide for each product
  
#### 2. AppAuth Framework Embed
![photo_2022-11-23_11-38-37](https://user-images.githubusercontent.com/94542020/203470313-a5eed93b-1e10-43cd-bee2-bf95c4bd5768.jpg)

#### 3. Initialize NemoSDK
```objectivec
//AppDelegate.h
#import "NemoSDK/NemoSDK.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@end

//AppDelegate.m
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[NemoSDK sharedInstance] sdkInit];
    return YES;
}
```
#### 4. NemoSDK - Authorization Interface
```objectivec
//MainViewController.m
#import <NemoSDK/NemoSDK.h>
@interface MainViewController ()<LoginDelegate,IAPDelegate>
@end

@implementation MainViewController
  //return onLoginSuccess/onLoginFailure delegate
  [[NemoSDK sharedInstance] login];

  //return json string
  [[NemoSDK sharedInstance] getUserInfo]

  //use as onLogoutFailure/onLogoutSuccess Delegate
  [[NemoSDK sharedInstance] logout];

  #pragma Login Delegate

  - (void)onLoginFailure:(NSString *)message {
      NSLog(@"onLoginFailure = %@", message);
  }

  - (void)onLoginSuccess:(NSString *)access_token andIdToken:(NSString *)id_token {
      NSLog(@"onLoginSuccess = %@ - %@", access_token, id_token);
  }

  - (void)onLogoutFailure:(NSString *)message {
      NSLog(@"onLogoutFailure = %@", message);
  }

  - (void)onLogoutSuccess:(NSString *)message {
      NSLog(@"onLogoutSuccess = %@", message);
  }
```
<a name="integrate-nemosdk-iap"></a>
#### 5. In-app purchase
```objectivec
  - (void) call_iap
  {
    NSString *productID = @"vn.devapp.pack1";
    NSString *appleSecret = @"";
    NSString *orderID = @"";
    NSString *orderInfo = @"Item 300 gold";
    NSString *amount = @"22000";
    NSString *server = @"22";
    NSString *character = @"Character_Name";
    NSString *extraInfo = @"Extra_Info";
    NSString *userInfoString = [[NemoSDK sharedInstance] getUserInfo];
    NSJSONSerialization *userData = NULL;
    if([userInfoString length] > 0) {
        userData = [NSJSONSerialization JSONObjectWithData:[userInfoString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    }
    NSString *username = [userData valueForKey:@"sub"];
    
    IAPDataRequest *iapData = [[IAPDataRequest alloc] initWithData:username andOrderId:orderID andOrderInfo:orderInfo andServerID:server andAmount:amount andAppleProductID:productID andAppleShareSecrect:appleSecret andRoleID:character andExtraInfo:extraInfo];
    
    [[NemoSDK sharedInstance] showIAP:iapData andMainView:self andIAPDelegate:self];
  }

  #prama IAP delegate
  - (void) IAPInitFailed:(NSString *)message andErrorCode:(NSString *)errorCode {}
  - (void) IAPPurchaseFailed:(NSString *)message andErrorCode:(NSString *)errorCode {}
  - (void) IAPCompleted:(NSString *)message {}
```

<a name="integrate-nemosdktracking-appsflyer"></a>
## Integrate NemoSDKTracking
### I. Tracking with Appsflyer
- Embed NemoSDKTracking latest version and Third party framework into your project
- Some other libraries: [AppsFlyerLib.framework](https://github.com/itcgosucorp/nemosdk-ios/releases)

##### 1. Configure NemoSignIn in your project (default info.plist)
```xml    
    <key>AppsFlyerAppleID</key>
    <string>0123456789</string>
    <key>AppsFlyerKey</key>
    <string>AppsFlyerKey000001111</string>
    <key>NSUserTrackingUsageDescription</key>
    <string>This identifier will be used to deliver personalized ads to you.</string>
  ```
##### 2. AppsFlyerLib Framework Linker
<img width="475" alt="image" src="https://user-images.githubusercontent.com/94542020/207208331-8eb41bd6-a3f2-4f58-b122-700b881951bc.png">

##### 3. Initialize NemoSDKTracking
```objectivec
//AppDelegate.m
#import "NemoSDKTracking/NemoSDKTracking.h"

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[NemoSDKTracking sharedInstance] initTracking:application];
    application.applicationIconBadgeNumber = 0;
}
```

##### 4. Function Interface
```objectivec
[[NemoSDKTracking AppsFlyer] trackingEventLoginOnAF:@"userId" andAccount:@"account"];
[[NemoSDKTracking AppsFlyer] trackingEventOnAF:@"event_abc" withValues:@{
    @"key1": @"account1",
    @"key2": @"account2"
}];
[[NemoSDKTracking AppsFlyer] trackingLevelArchiveEventOnAF:@"userId" andAccount:@"account" andLevel:@"12301"];
```

<a name="integrate-nemosdktracking-firebase"></a>
### II. Tracking with Firebase
- Embed NemoSDKTracking latest version and Third party framework into your project
- Some other libraries: [Firebase SDK](https://github.com/itcgosucorp/nemosdk-ios/releases)

##### 1. Configure NemoSignIn in your project (default info.plist)
- Move GoogleService-Info.plist file into the root of your Xcode project. If prompted, select to add the config file to all targets.
- Insert -ObjC to “Other Linker Flags ”on Xcode Project: Main target -> build settings -> search "other linker flags"
- Configure Tracking Usage Description into .plist file (default: info.plist)*.
  Open with source and insert code: 
  ```xml
  <key>NSUserTrackingUsageDescription</key>
  <string>This identifier will be used to deliver personalized ads to you.</string>
  ```
  
##### 2. Firebase Framework Linker
<img width="473" alt="image" src="https://user-images.githubusercontent.com/94542020/207208287-654585c2-8892-4227-9da0-7176f3ddce81.png">

##### 3. Initialize NemoSDKTracking with Firebase
```objectivec
//AppDelegate.m
#import "NemoSDKTracking/NemoSDKTracking.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //...
    [[NemoSDKTracking sharedInstance] applicationDelegate:self andApplication:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}
```

##### 4. Function Interface
```objectivec
[[NemoSDKTracking Firebase] trackingEventOnFirebase:@"eventName" parameters:@{@"eventEventLogKey":@"eventEventLogValue"}];
[[NemoSDKTracking Firebase] trackingScreenOnFirebase:@"screenName" screenClass:@"screenClass"];
[[NemoSDKTracking Firebase] setUserPropertiesOnFirebase:@"userValue" forName:@"usernameName"];
```

By using the NemoSDK for iOS you agree to these terms.
