//
//  SdkConfig.h
//  GameSDK
//
//  Created by Nero-Macbook on 3/26/22.
//

@interface SdkConfig : NSObject {
}
//auth token
@property (nonatomic,strong) NSString *accessToken;
@property (nonatomic,assign) int expiresIn;
@property (nonatomic,strong) NSString *idToken;
@property (nonatomic,strong) NSString *refreshToken;
@property (nonatomic,strong) NSString *scope;
@property (nonatomic,strong) NSString *tokenType;
//user info
@property (nonatomic,strong) id userProfile;

@property (nonatomic,strong) NSDictionary *avatar;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,assign) bool emailVerified;
@property (nonatomic,strong) NSString *fullname;
@property (nonatomic,strong) NSString *lmsUserId;
@property (nonatomic,assign) bool metamaskLinked;
@property (nonatomic,strong) NSString *myReferId;
@property (nonatomic,strong) NSString *publicAddress;
@property (nonatomic,strong) NSString *referAddress;
@property (nonatomic,strong) NSString *referId;
@property (nonatomic,assign) int roleId;
@property (nonatomic,strong) NSString *sub;

@property (nonatomic,strong) NSString *deviceToken;
@property (nonatomic,strong) NSString *clientId;
@property (nonatomic,strong) NSString *redirectUrl;

@property (nonatomic,strong) NSString *authorizationEndpoint;
@property (nonatomic,strong) NSString *tokenEndpoint;
@property (nonatomic,strong) NSString *userinfoEndpoint;
@property (nonatomic,strong) NSString *issuer;
@property (nonatomic,strong) NSString *endSessionEndpoint;
@property (nonatomic,strong) NSString *tokenRevocationEndpoint;
@property (nonatomic,strong) NSString *tokenIntrospectionEndpoint;
@property (nonatomic,strong) NSArray *nemoScope;

@property (nonatomic, strong) NSString *sdkLanguage;
//new data
@property (nonatomic, strong) NSString *gameId;
@property (nonatomic, strong) NSString *gameClientID;
@property (nonatomic, strong) NSString *secrectKey;
@property (nonatomic, strong) NSArray *iapProductID;
@property (nonatomic, strong) NSString *sdkSignature;
@property (nonatomic, strong) NSString *firebaseFCMToken;
@property (nonatomic, strong) NSString *wsUsername;
@property (nonatomic, strong) NSString *wsPassword;
@property (nonatomic, strong) NSString *wsUsernameTest;
@property (nonatomic, strong) NSString *wsPasswordTest;
@property (nonatomic, strong) NSString *partnerID;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSString *environment;
@property (nonatomic, strong) NSString *priceType;
@property (nonatomic, assign) BOOL      walletAllow;
//data runtime
@property (nonatomic, strong) NSString *gameAccesstoken;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, strong) NSString *userStatus;
@property (nonatomic, strong) NSString *serverOrderID;
@property (nonatomic, assign) BOOL      serverIsReady;
@property (nonatomic, assign) BOOL      isProductReady;
@property (nonatomic, assign) BOOL      delAccountIsOpen;

@property (nonatomic,strong) id authState;

@property (nonatomic, strong) NSString *appsFlyerKey;
@property (nonatomic, strong) NSString *appsFlyerAppleID;
//server config data
+ (SdkConfig *) sharedInstance;
- (void)setAuthToken:(id)authToken;
- (SdkConfig *) loadConfig:(void(^)(NSString *))loadCallback;
- (void) resetDefaultData;

//new
- (void) updateAccessToken:(NSString *)accessToken;
- (void) setUserID:(NSString *)userID;
- (void) setUsername:(NSString *)username;
- (NSString *)getAdId;
- (id) apiConnect;
@end
