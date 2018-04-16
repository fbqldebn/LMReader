//
//  Catalog.m
//  bookcity
//
//  Created by   解西恩 on 13-1-11.
//  Copyright (c) 2013年 309Studio. All rights reserved.
//

#import "Catalog.h"
#import "BookItem.h"

@implementation Catalog

@synthesize cid;
@synthesize name;
@synthesize focus;
@synthesize bookItems;

@synthesize parentNode;

-(id)init
{
    self=[super init];
    
    if (self)
    {
        bookItems=[[NSMutableArray alloc]init];
    }
    
    return self;
}
-(void)dealloc
{

}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"subcat"])
    {
        self.cid=[attributeDict objectForKey:@"id"];
        self.name=[attributeDict objectForKey:@"name"];
        self.focus = [attributeDict objectForKey:@"focuson_num"];
        self.topspot = [[attributeDict objectForKey:@"topspot"] boolValue];
        self.cover_update = [[attributeDict objectForKey:@"topspot"]boolValue];
    }
    else if([elementName isEqualToString:@"item"])
    {
        bookItem=[[BookItem alloc]init];
        bookItem.itemId=[attributeDict objectForKey:@"id"];
        bookItem.type=[attributeDict objectForKey:@"type"];
        bookItem.name=[attributeDict objectForKey:@"name"];
        bookItem.author=[attributeDict objectForKey:@"author"];
        if ([bookItem.type isEqualToString:@"piclist"])
        {
            bookItem.author=[attributeDict objectForKey:@"author"];
        }
        else
        {
            currentParsedCharacterData=[[NSMutableString alloc]init];
            
        }
        
        
    }
    
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
        if(currentParsedCharacterData)
        {
            [currentParsedCharacterData appendString:string];
        }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"item"])
    {
        //if ([bookItem.type isEqualToString:@"piclist"])
        {
            bookItem.desc=currentParsedCharacterData;
//            [currentParsedCharacterData release];
        }
        
        [bookItems addObject:bookItem];
        
    }
    
    else if([elementName isEqualToString:@"subcat"])
    {
        [parser setDelegate:parentNode];
        
    }
}

@end
