//
//  DatebaseManage.h
//  LMReader
//
//  Created by 于君 on 16/5/26.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

@interface DatebaseManage : NSObject

@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

+ (instancetype)sharedDatebase;

- (NSArray *)fetchBooks;
@end
