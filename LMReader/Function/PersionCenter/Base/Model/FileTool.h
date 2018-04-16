//
//  FileTool.h
//  StockEmotion
//
//  Created by dida on 15/11/28.
//  Copyright © 2015年 StockEmotion. All rights reserved.
//

#import <Foundation/Foundation.h>
#define HistoryPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:@"history.plist"]
#define StockListPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:@"stockList.plist"]
#define BannerPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:@"banner.plist"]
#define LastChongZhiPhone @"lastchongzhiphone"
@interface FileTool : NSObject
+(void)saveDataToUserDomainMaskWithFileName:(NSString *)fileName andArray:(NSArray *)dataArray;
+(void)saveDataToUserDomainMaskWithFileName:(NSString *)fileName andDic:(NSDictionary *)dataDic;
+(void)saveDataFromUserDefault:(id)data withKey:(NSString *)key;


+(NSArray *)getDataArrayFromUserDomainMask:(NSString *)path;
+(NSDictionary *)getDataDicFromUserDomainMask:(NSString *)path;
+(void)deleteHistoryDataFromUserDomainMask:(NSString *)path;
+(id)getDataFromUserDefaultWithKey:(NSString *)key;
@end
