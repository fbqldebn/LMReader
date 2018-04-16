//
//  CataList.m
//  bookcity
//
//  Created by   解西恩 on 13-1-13.
//  Copyright (c) 2013年 309Studio. All rights reserved.
//  栏目列表
//

#import "CatalogList.h"
#import "Catalog.h"


static NSMutableArray *catalist;

@implementation CatalogList

@synthesize parentNode;

+ (CatalogList *)shareCatalogList
{
    static CatalogList * _catalogLitsInstance = nil;
    static dispatch_once_t dispatch;
    dispatch_once(&dispatch,^{
        _catalogLitsInstance= [[CatalogList alloc]init];
        
    });
    return _catalogLitsInstance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _recommendList = [[NSMutableArray alloc]init];
        catalist=[[NSMutableArray alloc]init];
    }
    return self;
}
- (NSArray *)catalogs
{
    return catalist;
}
-(void)removeAllObjects
{
    [catalist removeAllObjects];
}
//+(id)allocWithZone:(NSZone *)zone
//{
//    return [self shareCatalogList];
//}

//+(id)copyWithZone:(NSZone *)zone
//{
//    return self;
//}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"item"])
    {
        Catalog *catalog=[[Catalog alloc]init];
        catalog.cid=[attributeDict objectForKey:@"id"];
        catalog.name=[attributeDict objectForKey:@"name"];
        catalog.focus =[attributeDict objectForKey:@"focus"];
        if (self.isRec) {
            [self.recommendList addObject:catalog];
        }else
            [catalist addObject:catalog];
//        [catalog release];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"catlist"])
    {
        [parser setDelegate:parentNode];
        
    }
}



@end
