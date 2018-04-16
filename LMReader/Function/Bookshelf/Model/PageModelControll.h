//
//  PageModelControll.h
//  LMReader
//
//  Created by 于君 on 16/5/26.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoTextViewController.h"

@interface PageModelControll : NSObject<UIPageViewControllerDataSource>

{
    DemoTextViewController *textview;
}

@property (readonly, strong, nonatomic) NSArray *pageData;
@property (strong, nonatomic) NSMutableDictionary *pageFrameset;
@property (assign, nonatomic) NSInteger pageIndex;//scroll翻页时用到
@property (assign, nonatomic) NSInteger chapterIndex;
- (DemoTextViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DemoTextViewController *)viewController;
- (void)setLastChapterToCurrent;

-(void)changeChapterWithNumber:(NSInteger)chapter;

-(void)pageChangeTextFontWithNumber:(CGFloat)number;
-(void)pageChangeTextColorWithNumber:(CGFloat)number;

@end
