//
//  AppDelegate.m
//  NemoSDKDemo
//
//  Created by Nero-Macbook on 7/12/23.
//

#import "AppDelegate.h"
#import "MainViewController.h"
//for SDK
#import <NemoSDK/NemoSDK.h>
#import <UserNotifications/UserNotifications.h>
#import <NemoSDKTracking/NemoSDKTracking.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MainViewController *mc = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
    _navigationcontroller = [[UINavigationController alloc]initWithRootViewController:mc];
//    _navigationcontroller.navigationBarHidden = YES;
    _window.rootViewController = _navigationcontroller;
    [_window makeKeyAndVisible];
    
    //init SDK
    NSLog(@"DEMLOG = 1");
    
    [[NemoSDK sharedInstance] sdkInit];
    
    [[NemoSDKTracking sharedInstance] applicationDelegate:self andApplication:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive");
    [[NemoSDKTracking sharedInstance] initTracking:application];
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    //reset owner billing had payment
    [[NemoSDK sharedInstance] terminateIAP];
}

// [START ios_10_data_message]
//- (void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage {
//    NSLog(@"APNs Received data message: %@", remoteMessage);
//}
// [END ios_10_data_message]

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"APNs Unable to register for remote notifications: %@", error);
}

// This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
// If swizzling is disabled then this function must be implemented so that the APNs device token can be paired to
// the FCM registration token.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"APNs device token retrieved: %@", deviceToken);
    NSString *deviceTokenString = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""] stringByReplacingOccurrencesOfString: @">" withString: @""] stringByReplacingOccurrencesOfString: @" " withString: @""];
    //set value for SDK
//    [[GameSDK sharedInstance] gameInfo].devicetoken = deviceTokenString;
    //tracking uninstall
//    [[NemoSDK sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

// [START receive_message]
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
    fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
  // If you are receiving a notification message while your app is in the background,
  // this callback will not be fired till the user taps on the notification launching the application.
  // TODO: Handle data of notification

  // With swizzling disabled you must let Messaging know about the message, for Analytics
  // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];

  // ...

    // Print full message.
    NSLog(@"APNs receive_message %@", userInfo);

  completionHandler(UIBackgroundFetchResultNewData);
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    

    // Print full message.
    NSLog(@"APNs full message. %@", userInfo);
}

// [END receive_message]

// [START ios_10_message_handling]
// Receive displayed notifications for iOS 10 devices.
// Handle incoming notification messages while app is in the foreground.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)){
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    
    NSLog(@"push message");

    // Print full message.
//    [[GinSDK Firebase] showInAppMessage:userInfo];

    // Change this to your preferred presentation option
    completionHandler(UNNotificationPresentationOptionBadge);
}

// Handle notification messages after display notification is tapped by the user.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler {
  NSDictionary *userInfo = response.notification.request.content.userInfo;
  

  // With swizzling disabled you must let Messaging know about the message, for Analytics
  // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    
    NSLog(@"push message");
    
    
}


@end
