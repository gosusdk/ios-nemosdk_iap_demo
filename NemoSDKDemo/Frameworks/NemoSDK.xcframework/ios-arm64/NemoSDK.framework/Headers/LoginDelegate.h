//
//  LoginDelegate.h
//  NemoSDK
//
//  Created by Nero-Macbook on 10/26/22.
//

#pragma Login Delegate
@protocol LoginDelegate <NSObject>
@required
- (void) onLoginSuccess:(NSString *)access_token andIdToken:(NSString *)id_token;
- (void) onLoginFailure:(NSString *) message;
- (void) onLogoutSuccess:(NSString *) message;
- (void) onLogoutFailure:(NSString *) message;

@end

#pragma Logout Delegate
@protocol LogoutDelegate <NSObject>
@required
- (void) logoutSuccess;
- (void) logoutFail:(NSString *) message;
@end
