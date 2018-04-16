//
//  Recommend.h
//  bookcity
//
//  Created by   解西恩 on 13-1-13.
//  Copyright (c) 2013年 309Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recommend : NSObject<NSXMLParserDelegate>
{
    id<NSXMLParserDelegate> parentNode;
    NSMutableArray *bookItemList;
}

@property(nonatomic,retain)id<NSXMLParserDelegate> parentNode;
@property(nonatomic,retain) NSMutableArray *bookItemList;
@property (nonatomic,copy)NSString *bookName;
@property (nonatomic,copy)NSString *bookID;
@property (nonatomic,copy)NSString *coverUpdata;
@property (nonatomic,copy)NSString *introduction;
@property (nonatomic,copy)NSString *author;
@end
