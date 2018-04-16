//
//  Catalog.h
//  bookcity
//
//  Created by   解西恩 on 13-1-11.
//  Copyright (c) 2013年 309Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BookItem;

@interface Catalog : NSObject<NSXMLParserDelegate>
{
    NSString * cid;//catalog id
    NSString * name;//名字
    NSString *focus;//是否有焦点
    NSMutableArray *bookItems;//所属书目

    id<NSXMLParserDelegate>parentNode;
    
    BookItem *bookItem;
    
    NSMutableString *currentParsedCharacterData;
}

@property (nonatomic,retain) NSString * cid;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *focus;
@property(nonatomic, strong)NSString *coverId;
@property(nonatomic, assign)BOOL topspot;
@property(nonatomic, assign)BOOL cover_update;
@property(nonatomic,retain)NSMutableArray *bookItems;
@property(assign, nonatomic)NSInteger totalItem;
@property(nonatomic,retain)id<NSXMLParserDelegate>parentNode;

@end
