//
//  BookEntity.m
//  LMReader
//
//  Created by 于君 on 16/5/26.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "BookEntity.h"

@implementation BookEntity

- (void)bookWithElement:(GDataXMLElement*)element;
{
    NSArray *atts = [element attributes];
    for (GDataXMLNode *node in atts)
    {
        NSLog(@"node  =   %@",node);
        if ([node.name isEqualToString:@"name"]) {
            self.b_name = [node stringValue];
        }else if ([node.name isEqualToString:@"id"])
        {
            self.b_id = [node stringValue];
        }
    }
    
}
+ (void)generateSQLForInsertingArticle:(BookEntity *)article completion:(void (^) (NSString *sql, NSArray *arguments))completion;
{
    NSMutableArray *columns = [[NSMutableArray alloc] init];
    NSMutableArray *bindingMark = [[NSMutableArray alloc] init];
    NSMutableArray *arguments = [[NSMutableArray alloc] init];
    
    [columns addObject:@"b_id"];
    [arguments addObject:article.b_id];
    [bindingMark addObject:@"?"];
    if (article.b_category_name) {
        [columns addObject:@"b_category_name"];
        [arguments addObject:article.b_category_name];
        [bindingMark addObject:@"?"];
    }

    if (article.b_name) {
        [columns addObject:@"b_name"];
        [arguments addObject:article.b_name];
        [bindingMark addObject:@"?"];
    }
    if (article.b_summary) {
        [columns addObject:@"b_summary"];
        [arguments addObject:article.b_summary];
        [bindingMark addObject:@"?"];
    }
    if (article.b_author) {
        [columns addObject:@"a_author"];
        [arguments addObject:article.b_author];
        [bindingMark addObject:@"?"];
    }
    if (article.b_source) {
        [columns addObject:@"b_source"];
        [arguments addObject:article.b_source];
        [bindingMark addObject:@"?"];
    }
    if (article.b_pubtime) {
        [columns addObject:@"b_pubtime"];
        [arguments addObject:article.b_pubtime];
        [bindingMark addObject:@"?"];
    }
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO Book (%@) VALUES (%@)", [columns componentsJoinedByString:@","], [bindingMark componentsJoinedByString:@","]];
    completion(sql, arguments);
}
+ (void)generateSQLForUpdateArticle:(BookEntity *)article completion:(void (^) (NSString *sql, NSArray *arguments))completion;
{
    NSMutableArray *columns = [[NSMutableArray alloc] init];
    
    NSMutableArray *arguments = [[NSMutableArray alloc] init];
    
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE Article SET %@ WHERE a_id = '%@'", [columns componentsJoinedByString:@","], article.b_id];
    completion(sql, arguments);
}
@end
