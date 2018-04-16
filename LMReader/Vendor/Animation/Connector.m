//
//  Connector.m
//  ChaseBook
//
//  Created by Mac on 14-4-28.
//  Copyright (c) 2014年 iLemi. All rights reserved.
//

#import "Connector.h"
#import "Equipment.h"

@implementation Connector
-(NSString *)getUrl:(NSInteger)idI url:(NSString *)uStr
{
    ConfigDao *dao = [[ConfigDao alloc]init];
    
    NSString *uid=[dao getValueByName:@"uid"];
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [info subscriberCellularProvider];
//    //手机设备号
    NSString *imei=@"aaa";
    NSString *s = [NSString stringWithFormat:@"%@%@",carrier.mobileCountryCode,carrier.mobileNetworkCode];
    NSString *system_version = [UIDevice currentDevice].systemVersion;
//    //手机卡
    NSString *imsi=@"aaaa";
    NSString *iccid=@"aaaa";
    NSString *simopr = s;
    NSString *opr = [carrier mobileNetworkCode];;
    NSString *networkopr = carrier.carrierName;
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *chan=@"IOS";
    Equipment  *eq = [[Equipment alloc]init];
    NSString *ua=[eq getModel];
   
    NSString *platform = @"IOS";
    
    NSString *profileid=@"2020";
    NSString *lan=@"zh";
    NSString *url;
    switch (idI)
    {
        case 0:
            url = @"booklist.action";
            break;
        case 1:
            url = @"librarylist.action";
            break;
        case 2:
            url = @"librarysort.action";
            break;
        case 3:
            url = @"search.action";
            break;
        case 4:
            url = @"bookinfo.action";
            break;
        case 5:
            url = @"nbpdownload.action";
            break;
        case 6:
            url = @"findbook.action";
            break;
        case 7:
            url = @"feedback.action";
            break;
        case 8:
            url = @"cover.action";
            break;
        case 9:
            url = @"keywords.action";
            break;
        case 10:
            url = @"searchsort.action";
            break;
        case 11:
            url = @"deletebook.action";
            break;
        case 12:
            url = @"carebook.action";
            break;
        case 13:
            url = @"bookcatalog.action";
            break;
        case 14:
            url = @"libraryrecommended.action";
            break;
        case 15:
            url = @"installinfo.action";
            break;
        default:
            break;
    } 
    NSString *commonParam=[[NSString alloc]initWithFormat:@"%@%@?ver=%@&platform=%@&uid=%@&imei=%@&imsi=%@&iccid=%@&opr=%@&networkopr=%@&simopr=%@&system_version=%@&chan=%@&appid=0&profileid=%@&lan=%@&ua=%@&tokenStr=%@",uStr,url,version,platform,uid,imei,imsi,iccid,opr,networkopr,simopr,system_version,chan,profileid,lan,ua,[[NSUserDefaults standardUserDefaults] objectForKey:@"tokenID"]];
    return commonParam;
}
@end
