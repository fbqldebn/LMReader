//
//  DirectoryItem.h
//  309Reader
//
//  Created by   解西恩 on 12-10-14.
//  Copyright (c) 2012年 309Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DirectoryItem : NSObject
{
    NSString *itemId;
    NSString *caption;
    NSString *title;
}

@property(nonatomic,retain)NSString *itemId;
@property(nonatomic,retain)NSString *caption;
@property(nonatomic,retain)NSString *title;

@end
