//
//  HTTPRequest.h
//  worde
//
//  Created by dida on 15/11/11.
//  Copyright © 2015年 wordemotion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigDao.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <AFNetworking.h>
#import "Equipment.h"
#import "GDataXMLNode.h"


//#import "APIDefine.h"

@interface HTTPRequest : NSObject<NSXMLParserDelegate>

typedef void (^HttpRequestDocumentSuccessBlock)(GDataXMLDocument *responseDict);
typedef void (^HttpRequestSuccessBlock)(GDataXMLElement *responseDict);
typedef void (^HttpRequestFailureBlock)(NSString *errorMsg);

//GET
+ (NSURLSessionDataTask *)getRequestWithUrl:(NSString*)urlString params:(NSDictionary *)params success:(HttpRequestSuccessBlock)success fail:(HttpRequestFailureBlock)fail;

+ (NSURLSessionDataTask *)getRequestDocumentWithUrl:(NSString*)urlString params:(NSDictionary *)params success:(HttpRequestDocumentSuccessBlock)success fail:(HttpRequestFailureBlock)fail;
//POST
+ (NSURLSessionDataTask *)postRequestWithUrl:(NSString*)urlString params:(NSMutableDictionary *)params success:(HttpRequestSuccessBlock)success fail:(HttpRequestFailureBlock)fail;


//-(NSString *)getCommonParams:(NSString *)baseUrl;

@end
