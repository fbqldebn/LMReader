//
//  BookEntity.h
//  LMReader
//
//  Created by 于君 on 16/5/26.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DModel.h"
#import <GDataXML-HTML/GDataXMLNode.h>

@interface BookEntity : DModel
//CREATE TABLE Book ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL, 'b_id' TEXT,'u_id' TEXT references User(u_id),'b_category_name' TEXT ,'b_name' TEXT,'b_summary' TEXT, 'b_author' TEXT, 'b_source' TEXT, 'b_pubtime' TEXT)"
@property (strong, nonatomic)NSString *u_id;

@property (strong, nonatomic)NSString *b_id;
@property (strong, nonatomic)NSString *b_category_name;

@property (strong, nonatomic)NSString *b_name;
@property (strong, nonatomic)NSString *b_summary;
@property (strong, nonatomic)NSString *b_author;
@property (strong, nonatomic)NSString *b_source;
@property (strong, nonatomic)NSString *b_pubtime;

- (void)bookWithElement:(GDataXMLElement*)element;
+ (void)generateSQLForInsertingArticle:(BookEntity *)article completion:(void (^) (NSString *sql, NSArray *arguments))completion;
+ (void)generateSQLForUpdateArticle:(BookEntity *)article completion:(void (^) (NSString *sql, NSArray *arguments))completion;
@end
