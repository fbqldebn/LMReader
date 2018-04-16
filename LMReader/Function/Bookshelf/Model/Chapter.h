//
//  Chapter.h
//  LMReader
//
//  Created by 于君 on 16/5/27.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Chapter : NSObject

@property (strong, nonatomic)NSString *chapterId;
@property (strong, nonatomic)NSString *chapterName;
@property (assign, nonatomic)NSInteger index;
@end
