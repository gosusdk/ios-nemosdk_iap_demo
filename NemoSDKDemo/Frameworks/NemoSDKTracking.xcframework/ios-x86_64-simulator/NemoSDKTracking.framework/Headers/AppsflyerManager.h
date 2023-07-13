//
//  AppsflyerManager.h
//  GameSDK
//
//  Created by Nero-Macbook on 11/10/21.
//

#import <AppsFlyerLib/AppsFlyerLib.h>

@interface AppsflyerManager : NSObject {
    
}

+ (AppsflyerManager *) sharedInstance;
- (void) initAppsFlyer;
- (void) startAppsflyer;
- (void) startAppsflyerWithInterval;
- (void) setCustomerUserID:(NSString *)userId;
- (void) trackingLaunchOnAF;
- (void) trackingUninstallOnAF:(NSData *)deviceToken;
- (void) trackingEventOnAF:(NSString *)eventName withValues:(NSDictionary*)values;
//call from game client
- (void)trackingTurialCompletedEventOnAF:(NSString *)userId andAccount:(NSString *)account;
- (void)trackingLevelArchiveEventOnAF:(NSString *)userId andAccount:(NSString *)account andLevel:(NSString *)level;
- (void) trackingArchiveUnlockEventOnAF:(NSString *)userId andAccount:(NSString *)account andLevel:(NSString *)level;
- (void) trackingSpentCreditEventOnAF:(NSString *)userId andAccount:(NSString *)account andLevel:(NSString *)level;
- (void)trackingStartTrialEventOnAF:(NSString *)userId andAccount:(NSString *)account;
- (void) trackingEventLoginOnAF:(NSString *)userId andAccount:(NSString *)account;
@end
