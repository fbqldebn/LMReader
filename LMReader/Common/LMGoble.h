//
//  LMGoble.h
//  LMReader
//
//  Created by 于君 on 16/6/1.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMGoble : NSObject

+ (instancetype)sharedGoble;

@property (assign ,nonatomic)UIPageViewControllerTransitionStyle pageTransition;
@end
