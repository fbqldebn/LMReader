//
//  CatalogInterface.m
//  bookcity
//
//  Created by   解西恩 on 13-1-11.
//  Copyright (c) 2013年 309Studio. All rights reserved.
//

#import "CatalogInterface.h"
#import "Catalog.h"
#import "CatalogList.h"
#import "Recommend.h"

@implementation CatalogInterface

@synthesize catId;
@synthesize catlist;
@synthesize recommend;
@synthesize subCatalogs;

-(id)init
{
    self=[super init];
    if (self)
    {
        subCatalogs=[[NSMutableArray alloc]init];
    }
    return self;
}
-(void)dealloc
{
   
}

-(void)parse:(NSString *)xml
{
    NSXMLParser *parser=nil;
    
    @try
    {
        //parser =[[NSXMLParser alloc] initWithData: data];
        
        parser=[[NSXMLParser alloc]initWithData:[xml dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [parser setDelegate:self];
        [parser setShouldProcessNamespaces:NO];
        [parser setShouldReportNamespacePrefixes:NO];
        [parser setShouldResolveExternalEntities:NO];
        
        [parser parse];
        
    }
    @catch (NSException *e)
    {
//        NSLog(@"%@",e);
        //self.parseError=[NSString stringWithFormat:@"无法获取服务!name:%@ exception:%@",[e name],[e reason]];
    }
    @finally
    {
       
        
    }
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"catlist"])
    {
        if (self.isrec) {
            self.catlist=[CatalogList shareCatalogList];
            self.catlist.isRec = YES;
            NSArray *cateArr = [self.catlist recommendList];
            if (cateArr.count<3) {
                catlist.parentNode=self;
                [parser setDelegate:catlist];
            }
        }else
        {
            self.catlist=[CatalogList shareCatalogList];
             self.catlist.isRec = NO;
            NSArray *cateArr = [self.catlist catalogs];
            if (cateArr.count<3) {
                catlist.parentNode=self;
                [parser setDelegate:catlist];
            }
        }
        

    }
    else if([elementName isEqualToString:@"cat"])
    {
        self.ele = [attributeDict objectForKey:@"id"];
        self.catId=[attributeDict objectForKey:@"id"];
        if (self.catlist.isRec) {
            NSArray *cateArr = [self.catlist recommendList];
            for (Catalog *item in cateArr)
            {
                if ([item.cid isEqualToString:self.catId]) {
                    category = item;
                    item.totalItem = [[attributeDict objectForKey:@"totalitem"] integerValue];
                    break;
                }
            }

        }else
        {
            NSArray *cateArr = [self.catlist catalogs];
            for (Catalog *item in cateArr)
            {
                if ([item.cid isEqualToString:self.catId]) {
                    category = item;
                    item.totalItem = [[attributeDict objectForKey:@"totalitem"] integerValue];
                    break;
                }
            }

        }
        
    }
    else if([elementName isEqualToString: @"recommend"])
    {
        self.recommend=[[Recommend alloc]init];
        recommend.parentNode=self;
        
        [parser setDelegate:recommend];
    }
    else if([elementName isEqualToString:@"subcat"])
    {
        Catalog *subCat=[[Catalog alloc]init];
        subCat.cid=[attributeDict objectForKey:@"id"];
        subCat.name=[attributeDict objectForKey:@"name"];
        subCat.focus = [attributeDict objectForKey:@"focuson_num"];
        subCat.topspot = [[attributeDict objectForKey:@"topspot"] boolValue];
        subCat.coverId = [attributeDict objectForKey:@"coverid"];
        subCat.cover_update = [[attributeDict objectForKey:@"topspot"]boolValue];
        [self.subCatalogs addObject:subCat];
        subCat.parentNode=self;
        [parser setDelegate:subCat];
        //[subCat release];
        
    }else if([elementName isEqualToString:@"recommended"])
    {
        self.recommend = [[Recommend alloc]init];
        currentParsedCharacterData = [NSMutableString string];
        self.recommend.bookName = [attributeDict objectForKey:@"name"];
        self.recommend.bookID = [attributeDict objectForKey:@"id"];
        self.recommend.coverUpdata = [attributeDict objectForKey:@"cover_update"];
        self.recommend.author = [NSString stringWithFormat:@"作者:%@",[attributeDict objectForKey:@"author"]];
        
    } else if([elementName isEqualToString:@"nr"])
    {
        self.cid = [NSMutableArray array];
       
        self.recommendBooks = [[NSMutableArray alloc]init];
        self.mrecommendBooks = [[NSMutableArray alloc]init];
        self.nrecommendBooks = [[NSMutableArray alloc]init];
        
    }


    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"description"])
    {
        // description= currentParsedCharacterData;
        
    }else if ([elementName isEqualToString:@"recommended"]){
        
        self.recommend.introduction = [NSString stringWithFormat:@"简介:%@",currentParsedCharacterData];
        NSArray *catelist = [self.catlist recommendList];
        int index=0;
        for (Catalog *item in catelist)
        {
            index++;
            if ([item.cid isEqualToString:self.ele]) {
                break;
            }
        }
        if (index==1) {
            [self.mrecommendBooks addObject:self.recommend];
        }else if (index==2)
        {
            [self.nrecommendBooks addObject:self.recommend];
        }else if (index==3)
        {
            [self.recommendBooks addObject:self.recommend];
        }
//        for (int i =0; i<self.cid.count; i++) {
//            NSString *str = [self.cid objectAtIndex:i];
//            if ([self.ele isEqualToString:str]) {
//                [self.recommendBooks addObject:self.recommend];
//            }
//            break;
//        }
//        for (int i = 0; i<self.cid.count; i++) {
//            NSString *str = [self.cid objectAtIndex:i];
//            if ([self.ele isEqualToString:str]) {
//                [self.mrecommendBooks addObject:self.recommend];
//            }
//            break;
//        }
//        for (int i = 0; i<self.cid.count; i++) {
//            NSString *str = [self.cid objectAtIndex:i];
//            if ([self.ele isEqualToString:str]) {
//                [self.nrecommendBooks addObject:self.recommend];
//            }
//            break;
//        }
        
    }else if ([elementName isEqualToString:@"cat"])
    {
        
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(currentParsedCharacterData)
    {
        [currentParsedCharacterData appendString:string];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
//    self.description=[[NSString alloc]initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    
}

@end
