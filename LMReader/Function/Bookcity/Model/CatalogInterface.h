//
//  CatalogInterface.h
//  bookcity
//
//  Created by   解西恩 on 13-1-11.
//  Copyright (c) 2013年 309Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Catalog;
@class Recommend;
@class CatalogList;

@interface CatalogInterface : NSObject <NSXMLParserDelegate>
{
    NSString *catId;
    CatalogList * catlist;
    Recommend *recommend;
    Catalog *category;
    NSMutableArray *subCatalogs;
    NSMutableString *currentParsedCharacterData;
}
@property(nonatomic,retain)NSString *catId;
@property(nonatomic,retain)CatalogList *catlist;

@property(nonatomic,retain)Recommend *recommend;

@property(nonatomic,retain)NSMutableArray *subCatalogs;
@property(nonatomic, strong)NSMutableArray *recommendBooks;//最新推荐图书
@property(nonatomic, strong)NSMutableArray *mrecommendBooks;//男频推荐
@property(nonatomic, strong)NSMutableArray *nrecommendBooks;//女频推荐
@property(nonatomic, strong)NSString* ele;
@property(nonatomic)int i;
@property(nonatomic, strong)NSMutableArray *cid;
@property(nonatomic, assign)BOOL isrec;
-(void)parse:(NSString *)xml;

@end
