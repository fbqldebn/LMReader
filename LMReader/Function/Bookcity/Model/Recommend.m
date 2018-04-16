//
//  Recommend.m
//  bookcity
//
//  Created by   解西恩 on 13-1-13.
//  Copyright (c) 2013年 309Studio. All rights reserved.
//

#import "Recommend.h"
//#import "BookItem.h"

@implementation Recommend
@synthesize parentNode;
@synthesize bookItemList;
-(void)dealloc
{
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"item"])
    {
//        BookItem *bookItem=[[BookItem alloc]init];
//        bookItem.itemId=[attributeDict objectForKey:@"id"];
//        bookItem.name=[attributeDict objectForKey:@"name"];
//        
//        [bookItemList addObject:bookItem];
        
        
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"recommend"])
    {
        [parser setDelegate:parentNode];
        
    }
}


@end
