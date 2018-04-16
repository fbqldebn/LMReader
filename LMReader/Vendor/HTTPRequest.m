//
//  HTTPRequest.m
//  worde
//
//  Created by dida on 15/11/11.
//  Copyright © 2015年 wordemotion. All rights reserved.
//

#import "HTTPRequest.h"
#import "AccountManager.h"
//#import "AppConfig.h"

#define VisitorCellPhone @"00000000000"

@implementation HTTPRequest


+(NSURLSessionDataTask *)getRequestDocumentWithUrl:(NSString *)urlString params:(NSDictionary *)params success:(HttpRequestDocumentSuccessBlock)success fail:(HttpRequestFailureBlock)fail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    
    
    
    
    //获取设备信息
    ConfigDao *dao = [[ConfigDao alloc]init];
    
    NSString *uid=[dao getValueByName:@"uid"];
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    //手机设备号
    NSString *imei=@"";
    NSString *s = [NSString stringWithFormat:@"%@%@",carrier.mobileCountryCode,carrier.mobileNetworkCode];
    NSString *system_version = [UIDevice currentDevice].systemVersion;
    //手机卡
    NSString *imsi=@"";
    NSString *iccid=@"";
    NSString *simopr = s;
    NSString *opr = [carrier mobileNetworkCode];;
    NSString *networkopr = carrier.carrierName;
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *chan=@"IOS";
    Equipment  *eq = [[Equipment alloc]init];
    NSString *ua=[eq getModel];
    
    NSString *platform = @"IOS";
    
    NSString *profileid=@"2020";
    
    NSString *lan=@"zh";
    
    NSString *commonParam=[[[[NSString alloc]initWithFormat:@"ver=%@&platform=%@&uid=%@&imei=%@&imsi=%@&iccid=%@&opr=%@&simopr=%@&networkopr=%@&system_version=%@&chan=%@&appid=%@&profileid=%@&lan=%@&ua=%@",version,platform,uid,imei,imsi,iccid,opr,simopr,networkopr,system_version,chan,[infoDictionary objectForKey:@"appId"],profileid,lan,ua] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString * requestString=[[NSString alloc]initWithFormat:@"%@?%@",urlString,commonParam];
    
    NSEnumerator *keys=[params keyEnumerator];
    
    for (NSString *key in keys)
    {
        NSString *value=  [params objectForKey:key];
        if (value) {
            requestString=[requestString stringByAppendingFormat:@"&%@=%@",key,value];
        }
    }
    NSLog(@"requestString    ^^^^^^^^^^    %@",requestString);
    return [manager GET:requestString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //开始解析
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding error:nil];
        
        //取到根节点
//        GDataXMLElement *rootElement = [doc rootElement];
        
        if (success) {
            success(doc);
        }
        
        
        
        
        
        //
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n\nrequest error url--->\n%@\nerror--->\n%@\n\n", urlString, error);
        if (fail) {
            fail([error localizedDescription]);
        }
    }];
    

}

//GET
+ (NSURLSessionDataTask *)getRequestWithUrl:(NSString*)urlString params:(NSDictionary *)params success:(HttpRequestSuccessBlock)success fail:(HttpRequestFailureBlock)fail {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    
    
    
    
    //获取设备信息
    ConfigDao *dao = [[ConfigDao alloc]init];
    
    NSString *uid=[dao getValueByName:@"uid"];
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    //手机设备号
    NSString *imei=@"";
    NSString *s = [NSString stringWithFormat:@"%@%@",carrier.mobileCountryCode,carrier.mobileNetworkCode];
    NSString *system_version = [UIDevice currentDevice].systemVersion;
    //手机卡
    NSString *imsi=@"";
    NSString *iccid=@"";
    NSString *simopr = s;
    NSString *opr = [carrier mobileNetworkCode];;
    NSString *networkopr = carrier.carrierName;
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *chan=@"IOS";
    Equipment  *eq = [[Equipment alloc]init];
    NSString *ua=[eq getModel];
    
    NSString *platform = @"IOS";
    
    NSString *profileid=@"2020";
    
    NSString *lan=@"zh";
    
    NSString *commonParam=[[[[NSString alloc]initWithFormat:@"ver=%@&platform=%@&uid=%@&imei=%@&imsi=%@&iccid=%@&opr=%@&simopr=%@&networkopr=%@&system_version=%@&chan=%@&appid=%@&profileid=%@&lan=%@&ua=%@",version,platform,uid,imei,imsi,iccid,opr,simopr,networkopr,system_version,chan,[infoDictionary objectForKey:@"appId"],profileid,lan,ua] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString * requestString=[[NSString alloc]initWithFormat:@"%@?%@",urlString,commonParam];
    
    NSEnumerator *keys=[params keyEnumerator];
    
    for (NSString *key in keys)
    {
        NSString *value=  [params objectForKey:key];
        if (value) {
            requestString=[requestString stringByAppendingFormat:@"&%@=%@",key,value];
        }
    }
    NSLog(@"requestString    ^^^^^^^^^^    %@",requestString);
    return [manager GET:requestString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //开始解析
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding error:nil];
       
        //取到根节点
        GDataXMLElement *rootElement = [doc rootElement];
        
        if (success) {
            success(rootElement);
        }
        
        
            
            
        
        //
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n\nrequest error url--->\n%@\nerror--->\n%@\n\n", urlString, error);
        if (fail) {
            fail([error localizedDescription]);
        }
    }];
    
    
   
}


