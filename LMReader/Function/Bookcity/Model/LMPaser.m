//
//  LMPaser.m
//  LMReader
//
//  Created by 许爱爱 on 16/6/24.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMPaser.h"

@implementation LMPaser

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.recommMutableArr = [NSMutableArray array];
    }
    return self;
}

-(NSMutableArray *)paserRecommend:(GDataXMLElement *)element
{
    NSArray *allChild = [element children];
    NSLog(@"allChild  ====   %@",allChild);
    for (int i = 0; i < allChild.count; i++) {
        GDataXMLElement *ele = [allChild objectAtIndex:i];
        // 根据标签名判断
        if ([[ele name] isEqualToString:@"catlist"]) {
            NSArray *firstChild = [ele children];
            for (int j = 0 ; j < firstChild.count; j++) {
                GDataXMLElement *tem = [firstChild objectAtIndex:j];
                if ([[tem name] isEqualToString:@"item"]) {
                    // 读标签里面的属性
                    NSLog(@"///////////////////////////////////////////////////");
                    NSLog(@"name --> %@", [[tem attributeForName:@"name"] stringValue]);
                    NSLog(@"id --> %@", [[tem attributeForName:@"id"] stringValue]);
                    NSLog(@"focus --> %@", [[tem attributeForName:@"focus"] stringValue]);
                    NSLog(@"////////////////////////////////////////////////");
                }
            }
        } else if ([[ele name] isEqualToString:@"cat"]) {
            // 直接读标签间的String
            NSArray *firstChild = [ele children];
            for (int j = 0 ; j < firstChild.count; j++) {
                GDataXMLElement *tem = [firstChild objectAtIndex:j];
                if ([[tem name] isEqualToString:@"recommended"]) {
                    NSLog(@"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                    Recommend *comm = [[Recommend alloc]init];
                    comm.bookName =[[tem attributeForName:@"name"] stringValue];
                    comm.bookID = [[tem attributeForName:@"id"] stringValue];
                    comm.author =[[tem attributeForName:@"author"] stringValue];
                    comm.coverUpdata =[[tem attributeForName:@"cover_update"] stringValue];
                    comm.introduction =[tem stringValue];
//                    NSLog(@" recommended.name --> %@", [[tem attributeForName:@"name"] stringValue]);
//                    NSLog(@"recommended.id --> %@", [[tem attributeForName:@"id"] stringValue]);
//                    NSLog(@"recommended.author --> %@", [[tem attributeForName:@"author"] stringValue]);
//                    NSLog(@"recommended.cover_update --> %@", [[tem attributeForName:@"cover_update"] stringValue]);
//                    //读取节点内容
//                    NSLog(@"recommended.内容 --> %@", [tem stringValue]);
                    [self.recommMutableArr addObject:comm];
//                    NSLog(@"self.recommMutableArr   %d",self.recommMutableArr.count);
//                    NSLog(@"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                }
            }
        }
        
        
    }

    
    return self.recommMutableArr;
}

@end
