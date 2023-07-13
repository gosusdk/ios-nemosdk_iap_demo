
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)
#define IS_IPHONE (!IS_IPAD)

#import "MainViewController.h"
#import <NemoSDK/NemoSDK.h>
#import <NemoSDK/SdkConfig.h>
#import <NemoSDKTracking/NemoSDKTracking.h>


@interface MainViewController ()<LoginDelegate,IAPDelegate>

@end

@implementation MainViewController

#pragma Login Delegate

- (void)onLoginFailure:(NSString *)message {
    NSLog(@"onLoginFailure = %@", message);
//    [[SdkHelper sharedInstance] showAlertMessage:self andWithTitle:@"onLoginFailure" andWithMessage:message andCallback:nil];
}

- (void)onLoginSuccess:(NSString *)access_token andIdToken:(NSString *)id_token {
    NSLog(@"onLoginSuccess = %@ - %@", access_token, id_token);
    [[NemoSDKTracking AppsFlyer] trackingEventLoginOnAF:@"userId" andAccount:@"neropro"];
    [[NemoSDKTracking AppsFlyer] trackingEventOnAF:@"event_abc" withValues:@{
        @"key1": @"nero1",
        @"key2": @"nero2"
    }];
    [[NemoSDKTracking AppsFlyer] trackingLevelArchiveEventOnAF:@"userId" andAccount:@"nerocasten" andLevel:@"12301"];
    _btn_showiap.hidden = NO;
    _btn_userinfo.hidden = NO;
    _btn_logout.hidden = NO;
    _btn_signin.hidden = YES;
}

- (void) onLogoutSuccess:(NSString *)message
{
    NSLog(@"onLogoutSuccess = %@", message);
//    _btn_showiap.hidden = YES;
    _btn_userinfo.hidden = YES;
    _btn_logout.hidden = YES;
    _btn_signin.hidden = NO;
}

- (IBAction)btnSignIn:(id)sender {
    [[NemoSDK sharedInstance] login:self];
}


- (IBAction)btnUserInfo:(id)sender {
    NSLog(@"userInfo = %@", [[NemoSDK sharedInstance] getUserInfo]);
    NSLog(@"refreshToken = %@", [[NemoSDK sharedInstance] getRefreshToken]);
    [self callTrackingFirebaseExample];
    if([[NemoSDK sharedInstance] getUserInfo]) {
        NSLog(@"show abc");
    }
}
- (IBAction)btnLogout:(id)sender {
    [[NemoSDK sharedInstance] logout];
}
- (IBAction)btnClickShowIAP:(id)sender {
    NSString *productID = @"vn.devapp.pack1";
    /* password from apple share secret (chuỗi thông tin khi tạo các gói Automatically Renewable Subscription) - dùng để verify iap, trường hợp không phải gói Automatically Renewable Subscription thì để trống */
    NSString *appleSecret = @"";
    //orderID was gernarate from server game and only one (mã hoá đơn là duy nhất không được trùng)
    NSString *orderID = [NSString stringWithFormat:@"%i_10095276_2_13_11", (int)[[NSDate date] timeIntervalSince1970]];
    //description package will purchase (mô tả gói cần mua)
    NSString *orderInfo = @"Item 300 gold";
    //amount
    NSString *amount = @"22000";//this is amount of money (VNĐ)
    //server
    NSString *server = @"22";
    NSString *character = @"Character_Name";
    NSString *extraInfo = @"Extra_Info";
    NSString *userInfoString = [[NemoSDK sharedInstance] getUserInfo];
    NSJSONSerialization *userData = NULL;
    if([userInfoString length] > 0) {
        userData = [NSJSONSerialization JSONObjectWithData:[userInfoString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    }
    if(!userData) {
//        return;
    }
    NSString *username = [userData valueForKey:@"sub"];
    orderID = @"";
    //Show log value of parameters
    NSLog(@"product_id:%@, apple_secret:%@, order_id:%@, orderInfo:%@, amount:%@, server:%@, username:%@", productID, appleSecret, orderID, orderInfo, amount, server, _userName);
    IAPDataRequest *iapData = [[IAPDataRequest alloc] initWithData:username andOrderId:orderID andOrderInfo:orderInfo andServerID:server andAmount:amount andAppleProductID:productID andAppleShareSecrect:appleSecret andRoleID:character andExtraInfo:extraInfo];
    
    [[NemoSDK sharedInstance] showIAP:iapData andMainView:self andIAPDelegate:self];
}
- (void) IAPInitFailed:(NSString *)message andErrorCode:(NSString *)errorCode
{
    dispatch_block_t block = ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Init IAP Failed!" message:message delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert show];
    };
    //
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}
- (void) IAPPurchaseFailed:(NSString *)message andErrorCode:(NSString *)errorCode
{
    dispatch_block_t block = ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Purchase IAP Failed!" message:message delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert show];
    };
    //
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}
- (void) IAPCompleted:(NSString *)message
{
    dispatch_block_t block = ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Payment Success!" message:message delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert show];
    };
    //
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

- (void)viewDidLoad
{
    NSLog(@"load view");
    [NemoSDK sharedInstance].loginDelegate = self;
    [super viewDidLoad];
    _btn_showiap.hidden = YES;
    _btn_userinfo.hidden = YES;
    _btn_signin.hidden = NO;
    _btn_logout.hidden = YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)OrientationDidChange:(NSNotification*)notification
{
    //    CGSize size = [[UIScreen mainScreen] bounds].size;
    //    CGRect frame = self.view.frame;
    //    if(size.width == frame.size.width)
    //        return;
    
    //NSLog(@"w = %f, h = %f", size.width, size.height);
}
- (void) callTrackingFirebaseExample {
    //tracking start trial
        [[NemoSDKTracking Firebase] trackingEventOnFirebase:@"eventName" parameters:@{@"eventEventLogKey":@"eventEventLogValue"}];
        [[NemoSDKTracking Firebase] trackingScreenOnFirebase:@"screenName" screenClass:@"screenClass"];
        [[NemoSDKTracking Firebase] setUserPropertiesOnFirebase:@"userValue" forName:@"usernameName"];
    
}

//=========== Payment Apple IAP ==============//
- (IBAction) callIAP:(id)sender
{
    
}

#pragma Click PlayGame

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
