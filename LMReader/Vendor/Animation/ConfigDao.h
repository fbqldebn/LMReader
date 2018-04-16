//
//  ConfigDao.h
//  Banboo
//
//  Created by  on 12-8-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@class Config;

@interface ConfigDao : NSObject

{
	sqlite3 *database;
}

-(NSString *)dataFilePath;

-(void)saveOrUpdate:(NSString *)name value:(NSString *)value;

-(NSString *)getValueByName:(NSString *)name ;


@end
