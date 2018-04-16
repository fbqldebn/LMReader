//
//  LMReadingVC.h
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMViewController.h"
#import "PageModelControll.h"
#import "BookEntity.h"
#import "SettingDao.h"
#import "LMBookViewController.h"

@interface LMReadingVC : LMViewController<UIPageViewControllerDelegate>

{
    UISlider *chapterSlider;
    UIView *toolBarView;
    UIView *switchChapterView;
    UILabel *displayPageIndexLB;
    UISlider *pageSlider;
    
    UIView *fontSizeView;
    UIView *lightnessView;
    BOOL isFontSize; //判断是否点击了改变字体大小的按钮
    BOOL islight;  //判断是否点击了改变背景的按钮
    
    UIButton *button5;
    UIButton *button4;
    CGFloat lightLevel;
    
    UIButton *buttonSkin_4;
    UIButton *buttonSkin_3;
    UIButton *buttonSkin_2;
    UIButton *buttonSkin_1;

    int fontSizeNumber;
    int bgColorIndex;

}

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (readonly, strong, nonatomic) PageModelControll *modelController;

@property (strong, nonatomic) BookEntity *currentBook;
- (void)_chagePageViewControllerStyle:(UIPageViewControllerTransitionStyle)type;
@end
