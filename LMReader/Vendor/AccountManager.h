//
//  AccountManager.h
//  StockEmotion
//
//  Created by dida on 15/11/19.
//  Copyright © 2015年 StockEmotion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPRequest.h"
//#import "UserInfo.h"

@interface AccountManager : NSObject

//@property (nonatomic, strong) UserInfo *userInfo;

@property (nonatomic, assign)BOOL isLogin;

@property (nonatomic, strong) NSString *cellPhone;

@property (nonatomic, assign)BOOL isNeedWelPage;
+ (AccountManager *)shareAccount;

+ (void)loginWithPhone:(NSString *)phone vcode:(NSString *)vcode success:(HttpRequestSuccessBlock)success fail:(HttpRequestFailureBlock)fail;
+ (void)autoLoginsuccess:(HttpRequestSuccessBlock)success fail:(HttpRequestFailureBlock)fail;

+ (void)loginOutsuccess:(HttpRequestSuccessBlock)success fail:(HttpRequestFailureBlock)fail;

+ (void)postCilentInfo;

+ (void)outAutoLoginAccount;

+ (void)saveAppVersion;
@end
