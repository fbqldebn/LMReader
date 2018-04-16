//
//  ConfigDao.h
//  Banboo
//
//  Created by  on 12-8-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"



@interface SettingDao : NSObject

{
	sqlite3 *database;
}

-(NSString *)dataFilePath;

-(void)saveComment:(NSString *)name value:(NSString *)value;

-(NSString *)getComment:(NSString *)name ;

-(void)saveOrUpdate:(NSString *)name value:(NSString *)value;

-(NSString *)getValueByName:(NSString *)name ;
@end
