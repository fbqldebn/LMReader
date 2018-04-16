//
//  CataList.h
//  bookcity
//
//  Created by   解西恩 on 13-1-13.
//  Copyright (c) 2013年 309Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatalogList : NSObject <NSXMLParserDelegate>
{
    id <NSXMLParserDelegate> parentNode;
    
}

@property(nonatomic,retain)id <NSXMLParserDelegate> parentNode;
@property(nonatomic, strong)NSMutableArray *recommendList;
@property(nonatomic, assign)BOOL *isRec;
+ (CatalogList *)shareCatalogList;
- (NSArray *)catalogs;
-(void)removeAllObjects;

@end