// Document handling methods
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
}
// DTD handling methods for various declarations.
- (void)parser:(NSXMLParser *)parser foundNotationDeclarationWithName:(NSString *)name publicID:(nullable NSString *)publicID systemID:(nullable NSString *)systemID
{
    
}

- (void)parser:(NSXMLParser *)parser foundUnparsedEntityDeclarationWithName:(NSString *)name publicID:(nullable NSString *)publicID systemID:(nullable NSString *)systemID notationName:(nullable NSString *)notationName
{
    
}

- (void)parser:(NSXMLParser *)parser foundAttributeDeclarationWithName:(NSString *)attributeName forElement:(NSString *)elementName type:(nullable NSString *)type defaultValue:(nullable NSString *)defaultValue
{
    
}

- (void)parser:(NSXMLParser *)parser foundElementDeclarationWithName:(NSString *)elementName model:(NSString *)model
{
    
}

- (void)parser:(NSXMLParser *)parser foundInternalEntityDeclarationWithName:(NSString *)name value:(nullable NSString *)value
{
    
}

- (void)parser:(NSXMLParser *)parser foundExternalEntityDeclarationWithName:(NSString *)name publicID:(nullable NSString *)publicID systemID:(nullable NSString *)systemID
{
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict
{
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{
    
}

- (void)parser:(NSXMLParser *)parser didStartMappingPrefix:(NSString *)prefix toURI:(NSString *)namespaceURI
{
    
}

- (void)parser:(NSXMLParser *)parser didEndMappingPrefix:(NSString *)prefix
{
    
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
}
- (void)parser:(NSXMLParser *)parser foundIgnorableWhitespace:(NSString *)whitespaceString
{
    
}
- (void)parser:(NSXMLParser *)parser foundProcessingInstructionWithTarget:(NSString *)target data:(nullable NSString *)data
{
    
}

- (void)parser:(NSXMLParser *)parser foundComment:(NSString *)comment
{
    
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    
}
- (nullable NSData *)parser:(NSXMLParser *)parser resolveExternalEntityName:(NSString *)name systemID:(nullable NSString *)systemID
{
    return nil;
}
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
{
    
}

//POST
+ (NSURLSessionDataTask *)postRequestWithUrl:(NSString*)urlString params:(NSMutableDictionary *)params success:(HttpRequestSuccessBlock)success fail:(HttpRequestFailureBlock)fail {
    
    
    //获取设备信息
    ConfigDao *dao = [[ConfigDao alloc]init];
    
    NSString *uid=[dao getValueByName:@"uid"];
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    //手机设备号
    NSString *imei=@"";
    NSString *s = [NSString stringWithFormat:@"%@%@",carrier.mobileCountryCode,carrier.mobileNetworkCode];
    NSString *system_version = [UIDevice currentDevice].systemVersion;
    //手机卡
    NSString *imsi=@"";
    NSString *iccid=@"";
    NSString *simopr = s;
    NSString *opr = [carrier mobileNetworkCode];;
    NSString *networkopr = carrier.carrierName;
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *chan=@"IOS";
    Equipment  *eq = [[Equipment alloc]init];
    NSString *ua=[eq getModel];
    
    NSString *platform = @"IOS";
    
    NSString *profileid=@"2020";
    NSString *lan=@"zh";
    NSString *commonParam=[[[[NSString alloc]initWithFormat:@"ver=%@&platform=%@&uid=%@&imei=%@&imsi=%@&iccid=%@&opr=%@&simopr=%@&networkopr=%@&system_version=%@&chan=%@&appid=%@&profileid=%@&lan=%@&ua=%@",version,platform,uid,imei,imsi,iccid,opr,simopr,networkopr,system_version,chan,[infoDictionary objectForKey:@"appId"],profileid,lan,ua] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *requestString =[[NSString alloc]initWithFormat:@"%@?%@",urlString,commonParam];

    
//    NSString *requestString = [self getCommonParams:urlString];
    
    NSEnumerator *keys=[params keyEnumerator];
    
    for (NSString *key in keys)
    {
        NSString *value=  [params objectForKey:key];
        if (value) {
            requestString=[requestString stringByAppendingFormat:@"&%@=%@",key,value];
        }
    }
    
    NSString *feedURLString =[requestString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURLRequest *URLRequest =[NSURLRequest requestWithURL:[NSURL URLWithString:feedURLString]];
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    return [manager GET:@"http://follow.soutuw.com:8080/reader/libraryrecommended.action?ver=1.9.7&platform=IOS&uid=(null)&imei=&imsi=&iccid=&opr=(null)&simopr=(null)(null)&networkopr=(null)&system_version=9.3&chan=IOS&appid=730893469&profileid=2020&lan=zh&ua=x86_64&cat=novel&catid=&pageidx=1&numperpage=10" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    
//    return [manager POST:feedURLString parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        if ([responseObject isKindOfClass:[NSData class]]) {
//            NSLog(@"\n\nrequest end url-    -->\n%@\nJSON--->\n%@\n\n", urlString, dict);
//            if (success) {
//                success(dict);
//            }
//        } else {
//            NSLog(@"\n\nrequest fail url--->\n%@\nerror JSON--->\n%@\n\n", urlString, dict);
//            if (fail) {
//                fail(@"服务器出错");
//            }
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"\n\nrequest error url--->\n%@\nerror--->\n%@\n\n", urlString, error);
//        if (fail) {
//            fail([error localizedDescription]);
//        }
//    }];


}




@end
