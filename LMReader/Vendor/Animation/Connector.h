//
//  Connector.h
//  ChaseBook
//
//  Created by Mac on 14-4-28.
//  Copyright (c) 2014年 iLemi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "ConfigDao.h"
//typedef enum {TYPE_COVER} Action;
@interface Connector : NSObject
-(NSString *)getUrl:(NSInteger)idI url:(NSString *)uStr;
@end
