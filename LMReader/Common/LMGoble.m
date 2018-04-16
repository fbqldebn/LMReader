//
//  LMGoble.m
//  LMReader
//
//  Created by 于君 on 16/6/1.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMGoble.h"
static LMGoble *instance = nil;
@implementation LMGoble
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pageTransition = UIPageViewControllerTransitionStylePageCurl;
    }
    return self;
}
+ (instancetype)sharedGoble;
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
@end
