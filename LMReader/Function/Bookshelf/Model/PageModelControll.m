//
//  PageModelControll.m
//  LMReader
//
//  Created by 于君 on 16/5/26.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "PageModelControll.h"
#import "DTAttStringManage.h"

static NSString * const currentPageKey = @"currentPageKey";
static NSString * const lastPageKey = @"lastPageKey";
static NSString * const nextPageKey = @"nextPageKey";

@implementation PageModelControll

- (instancetype)init {
    self = [super init];
    if (self) {
        // Create the data model.
        //        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //        _pageData = [[dateFormatter monthSymbols] copy];
        _pageFrameset = [NSMutableDictionary dictionary];
        _chapterIndex = 0;
        _pageData = [[DTAttStringManage sharedManage] framesetterOfChapter:[[DTAttStringManage sharedManage] indexOfChapter]];
//          NSLog(@"_pageData  !!!====   %@",_pageData);
        NSLog(@"*********************************************************");
        NSLog(@"_pageData  ====   %@",_pageData);
        NSLog(@"*********************************************************");

        [_pageFrameset setObject:_pageData forKey:currentPageKey];
    }
    return self;
}

- (DemoTextViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard {
    // Return th    e data view controller for the given index.
    _pageData = _pageFrameset[currentPageKey];
    
    if (([self.pageData count] == 0) || (index >=  [self.pageData count])) {
        return nil;
    }
     textview = [[DemoTextViewController alloc]init];
    textview.frameset  = self.pageData[index];
//    NSLog(@"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
//    NSLog(@"index  ===    %d",index);
//    NSLog(@"%@",self.pageData[index]);
//    NSLog(@"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
    textview.chapterText = [[NSAttributedString alloc]initWithString:[[DTAttStringManage sharedManage] chapterNameOfIndex:_chapterIndex] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    textview.pageText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%u/%ld",index+1,(unsigned long)_pageData.count] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    return textview;
}

- (NSUInteger)indexOfViewController:(DemoTextViewController *)viewController {
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    
    _pageData = _pageFrameset[currentPageKey];
    return [self.pageData indexOfObject:viewController.frameset];
}
- (void)setLastChapterToCurrent;
{
    if (_chapterIndex>0) {
        _chapterIndex--;
        NSArray *lastArr = _pageFrameset[lastPageKey];
        if (!lastArr) {
            lastArr =[[DTAttStringManage sharedManage] framesetterOfChapter:_chapterIndex];
        }
        if (_pageFrameset[currentPageKey]) {
            [_pageFrameset setObject:_pageFrameset[currentPageKey] forKey:nextPageKey];
            
        }
        if (lastArr) {
            [_pageFrameset setObject:lastArr forKey:currentPageKey];
            _pageData = _pageFrameset[currentPageKey];
        }
        
        [_pageFrameset removeObjectForKey:lastPageKey];
    }
}
#pragma mark - Page View Controller Data Source
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return self.pageData.count;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfViewController:(DemoTextViewController *)viewController];
//    NSLog(@"index  =====     %d",index);
    if (index!= NSNotFound) {
        _pageIndex = index;
    }
    if ((index <= 0) || (index == NSNotFound)) {
        if (_chapterIndex>0) {
            _chapterIndex--;
//            NSLog(@"_chapterIndex  ====      %d",_chapterIndex);
            NSArray *lastArr = _pageFrameset[lastPageKey];
            if (!lastArr) {
                lastArr =[[DTAttStringManage sharedManage] framesetterOfChapter:_chapterIndex];
            }
            
            if (_pageFrameset[currentPageKey]) {
                [_pageFrameset setObject:_pageFrameset[currentPageKey] forKey:nextPageKey];
            }
            if (lastArr) {
                [_pageFrameset setObject:lastArr forKey:currentPageKey];
            }
            
            [_pageFrameset removeObjectForKey:lastPageKey];
            index = lastArr.count-1;
            DemoTextViewController *textview = [[DemoTextViewController alloc]init];
            textview.frameset = lastArr[index];
            textview.chapterText = [[NSAttributedString alloc]initWithString:[[DTAttStringManage sharedManage] chapterNameOfIndex:_chapterIndex] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
            textview.pageText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%d/%ld",index+1,(unsigned long)lastArr.count] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
            return textview;
        }
        return nil;
    }
   
    index--;
    
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfViewController:(DemoTextViewController *)viewController];
    NSLog(@"index  =====     %d",index);
    if (index!= NSNotFound) {
        _pageIndex = index;
    }
    
    index++;

    if (index == NSNotFound||index >= [self.pageData count]) {
        if (_chapterIndex+1>[[DTAttStringManage sharedManage] lChapters].count) {
            return nil;
        }
        _chapterIndex++;
        NSLog(@"_chapterIndex  ====      %d",_chapterIndex);
        NSArray *lNext = _pageFrameset[nextPageKey];
        if (!lNext) {
            lNext =[[DTAttStringManage sharedManage] framesetterOfChapter:_chapterIndex];
            
        }
        
        if (_pageFrameset[currentPageKey]) {
            [_pageFrameset setObject:_pageFrameset[currentPageKey] forKey:lastPageKey];
        }
        if (lNext) {
            [_pageFrameset setObject:lNext forKey:currentPageKey];
        }

        [_pageFrameset removeObjectForKey:nextPageKey];
        index = 0;
        DemoTextViewController *textview = [[DemoTextViewController alloc]init];
        textview.frameset = lNext[index];
        textview.chapterText = [[NSAttributedString alloc]initWithString:[[DTAttStringManage sharedManage] chapterNameOfIndex:_chapterIndex] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
        textview.pageText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%d/%ld",index+1,(unsigned long)lNext.count] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
        return textview;
    }
    
//    if (index >= [self.pageData count]) {
//        _pageData = [[DTAttStringManage sharedManage] framesetterOfChapter:[[DTAttStringManage sharedManage] indexOfChapter]+1];
//        index = 0;
//        return [self viewControllerAtIndex:index storyboard:viewController.storyboard];;
//    }
  
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}
-(void)pageChangeTextFontWithNumber:(CGFloat)number
{
    if (number == 1) {
        _pageData = [[DTAttStringManage sharedManage]changeTextFontSmall:YES];
    }else
    {
         _pageData = [[DTAttStringManage sharedManage]changeTextFontSmall:NO];
    }
    [_pageFrameset setObject:_pageData forKey:currentPageKey];
    textview.frameset  = self.pageData[0];
    
}
-(void)pageChangeTextColorWithNumber:(CGFloat)number
{
    [[DTAttStringManage sharedManage]changeTextColorWithNumber:number];
    
}

-(void)changeChapterWithNumber:(NSInteger)chapter
{
    _chapterIndex++;
//    NSLog(@"_chapterIndex  ==   %d",_chapterIndex);
//    NSArray *lastArr = _pageFrameset[lastPageKey];
//    if (!lastArr) {
//        lastArr =[[DTAttStringManage sharedManage] framesetterOfChapter:chapter];
//    }
//    if (_pageFrameset[currentPageKey]) {
//        [_pageFrameset setObject:_pageFrameset[currentPageKey] forKey:nextPageKey];
//        
//    }
//    if (lastArr) {
//        [_pageFrameset setObject:lastArr forKey:currentPageKey];
//        _pageData = _pageFrameset[currentPageKey];
//    }
//    
//    [_pageFrameset removeObjectForKey:lastPageKey];
}

@end
