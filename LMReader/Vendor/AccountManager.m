//
//  AccountManager.m
//  StockEmotion
//
//  Created by dida on 15/11/19.
//  Copyright © 2015年 StockEmotion. All rights reserved.
//

#import "AccountManager.h"

#import "HTTPRequest.h"

//#import "JNKeychain.h"

//#import "AppConfig.h"

//#import "FileTool.h"

//#import "NSString+MD5.h"

//#import "GeTuiSdk.h"

#define Key_AutoLoginAccount        @"StockEmotion_AutoLoginAccount"
#define Key_LastVersion             @"StockEmotion_LastVersion"
@implementation AccountManager

static AccountManager *account = NULL;

+ (AccountManager *)shareAccount {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        account = [[AccountManager alloc] init];
    });
    return account;
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}



+ (void)loginWithPhone:(NSString *)phone vcode:(NSString *)vcode success:(HttpRequestSuccessBlock)success fail:(HttpRequestFailureBlock)fail
{
//    UIScreen *screen=[UIScreen mainScreen];
//    NSString *screenStr = [NSString stringWithFormat:@"%.1f,%d*%d",screen.scale,(int)screen.bounds.size.height,(int)screen.bounds.size.width];
//    UIDevice *device=[[UIDevice alloc]init];
//    NSString *system=[NSString stringWithFormat:@"%@%@",device.systemName,device.systemVersion];
//    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
//    [dic setObject:vcode forKey:@"vcode"];
//    [dic setObject:system forKey:@"os"];
//    [dic setObject:device.name forKey:@"model"];
//    [dic setObject:screenStr forKey:@"screen"];
//    [dic setObject:phone forKey:@"id"];
//    [HTTPRequest postRequestWithUrl:API_Login params:dic success:^(NSDictionary *responseDict) {
//        NSString *stauts=[responseDict objectForKey:@"status"];
//        if (stauts.intValue==100)
//        {
//            UserInfo *userInfo=[[UserInfo alloc]initWithJSON:responseDict];
//            [AccountManager shareAccount].userInfo=userInfo;
//            
//            if (![[AccountManager shareAccount].cellPhone isEqualToString:phone]) {
//                [FileTool deleteHistoryDataFromUserDomainMask:HistoryPath];
//            }
//            [self saveAutoLoginAccount:phone];
//        }
//        else
//        {
//            [self outAutoLoginAccount];
//        }
//        if (success) {
//            success(responseDict);
//        }
//        
//    } fail:^(NSString *errorMsg) {
//        
//    }];
}


+ (void)autoLoginsuccess:(HttpRequestSuccessBlock)success fail:(HttpRequestFailureBlock)fail {
//    [HTTPRequest postRequestWithUrl:API_Verify params:nil success:^(NSDictionary *responseDict) {
//        NSString *stauts=[responseDict objectForKey:@"status"];
//        if (stauts.intValue==100)
//        {
//            UserInfo *userInfo=[[UserInfo alloc]initWithJSON:responseDict];
//            [AccountManager shareAccount].userInfo=userInfo;
//        }
//        else
//        {
//            [self outAutoLoginAccount];
//        }
//        
//        if (success) {
//            success(responseDict);
//        }
//    } fail:^(NSString *errorMsg) {
//        [self outAutoLoginAccount];
//    }];
}
+(void)outAutoLoginAccount
{
//    [AccountManager shareAccount].userInfo=nil;
//    NSDictionary *dic=[JNKeychain loadValueForKey:Key_AutoLoginAccount];
//    if (dic) {
//        NSDictionary* lastLogin = @{@"phoneNumber":dic[@"phoneNumber"], @"isAutoLogin":@0};
//        [JNKeychain saveValue:lastLogin forKey:Key_AutoLoginAccount];
//    }
}
+(void)saveAutoLoginAccount:(NSString*)phoneNumber {
//    phoneNumber = [phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    
//    if([phoneNumber length] <= 0){
//        NSLog(@"saveAutoLoginAccount--error-->%@", phoneNumber);
//        return;
//    }
//    NSDictionary* lastLogin = @{@"phoneNumber":phoneNumber, @"isAutoLogin":@1};
//    [JNKeychain saveValue:lastLogin forKey:Key_AutoLoginAccount];
}
+(void)loginOutsuccess:(HttpRequestSuccessBlock)success fail:(HttpRequestFailureBlock)fail
{
//    [self outAutoLoginAccount];
//        if (success) {
//            success(nil);
//        }
//    [HTTPRequest postRequestWithUrl:API_LoginOut params:nil success:^(NSDictionary *responseDict) {
//        NSString *stauts=[responseDict objectForKey:@"status"];
//        if (stauts.intValue<=100) {
//           
//        }
//        
//    } fail:^(NSString *errorMsg) {
//        
//    }];
}
+(void)postCilentInfo
{
//    UIScreen *screen=[UIScreen mainScreen];
//    NSString *screenStr = [NSString stringWithFormat:@"%.1f,%d*%d",screen.scale,(int)screen.bounds.size.height,(int)screen.bounds.size.width];
//    UIDevice *device=[[UIDevice alloc]init];
//    NSString *system=[NSString stringWithFormat:@"%@%@",device.systemName,device.systemVersion];
//    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
//    [dic setObject:system forKey:@"os"];
//    [dic setObject:device.name forKey:@"model"];
//    [dic setObject:screenStr forKey:@"screen"];
//    [dic setObject:[NSString getIPAddress] forKey:@"mac"];
//    [dic setObject:[GeTuiSdk version] forKey:@"gtsdk"];
//    if ([GeTuiSdk clientId]) {
//        [dic setObject:[GeTuiSdk clientId] forKey:@"gtcid"];
//    }
//    else {
//        [dic setObject:@"" forKey:@"gtcid"];
//    }
//    [dic setObject:@"iOS" forKey:@"shop"];
//    [HTTPRequest postRequestWithUrl:API_ClientInfo params:dic success:^(NSDictionary *responseDict) {
//        NSString *status=responseDict[@"status"];
//        if (status.intValue==100) {
//        }
//    } fail:^(NSString *errorMsg) {
//        
//    }];
}
+(void)saveAppVersion
{
//    [JNKeychain saveValue:[AppConfig appVersion] forKey:Key_LastVersion];
}

-(NSString *)cellPhone
{
//   NSDictionary *dic=[JNKeychain loadValueForKey:Key_AutoLoginAccount];
//    return [dic objectForKey:@"phoneNumber"];
    return nil;
}
-(BOOL)isLogin
{
//    NSDictionary *dic=[JNKeychain loadValueForKey:Key_AutoLoginAccount];
//    NSNumber *islogin=[dic objectForKey:@"isAutoLogin"];
//
//    return islogin.intValue>0?YES:NO;
    return YES;
}
-(BOOL)isNeedWelPage
{
//    NSString *lastVersion=[JNKeychain loadValueForKey:Key_LastVersion];
//    NSString *currentVersion=[AppConfig appVersion];
//    return ![lastVersion isEqualToString:currentVersion];
    return YES;
}
@end
