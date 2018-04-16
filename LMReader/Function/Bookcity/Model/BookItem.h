//
//  BookItem.h
//  bookcity
//
//  Created by   解西恩 on 13-1-11.
//  Copyright (c) 2013年 309Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookItem : NSObject
{
    NSString * itemId;//item id
    NSString * type;//显示类型:piclist,booklist
    NSString * name;//书名
    NSString * author;//作者
    NSString * desc;//描述
    UIImage *img;
}

@property(nonatomic,retain) NSString * itemId;
@property(nonatomic,retain) NSString * type;
@property(nonatomic,retain) id  name;
@property(nonatomic,retain) NSString * author;
@property(nonatomic,retain) NSString * desc;
@property(nonatomic,retain) UIImage *img;
@property(nonatomic,retain) NSString *readerCount;
@end
