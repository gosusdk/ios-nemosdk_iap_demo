//
//  NemoSDK.h
//  NemoTest
//
//  Created by Nero-Macbook on 10/23/22.
//

#import <UIKit/UIKit.h>
#import <NemoSDK/LoginDelegate.h>
#import <NemoSDK/IAPDataRequest.h>

@interface NemoSDK : NSObject{
}

+ (NemoSDK *)sharedInstance;
@property (nonatomic,strong) id<LoginDelegate> loginDelegate;

-(void)sdkInit;
- (NSString *)getUserInfo;

- (void)login;
- (void)logout;
//with uiViewController
- (void)login:(UIViewController *)viewController;
- (void)logout:(UIViewController *)viewController;


- (NSString *)getRefreshToken;
- (NSString *)getIdToken;
- (void) showIAP:(IAPDataRequest *) iapData andMainView:(UIViewController *) mainView andIAPDelegate:(id<IAPDelegate>) iAPDelegate;
@property (nonatomic, strong) id<IAPDelegate> sdkDelegate;
- (void) terminateIAP;
@end
