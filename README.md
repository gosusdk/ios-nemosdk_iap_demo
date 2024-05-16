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
  - Nemo Tracking

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
  - Accelerate.framework
  - AdSupport.framework
  - AppTrackingTransparency.framework

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
### With Facebook IOS SDK version 13 or latest
  - Create a swift file (arbitrary name), confirm "Create Bridging Header" when prompt appear
  - Enable Modules (C and Objective-C) set to YES: Target --> Build Settings --> Enable Modules (C and Objective-C)

# Configuration
- Insert -ObjC -lc++ -lz to “Other Linker Flags ”on Xcode Project: Main target -> build settings -> search "other linker flags"
- Configure GameClientID into .plist file (default: info.plist)*. IN the <string> tag, key GameClientID will be provided privately via email
```xml
<key>GameClientID</key>
<string>GameClientID</string>
```
- Configure GameSdkSignature into .plist file (default: info.plist)*. IN the <string> tag, key GameSdkSignature will be provided privately via email
```xml
<key>GameSdkSignature</key>
<string>GameSDKSignature</string>
```
### GRPC Framework Embed
  ![image](https://user-images.githubusercontent.com/94542020/160530360-23295245-4eb7-4f0b-b04b-cbcfee270a7e.png)
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
    [[NemoSDKTracking GTracking] applicationDelegate:self andApplication:application didFinishLaunchingWithOptions:launchOptions];
    [[NemoSDK sharedInstance] sdkInit];
    return YES;
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[NemoSDKTracking GTracking] registerForRemoteNotifications:deviceToken];
}
```
#### 4. NemoSDK - Authorization Interface
```objectivec
//MainViewController.m
#import <NemoSDK/NemoSDK.h>
@interface MainViewController ()<LoginDelegate,IAPDelegate>
@end

@implementation MainViewController
  [NemoSDK sharedInstance].loginDelegate = self;
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
  //MainViewController.m
  #import <NemoSDK/NemoSDK.h>
  @interface MainViewController ()<LoginDelegate,IAPDelegate>
  @end
  
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
    /**
    * OrderID: Partner's order number
    * OrderInfo: Item description
    * ServerID: ID of the server
    * Amount: Price of the item
    * ProductID: Item code
    * AppleShareSecrect: Empty
    * RoleID: ID of the character
    * ExtraInfo: Additional information that partners can send, which will be sent to the API to add gold after IAP payment.
    **/
  }

  #prama IAP delegate
  - (void) IAPInitFailed:(NSString *)message andErrorCode:(NSString *)errorCode {}
  - (void) IAPPurchaseFailed:(NSString *)message andErrorCode:(NSString *)errorCode {}
  - (void) IAPCompleted:(NSString *)message {}
```
#### 6. Delete Account
```objectivec
  ### Check account deletion status
  if([SdkConfig sharedInstance].delAccountIsOpen) {
      ## show deletion button
  }
  ### Call deletion API
  [[NemoSDK sharedInstance] deleteAccountAndSuccess:^{
      NSLog(@"delete account on Success");
  }];
```
<a name="integrate-nemosdktracking-appsflyer"></a>
## Integrate NemoSDKTracking
### I. Tracking with Appsflyer
- Embed NemoSDKTracking latest version and Third party framework into your project
- Some other libraries: [AppsFlyerLib.framework](https://github.com/itcgosucorp/nemosdk-ios/releases)

##### 1.Configure GTracking in your project (default info.plist)
- Configure Tracking Usage Description into .plist file (default: info.plist)*.
```xml
    <key>AirbAppName</key>
    <string>sdkgosutest</string>
    <key>AirbAppToken</key>
    <string>d878da2af447440385fe9a4fe37b06a0</string>
    <key>NSUserTrackingUsageDescription</key>
    <string>This identifier will be used to deliver personalized ads to you.</string>
```

##### 2. Initialize NemoSDKTracking
```objectivec
//AppDelegate.m
#import "NemoSDKTracking/NemoSDKTracking.h"

//AppDelegate.m
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[NemoSDKTracking GTracking] applicationDelegate:self andApplication:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[NemoSDKTracking GTracking] registerForRemoteNotifications:deviceToken];
}
```

##### 4. Function Interface
```objectivec
- (void) callGTrackingExample {
    NSString *sub = @"123456"; //user-id
    //tracking start trial
    [[NemoSDKTracking GTracking] showSignInSDK];
    [[NemoSDKTracking GTracking] trackingSignIn:sub andUsername:sub andEmail:@"email"];
    [[NemoSDKTracking GTracking] trackingStartTrial:sub];
    
    //tracking Turial Completion
    [[NemoSDKTracking GTracking] trackingTurialCompleted:sub];
    
    [[NemoSDKTracking GTracking] trackingEvent:@"level_20"];
    
    [[NemoSDKTracking GTracking] trackingEvent:[NSString stringWithFormat:@"level_%d", 20]];
    
    [[NemoSDKTracking GTracking] doneNRU:sub andServerId:@"server_id" andRoleId:@"role_id" andRoleName:@"role_name"];
    
    [[NemoSDKTracking GTracking] checkout:sub andProductId:@"productId" andAmount:@"22000" andCurrency:@"VND" andUsername:sub];
    
    [[NemoSDKTracking GTracking] purchase:sub andProductId:@"productId" andAmount:@"22000" andCurrency:@"VND" andUsername:sub];
    
    [[NemoSDKTracking GTracking] trackingEvent:@"level_20" withValues:@{@"customerId": @"12345"}];
    
    [[NemoSDKTracking GTracking] trackingEvent:@"user_checkinday_1"];
}
```

By using the NemoSDK for iOS you agree to these terms.
