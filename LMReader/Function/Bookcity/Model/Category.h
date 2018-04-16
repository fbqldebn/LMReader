//
//  Category.h
//  bookcity
//
//  Created by 乐米科技 on 3/18/15.
//  Copyright (c) 2015 309Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject

@property(strong, nonatomic)NSString *cate_id;
@property(strong, nonatomic)NSString *name;
@property(assign, nonatomic)NSInteger focuson_num;
@property(assign, nonatomic)BOOL topspot;
@end
