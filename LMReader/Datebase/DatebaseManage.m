//
//  DatebaseManage.m
//  LMReader
//
//  Created by 于君 on 16/5/26.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "DatebaseManage.h"
#import <GDataXML-HTML/GDataXMLNode.h>
#import "BookEntity.h"
#import "FMResultSet+Additions.h"


@implementation DatebaseManage

+ (instancetype)sharedDatebase
{
    static DatebaseManage *instance;
    static dispatch_once_t onceTaken;
    dispatch_once(&onceTaken, ^{
        instance = [[DatebaseManage alloc]init];
        [instance _prepareDatabase];
        [instance _margeBooksOfBuildin];
    });
    return instance;
}

- (void)_prepareDatabase
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *dbPath = [self _dbPath];
    if (![fm fileExistsAtPath:dbPath]) {
        FMDatabase *db =[FMDatabase databaseWithPath:dbPath];
        if ([db open]) {
            _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
            NSString *sqlUser = @"create table User ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'u_id' VARCHAR(30), 'u_password' VARCHAR(30),  'u_real_name' VARCHAR(30), 'u_mobile' VARCHAR(30), 'u_email' VARCHAR(30), 'u_nick_name' VARCHAR(30), 'u_avatar' TEXT,'u_gender' INTEGER, 'u_integral' INTEGER, 'u_age' INTEGER,  'u_address' TEXT, 'u_cookies' BLOB, 'u_grade' TEXT,'u_lastuse_date' TEXT)";
            
            //文章
            NSString *sqlBook = @"CREATE TABLE Book ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL, 'b_id' TEXT,'u_id' TEXT references User(u_id),'b_category_name' TEXT ,'b_name' TEXT,'b_summary' TEXT, 'b_author' TEXT, 'b_source' TEXT, 'b_pubtime' TEXT)";
            //设置列表
            NSString *sqlSetting = @"CREATE TABLE Setting ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,'s_uid' TEXT REFERENCES 'User' (u_id) ON DELETE CASCADE ON UPDATE NO ACTION, 's_font_size' INTEGER, 's_theme' INTEGER, 's_show_pic' NSIEGER, 's_push_open' INTEGER, 's_offline_date' TEXT)";
            
            [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
                BOOL res = [db executeUpdate:sqlUser];
                if (!res) {
                    *rollback = YES;//执行完这条语句主动回滚
                    DLog(@"create table user failed");
                }
                BOOL res1 = [db executeUpdate:sqlBook];
                if (!res1) {
                    *rollback = YES;//执行完这条语句主动回滚
                    DLog(@"create table book failed");
                }
                BOOL res2 = [db executeUpdate:sqlSetting];
                if (!res2) {
                    *rollback = YES;//执行完这条语句主动回滚
                    DLog(@"create table Setting failed");
                }
                
            }];
        }else
        {
            DLog(@"open db failed!");
        }
    }
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
}
- (NSString *)_dbPath
{
    static NSString *dbPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *docPath = DOCUMENT_PATH;
        dbPath = [docPath stringByAppendingPathComponent:@"LMReading.db"];
    });
    return dbPath;
}
- (void)_margeBooksOfBuildin;
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"bookIndexs" ofType:@"xml"];
    NSMutableArray *container = [NSMutableArray array];
    NSData *bookdata = [NSData dataWithContentsOfFile:path];
    GDataXMLDocument *xml = [[GDataXMLDocument alloc]initWithData:bookdata error:nil];
    if (xml) {
        NSArray* nodes = [xml nodesForXPath:@"//book" error:nil];
        for (GDataXMLElement *element in nodes)
        {
            BookEntity *entity = [[BookEntity alloc]init];
            [entity bookWithElement:element];
            [container addObject:entity];
        }
        [self storeBooks:container];
    }
}
- (void)storeBooks:(NSArray *)books
{
    if (books.count) {
        [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            for (BookEntity *entity in books)
            {
                int count = [db intForQuery:[NSString stringWithFormat:@"SELECT COUNT(b_id) FROM Book WHERE b_id = '%@'",entity.b_id]];
                if (!count) {
                    [BookEntity generateSQLForInsertingArticle:entity completion:^(NSString *sql, NSArray *arguments) {
                        BOOL result = [db executeUpdate:sql withArgumentsInArray:arguments];
                        if (!result) {
                            DLog(@"insert table book failed!");
                        }
                    }];
                }
            }
            
        }];
    }
}
- (NSArray *)fetchBooks;
{
    NSMutableArray *result = [NSMutableArray array];
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *sets = [db executeQuery:[NSString stringWithFormat:@"select * from Book"]];
        while ([sets next]) {
            BookEntity *entity = [[BookEntity alloc]init];
            [sets fmResultReflectModel:entity];
            [result addObject:entity];
        }
        [sets close];
    }];
    return result;
}
@end
