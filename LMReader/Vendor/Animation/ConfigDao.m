//
//  ConfigDao.m
//  Banboo
//
//  Created by  on 12-8-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ConfigDao.h"
#define kFileName @"bookcity.sqlite3"

@implementation ConfigDao

-(NSString *)dataFilePath
{
	NSArray * path=NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
	NSString * documentsDirectory=[path objectAtIndex:0];
	
	return [documentsDirectory stringByAppendingPathComponent:kFileName];
}

-(void)saveOrUpdate:(NSString *)name value:(NSString *)value
{
	if (sqlite3_open([[self dataFilePath] UTF8String], &database)!=SQLITE_OK)
	{
		sqlite3_close(database);
		NSAssert(0,@"failed to open database");
	}
    
    char *errorMsg;
	NSString * createSql=@"CREATE TABLE IF NOT EXISTS CONFIG(NAME TEXT PRIMARY KEY ,VALUE TEXT );";
	if (sqlite3_exec(database,[createSql UTF8String],NULL,NULL,&errorMsg)!=SQLITE_OK)
	{
		sqlite3_close(database);
        //NSAssert(0, errorMsg);
//		NSLog(@"fail creating table %s",errorMsg);
	}
    
   // sqlite3_stmt *statement;
    NSString *sql=[[NSString alloc] initWithFormat:@"INSERT OR REPLACE INTO CONFIG (NAME,VALUE)VALUES('%@','%@')",name,value];
    
    if (sqlite3_exec(database,[sql UTF8String], NULL, NULL, &errorMsg)!=SQLITE_OK)
	{
//		NSLog(@"fail insert into bookmark:%s",errorMsg);
		sqlite3_free(errorMsg);
	}
	
	sqlite3_close(database);    
    
	
}


-(NSString *)getValueByName:(NSString *)name ;
{
    
	if (sqlite3_open([[self dataFilePath] UTF8String], &database)!=SQLITE_OK)
	{
		sqlite3_close(database);
		NSAssert(0,@"failed to open database");
	}
    
    
	char *errorMsg;
	NSString * createSql=@"CREATE TABLE IF NOT EXISTS CONFIG(NAME PRIMARY KEY,VALUE TEXT);";
	if (sqlite3_exec(database,[createSql UTF8String],NULL,NULL,&errorMsg)!=SQLITE_OK)
	{
		sqlite3_close(database);
		//NSAssert(0,errorMsg);
//		NSLog(@"fail creating table %s",errorMsg);
	}
	
	
    NSString *selectSql=[[NSString alloc] initWithFormat:@"SELECT * FROM CONFIG WHERE NAME='%@'",name];
	sqlite3_stmt *statement;
    
    NSString *value=nil;
	
	if(sqlite3_prepare_v2(database,[selectSql UTF8String],-1, &statement, 0)==SQLITE_OK)
	{
		if (sqlite3_step(statement)==SQLITE_ROW)
		{
            
            char* cValue     = (char*)sqlite3_column_text(statement, 1);
            value=[NSString stringWithUTF8String:cValue];
            
		}
	}
	sqlite3_finalize(statement);
    
	sqlite3_close(database);
	
	return value;
    
    
   }

@end
