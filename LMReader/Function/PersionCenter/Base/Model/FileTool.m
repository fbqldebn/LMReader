//
//  FileTool.m
//  StockEmotion
//
//  Created by dida on 15/11/28.
//  Copyright © 2015年 StockEmotion. All rights reserved.
//

#import "FileTool.h"

@implementation FileTool  
+(void)saveDataToUserDomainMaskWithFileName:(NSString *)fileName andArray:(NSArray *)dataArray
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *newPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    [dataArray writeToFile:newPath atomically:YES];
    NSLog(@"nnn %@",newPath);
}
+(void)saveDataToUserDomainMaskWithFileName:(NSString *)fileName andDic:(NSDictionary *)dataDic
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *newPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",fileName]];
    [dataDic writeToFile:newPath atomically:YES];
    NSLog(@"nnn %@",newPath);
}

+(NSDictionary *)getDataDicFromUserDomainMask:(NSString *)path
{
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
    return dic;
}

+(NSArray *)getDataArrayFromUserDomainMask:(NSString *)path
{
    NSArray *arr = [[NSArray alloc]initWithContentsOfFile:path];
    return arr;
}

+(void)deleteHistoryDataFromUserDomainMask:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:path error:nil];
    
}

+(void)saveDataFromUserDefault:(id)data withKey:(NSString *)key
{
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    if (def) {
        [def setObject:data forKey:key];
    }
}

+(id)getDataFromUserDefaultWithKey:(NSString *)key
{
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    if (def) {
        return [def objectForKey:key];
    }
    else
        return nil;
}
@end
