//
//  BookPackIndexItem.h
//  309Reader
//
//  Created by   解西恩 on 12-10-20.
//  Copyright (c) 2012年 309Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookPackIndexItem : NSObject
{
    NSString *fileName;
    NSInteger filesize;
    NSInteger offset;
    NSInteger flag;//是否保护
}

@property(nonatomic,retain)NSString *fileName;
@property(nonatomic)NSInteger filesize;
@property(nonatomic)NSInteger offset;
@property(nonatomic)NSInteger flag;

@end
