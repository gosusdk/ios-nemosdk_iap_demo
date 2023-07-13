//
//  NemoSDKTracking.h
//  NemoSDKTracking
//
//  Created by Nero-Macbook on 12/9/22.
//
#import <UIKit/UIKit.h>
#import <NemoSDKTracking/AppsflyerManager.h>
#import <NemoSDKTracking/FirebaseManager.h>

@interface NemoSDKTracking : NSObject{
}

+ (NemoSDKTracking *)sharedInstance;
+ (AppsflyerManager *)AppsFlyer;
+ (FirebaseManager *)Firebase;

- (void)initTracking:(UIApplication *)application;
- (BOOL)applicationDelegate:(id)appDelegate andApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end
