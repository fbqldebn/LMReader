//
//  Equipment.m
//  bookcity
//
//  Created by Mac on 14-4-10.
//  Copyright (c) 2014年 309Studio. All rights reserved.
//

#import "Equipment.h"
#import <sys/sysctl.h>
@implementation Equipment
/*
 
 *    the model
 
 @"i386"      on the simulator
 @"iPod1,1"  on iPod Touch
 @"iPod2,1"  on iPod Touch Second Generation
 @"iPod3,1"  on iPod Touch Third Generation
 @"iPod4,1"  on iPod Touch Fourth Generation
 @"iPhone1,1" on iPhone
 @"iPhone1,2" on iPhone 3G
 @"iPhone2,1" on iPhone 3GS
 @"iPad1,1"  on iPad
 @"iPad2,1"  on iPad 2
 @"iPad3,1"  on iPad 3 (aka new iPad)
 @"iPhone3,1" on iPhone 4
 @"iPhone4,1" on iPhone 4S
 @"iPhone5,1" on iPhone 5
 @"iPhone5,2" on iPhone 5
 
 iPhone 4 is iPhone3,1 and iPhone3,2
 iPhone 4S is iPhone4,1
 iPad 2 is iPad2,1 iPad2,2 and iPad2,3 depending on version
 iPad 3 is iPad3,1 iPad3,2 and iPad3,3 depending on version
 iPad 4 is iPad4,1 depending on version
 *    @return null
 
 */

- (NSString *)getModel
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *model = malloc(size);
    sysctlbyname("hw.machine", model, &size, NULL, 0);
    NSString *sDeviceModel = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
    free(model);
    if ([sDeviceModel isEqual:@"i386"])      return@"Simulator";  //iPhone Simulator
    if ([sDeviceModel isEqual:@"iPhone1,1"]) return@"iPhone1G";   //iPhone 1G
    if ([sDeviceModel isEqual:@"iPhone1,2"]) return@"iPhone3G";   //iPhone 3G
    if ([sDeviceModel isEqual:@"iPhone2,1"]) return@"iPhone3GS";  //iPhone 3GS
    if ([sDeviceModel isEqual:@"iPhone3,1"]) return@"iPhone4 AT&T";  //iPhone 4 - AT&T
    if ([sDeviceModel isEqual:@"iPhone3,2"]) return@"iPhone4 Other";  //iPhone 4 - Other carrier
    if ([sDeviceModel isEqual:@"iPhone3,3"]) return@"iPhone4";    //iPhone 4 - Other carrier
    if ([sDeviceModel isEqual:@"iPhone4,1"]) return@"iPhone4S";   //iPhone 4S
    if ([sDeviceModel isEqual:@"iPhone5,1"]) return@"iPhone5";    //iPhone 5 (GSM)
    if ([sDeviceModel isEqual:@"iPhone6,1"]) return@"iPhone5S";
    if ([sDeviceModel isEqual:@"iPod1,1"])  return@"iPod1stGen"; //iPod Touch 1G
    if ([sDeviceModel isEqual:@"iPod2,1"])  return@"iPod2ndGen"; //iPod Touch 2G
    if ([sDeviceModel isEqual:@"iPod3,1"])  return@"iPod3rdGen"; //iPod Touch 3G
    if ([sDeviceModel isEqual:@"iPod4,1"])  return@"iPod4thGen"; //iPod Touch 4G
    if ([sDeviceModel isEqual:@"iPad1,1"])  return@"iPadWiFi";   //iPad Wifi
    if ([sDeviceModel isEqual:@"iPad1,2"])  return@"iPad3G";     //iPad 3G
    if ([sDeviceModel isEqual:@"iPad2,1"])  return@"iPad2";      //iPad 2 (WiFi)
    if ([sDeviceModel isEqual:@"iPad2,2"])  return@"iPad2";      //iPad 2 (GSM)
    if ([sDeviceModel isEqual:@"iPad2,3"])  return@"iPad2";      //iPad 2 (CDMA)
    if ([sDeviceModel isEqual:@"iPad3,1"])  return@"iPad3";      //iPad 3 (WiFi)
    if ([sDeviceModel isEqual:@"iPad3,2"])  return@"iPad3";      //iPad 3 (GSM)
    if ([sDeviceModel isEqual:@"iPad3,3"])  return@"iPad3";      //iPad 3 (CDMA)
    if ([sDeviceModel isEqual:@"iPad3,4"])  return@"iPad4";      //iPad 4 (WiFi)
    NSString *aux = [[sDeviceModel componentsSeparatedByString:@","] objectAtIndex:0];
    if ([aux rangeOfString:@"iPhone"].location!=NSNotFound) {                            int version = [[aux stringByReplacingOccurrencesOfString:@"iPhone"withString:@""] intValue];
        if (version == 3)
        {
            return@"iPhone4";
        } else if (version >= 4 && version < 5)
        {
            return@"iPhone4s";
        } else if (version >= 5)
        {
            return@"iPhone5";
        }
    }
    if ([aux rangeOfString:@"iPod"].location!=NSNotFound)
    {
        int version = [[aux stringByReplacingOccurrencesOfString:@"iPod"withString:@""] intValue];
        if (version >=4 && version < 5)
        {
            return@"iPod4thGen";
        }
        else if (version >= 5)
        {
            return@"iPod5thGen";
        }
    }
    if ([aux rangeOfString:@"iPad"].location!=NSNotFound)
    {
        int version = [[aux stringByReplacingOccurrencesOfString:@"iPad"withString:@""] intValue];
        if (version == 1)
        {
            return@"iPad3G";
        }
        else if (version >= 2 && version < 3)
        {
            return@"iPad2";
        } else if (version >= 3 && version < 4)
        {
            return@"new iPad";
        } else if (version >= 4)
        {
            return@"iPad 4";
        }
    }
    return sDeviceModel;
}
@end
