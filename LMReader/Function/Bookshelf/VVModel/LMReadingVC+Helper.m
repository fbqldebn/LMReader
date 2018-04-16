//
//  LMReadingVC+Helper.m
//  LMReader
//
//  Created by 于君 on 16/5/30.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMReadingVC+Helper.h"
#import <objc/runtime.h>

#define NSObject_key_TopTool @"topToolBar"
#define NSObject_key_BottomTool @"bottomToolBar"
@implementation LMReadingVC (Helper)

- (UIToolbar*)topToolBar
{
    return objc_getAssociatedObject(self, NSObject_key_TopTool);;
}

- (void)setTopToolBar:(UIToolbar *)topToolBar
{
    [self willChangeValueForKey:@"topToolBar"];
    objc_setAssociatedObject(self, NSObject_key_TopTool, topToolBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"topToolBar"];
}

- (void)setBottomToolBar:(UIToolbar *)bottomToolBar
{
    [self willChangeValueForKey:@"topToolBar"];
    objc_setAssociatedObject(self, NSObject_key_BottomTool, bottomToolBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"topToolBar"];
}

- (UIToolbar *)bottomToolBar
{
    return objc_getAssociatedObject(self, NSObject_key_BottomTool);;
}
- (void)addNavBar;
{
    if (!self.topToolBar) {
        UIToolbar *tool =[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        tool.delegate = self;
        
        UIView *backView = [[UIView alloc]initWithFrame:tool.bounds];
        backView.backgroundColor = [UIColor blackColor];
        [tool addSubview:backView];
        
        
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH/4, 20)];
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(_toolAction:) forControlEvents:UIControlEventTouchDown];
        [backView addSubview:button];

        self.topToolBar =tool;
        self.topToolBar.transform = CGAffineTransformMakeTranslation(0, -64);
        [self.view addSubview:self.topToolBar];
        [[UIApplication sharedApplication]setStatusBarHidden:YES];
    }
    
}

- (void)addBottomToolBar;
{
    if (!self.bottomToolBar) {
        UIToolbar *tool =[[UIToolbar alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49)];
        tool.backgroundColor = [UIColor blackColor];
         tool.delegate = self;
        
        UIView *backView = [[UIView alloc]initWithFrame:tool.bounds];
        backView.backgroundColor = [UIColor blackColor];
        [tool addSubview:backView];
        
       
        


        UIButton *button2=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/4, 49)];
        button2.backgroundColor = [UIColor clearColor];
        [button2 addTarget:self action:@selector(openBookViewController) forControlEvents:UIControlEventTouchDown];
        button2.imageEdgeInsets = UIEdgeInsetsMake((button2.frame.size.height-25)/2, (button2.frame.size.width-25)/2, (button2.frame.size.height-25)/2, (button2.frame.size.width-25)/2);
        
        NSString *imagePath2= [[NSBundle mainBundle]pathForResource:@"tabbtn_list@2x" ofType:@"png"];
        [button2 setImage:[UIImage imageWithContentsOfFile:imagePath2] forState:UIControlStateNormal];
        
        UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button2.frame), 0, SCREEN_WIDTH/4, 50)];
        button3.backgroundColor = [UIColor clearColor];
        [button3 addTarget:self action:@selector(saveBookmarks) forControlEvents:UIControlEventTouchDown];
        NSString *imagePath3= [[NSBundle mainBundle]pathForResource:@"addbookmart@2x" ofType:@"png"];
        [button3 setImage:[UIImage imageWithContentsOfFile:imagePath3] forState:UIControlStateNormal];
        button3.imageEdgeInsets = UIEdgeInsetsMake((button3.frame.size.height-25)/2, (button3.frame.size.width-25)/2, (button3.frame.size.height-25)/2, (button3.frame.size.width-25)/2);
        
       button4=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button3.frame), 0, SCREEN_WIDTH/4, 50)];
        button4.backgroundColor = [UIColor redColor];
        [button4 addTarget:self action:@selector(openFontSizeView) forControlEvents:UIControlEventTouchDown];
        
        NSString *imagePath4= [[NSBundle mainBundle]pathForResource:@"tabbtn_font@2x" ofType:@"png"];
        [button4 setImage:[UIImage imageWithContentsOfFile:imagePath4] forState:UIControlStateNormal];
        button4.imageEdgeInsets = UIEdgeInsetsMake((button3.frame.size.height-25)/2, (button3.frame.size.width-25)/2, (button3.frame.size.height-25)/2, (button3.frame.size.width-25)/2);
        
        button5=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button4.frame), 0, SCREEN_WIDTH/4, 50)];
        button4.backgroundColor = [UIColor clearColor];
        
        [button5 addTarget:self action:@selector(openLightnessChangeView) forControlEvents:UIControlEventTouchDown];
        
        NSString *imagePath5= [[NSBundle mainBundle]pathForResource:@"tabbtn_setup@2x" ofType:@"png"];
        [button5 setImage:[UIImage imageWithContentsOfFile:imagePath5] forState:UIControlStateNormal];
        button5.imageEdgeInsets = UIEdgeInsetsMake((button3.frame.size.height-25)/2, (button3.frame.size.width-25)/2, (button3.frame.size.height-25)/2, (button3.frame.size.width-25)/2);
        //    [button5 setImageEdgeInsets:UIEdgeInsetsMake((button5.frame.size.width - 25)/2, 0, (button5.frame.size.height - 25)/2, 0)];
        
        button2.tag = 201;
        button3.tag = 202;
        button4.tag = 203;
        button5.tag = 204;
        
        [backView addSubview:button2];
        [backView addSubview:button3];
        [backView addSubview:button4];
        [backView addSubview:button5];
        
        self.bottomToolBar =tool;
        self.bottomToolBar.transform = CGAffineTransformMakeTranslation(0, 49);
        [self.view addSubview:self.bottomToolBar];
    }
}
- (void)tapShowHideToolBar;
{
    [UIView animateWithDuration:0.3 animations:^{
        if (CGAffineTransformIsIdentity(self.topToolBar.transform)) {
            
            if (lightnessView) {
                [lightnessView removeFromSuperview];
                islight = NO;
            }
            if (fontSizeView) {
                [fontSizeView removeFromSuperview];
                isFontSize = NO;
            }
            //隐藏菜单栏
            self.topToolBar.transform = CGAffineTransformMakeTranslation(0, -64);
            self.bottomToolBar.transform = CGAffineTransformMakeTranslation(0, 49);
            self.pageViewController.view.transform =CGAffineTransformIdentity;
            [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        }else
        {
            
            //调起菜单栏
            if (self.pageViewController.transitionStyle == UIPageViewControllerTransitionStylePageCurl) {
                self.pageViewController.view.transform = CGAffineTransformMakeTranslation(0, -20);
            }else
            {
                 self.edgesForExtendedLayout = UIRectEdgeNone;
            }
            self.topToolBar.transform = CGAffineTransformIdentity;
            self.bottomToolBar.transform = CGAffineTransformIdentity ;
            [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        }
    }];
}
- (void)panHideToolBar;
{
    [UIView animateWithDuration:0.3 animations:^{
        self.topToolBar.transform = CGAffineTransformMakeTranslation(0, -64);
        self.bottomToolBar.transform = CGAffineTransformMakeTranslation(0, 49);
        [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }];
}

- (void)_toolAction:(UIBarButtonItem *)item
{
    if (item.tag==20) {
        [self _chagePageViewControllerStyle:UIPageViewControllerTransitionStyleScroll];
    }else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
#pragma mark -toolbar delegate
- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar;
{
    if (bar != self.bottomToolBar) {
        return UIBarPositionTopAttached;
    }
    return UIBarPositionBottom;
}

-(void)saveAutoBookMark
{
//    if (pages.count != 0 && leavesView.currentPageIndex < pages.count)
//    {
//        
//        Page *page=[pages objectAtIndex:leavesView.currentPageIndex];
//        
//        bookmark=[[BookMark alloc]init];
//        bookmark.bookId=book.bookId;
//        bookmark.chapterIndex=currentChapterIndex;
//        NSMutableString *text = [NSMutableString string];
//        if (lines.count>page.beginIndex) {
//            Line *line=[lines objectAtIndex:page.beginIndex];
//            [text appendString:line.text];
//            if ( lines.count>page.beginIndex+1) {
//                Line *line1=[lines objectAtIndex:page.beginIndex+1];
//                [text appendString:line1.text];
//            }
//            bookmark.firstCharOffsetInFile=line.offsetInBinaryFile;
//        }
//        //        [fileManage insertNewBookMark:@{@"ChapterIndex":[NSNumber numberWithInt:currentChapterIndex],@"offsetInBinaryFile":[NSNumber numberWithInt:bookmark.firstCharOffsetInFile],@"markText":text,@"markTime":[NSDate date]} withBook:self.book.bookId];
//        AutoBookmarkDao *autoBookmark=[[AutoBookmarkDao alloc]init];
//        [autoBookmark saveOrUpdate:bookmark];
//    }
}


-(void)openBookViewController
{
    NSLog(@"进入目录界面");
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
    LMBookViewController *bookViewController = [[LMBookViewController alloc]init];
    bookViewController.view.frame = self.view.bounds;
    bookViewController.currentBook = self.currentBook;
    bookViewController.pageModelControl = self.modelController;
//    [self.navigationController pushViewController:vc animated:YES];
    [self.view addSubview:bookViewController.view];
    [self addChildViewController:bookViewController];
    [bookViewController willMoveToParentViewController:self];
    //    UIDeviceOrientation isss =[[UIDevice currentDevice] orientation];
    //    if (UIDeviceOrientationIsPortrait(isss))
    //    {
    //        [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationLandscapeLeft];
    //    }else if (UIDeviceOrientationIsLandscape(isss))
    //    {
    //        [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationPortrait];
    //    }
    
//    [self saveAutoBookMark];
//    background.frame = CGRectMake(0, -topSpace, SCREEN_WIDTH, topSpace);
//    toolbar.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, toolbar.frame.size.height);
//    //    [lightnessView removeFromSuperview];
//    //    [tabShadow removeFromSuperview];
//    //    [fontSizeView removeFromSuperview];
//    //    [toolbar removeFromSuperview];
//    [adView setHidden:NO];
//    BookViewController *bookViewController;
//    if (ISiPad) {
//        bookViewController=[[BookViewController alloc]initWithNibName:@"BookViewController_iPad" bundle:nil];
//    }
//    else
//    {
//        bookViewController=[[BookViewController alloc]initWithNibName:(IPHONE5?@"BookViewController_5":@"BookViewController") bundle:nil];
//    }
//    bookViewController.nbpBook=book;
//    bookViewController.pageViewController = self;
//    bookViewController.bgColorInt = bgColorIndex;
//    bookViewController.lightness = lightLevel;
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.3f;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionPush;
//    transition.subtype = kCATransitionFromLeft;
//    transition.delegate = self;
//    [self.view.layer addAnimation:transition forKey:nil];
//    bookViewController.view.frame = self.view.bounds;
//    [self.view addSubview:bookViewController.view];
//    [self addChildViewController:bookViewController];
//    [bookViewController willMoveToParentViewController:self];
}

//保存书签
-(void)saveBookmarks
{
    NSLog(@"添加书签");
    //获取路径
    [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *documentPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *fileName = [documentPath stringByAppendingPathComponent:@"BookMarks.plist"];
    NSMutableDictionary *dataTag = [[NSMutableDictionary alloc]initWithContentsOfFile:fileName];
    //添加一项内容//查找当前书中的第几章节并添加到PLIST中
    //文字位置   把章节全部内容传过去，然后查找这页字的首字在这章节的第几个位置
    NSMutableArray *markAry = [dataTag objectForKey:@"mark"];
    
//    Page *page=[pages objectAtIndex:leavesView.currentPageIndex];
//    Line *line=[lines objectAtIndex:page.beginIndex];
//    if (line.text ==nil||[line.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0 || [line.text isEqualToString:@"\r\n"])
//    {
//        line = [lines objectAtIndex:page.beginIndex+1];
//    }
//    DirectoryItem *item=[book.chapters objectAtIndex:currentChapterIndex];
//    //获取章节名
//    NSString *chapterTitle=[NSString stringWithFormat:@"%@",item.title];
//    //获取书名
//    NSString *bookName = book.name;
//    //书id
//    NSString *bookId = book.bookId;
//    //获取一页的第一行
//    NSString *text =line.text;
//    //章节索引
//    NSString *chapterIndex = [NSString stringWithFormat:@"%d",currentChapterIndex];
//    NSString *firstCharOffsetInFile = [NSString stringWithFormat:@"%d",line.offsetInBinaryFile];
//    //当前叶数
//    NSString *pageIndex = [NSString stringWithFormat:@"%lu",leavesView.currentPageIndex +1];
//    //获取当前时间
//    NSDate *now = [NSDate date];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
//    NSInteger year = [dateComponent year];
//    NSInteger month = [dateComponent month];
//    NSInteger day = [dateComponent day];
//    NSInteger hour = [dateComponent hour];
//    NSInteger minute = [dateComponent minute];
//    NSInteger second = [dateComponent second];
//    NSString *time = [NSString stringWithFormat:@"%lu-%lu-%lu %lu:%lu:%lu",(long)year,(long)month,(long)day,(long)hour,(long)minute,(long)second];
//    NSString *contentStr = Nil;
//    if (markAry.count != 0)
//    {
//        for (int i = 0;i< markAry.count; i++)
//        {
//            if ([text isEqualToString:[[markAry objectAtIndex:i] objectForKey:@"content"]])
//            {
//                contentStr = text;
//            }
//        }
//        if (contentStr != nil&&contentStr.length != 0)
//        {
//            [self alertView:@"书签已存在"];
//            
//        }
//        else
//        {
//            NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:bookName,@"name",bookId,@"bookId",chapterTitle,@"chapter",text,@"content", time,@"time",chapterIndex,@"chapterIndex",firstCharOffsetInFile,@"firstCharOffsetInFile",pageIndex,@"pageIndex",nil];
//            [markAry addObject:dic];
//            [dataTag setValue:markAry forKey:@"mark"];
//            [dataTag writeToFile:fileName atomically:YES];
//            [self alertView:@"添加成功"];
//            
//        }
//    }
//    else
//    {
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:bookName,@"name",bookId,@"bookId",chapterTitle,@"chapter",text,@"content", time,@"time",chapterIndex,@"chapterIndex",firstCharOffsetInFile,@"firstCharOffsetInFile",pageIndex,@"pageIndex",nil];
//        [markAry addObject:dic];
//        [dataTag setValue:markAry forKey:@"mark"];
//        [dataTag writeToFile:fileName atomically:YES];
//        [self alertView:@"添加成功"];
//        
//    }
}

-(void)openFontSizeView
{
    NSLog(@"显示／隐藏字号");
    if (isFontSize == NO)
    {
        [lightnessView removeFromSuperview];
        fontSizeView.frame = CGRectMake(button4.center.x-100, SCREEN_HEIGHT-126, 200, 86);
        [self.view addSubview:fontSizeView];
        isFontSize = YES;
        islight = NO;
    }
    else
    {
        [fontSizeView removeFromSuperview];
        isFontSize = NO;
    }
    
}

-(void)openLightnessChangeView
{
    NSLog(@"显示／隐藏背景选择");
    if (islight == NO)
    {
        [fontSizeView removeFromSuperview];
        lightnessView.frame = CGRectMake(button5.center.x-215, SCREEN_HEIGHT-171, 255, 126);
        [self.view addSubview:lightnessView];
        islight = YES;
        isFontSize = NO;
    }
    else
    {
        [lightnessView removeFromSuperview];
        islight = NO;
    }
}


-(void)addFontSizeView
{
    CGSize viewSize=[[UIScreen mainScreen]bounds].size;
    CGRect frame=CGRectMake(button4.center.x-100, viewSize.height-126, 200, 86);
    fontSizeView=[[UIView alloc]initWithFrame:frame];
    
    fontSizeView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"fontsize_bg.png" ]];
    UIButton *buttonSmall=[UIButton buttonWithType:UIButtonTypeCustom];
    [buttonSmall setImage:[UIImage imageNamed:@"fontsize_reduce.png"] forState:UIControlStateNormal];
    [buttonSmall setImage:[UIImage imageNamed:@"fontsize_reduce_now.png"] forState:UIControlEventTouchDown];
    
    [buttonSmall addTarget:self action:@selector(fontSizeSmaller) forControlEvents:UIControlEventTouchDown];
    UIButton *buttonMore=[UIButton buttonWithType:UIButtonTypeCustom];
    [buttonMore setImage:[UIImage imageNamed:@"fontsize_large.png"] forState:UIControlStateNormal];
    [buttonMore setImage:[UIImage imageNamed:@"fontsize_large_now.png"] forState:UIControlEventTouchDown];
    [buttonMore addTarget:self action:@selector(fontSizeBigger) forControlEvents:UIControlEventTouchDown];
    CGRect rectS=CGRectMake(20, (frame.size.height-35)/2, 75, 30);
    buttonSmall.frame=rectS;
    CGRect rectM=CGRectMake(200-75-20, (frame.size.height-35)/2, 75, 30);
    buttonMore.frame=rectM;
    [fontSizeView addSubview:buttonSmall];
    [fontSizeView addSubview:buttonMore];
}


-(void)alertView:(NSString *)message
{
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示"message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:0.8f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:NO];
    
    [promptAlert show];
    
}
- (void)timerFireMethod:(NSTimer*)theTimer
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    
    promptAlert =NULL;
}

-(void)fontSizeSmaller
{
    [self.modelController pageChangeTextFontWithNumber:1];
    [[NSNotificationCenter defaultCenter]postNotificationName:FONTSMALL object:nil];
}


-(void)fontSizeBigger
{
    [self.modelController pageChangeTextFontWithNumber:100];
    [[NSNotificationCenter defaultCenter]postNotificationName:FONTBIG object:nil];
}


-(void)addLigntnessChangeView
{
    CGSize viewSize=[[UIScreen mainScreen]bounds].size;
    lightnessView=[[UIView alloc]init];
    lightnessView.frame=CGRectMake(button5.center.x-215, viewSize.height-171, 255, 126);
    lightnessView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_setupbg.png" ]];
    CGRect frame1=CGRectMake(50, 15, 155, 25.0);
    UISlider* mSlider=[[UISlider alloc]initWithFrame:frame1];
    [mSlider addTarget:self action:@selector(onChapterSlide1:) forControlEvents:UIControlEventValueChanged];
    [mSlider setMinimumValue:0];
    [mSlider setMaximumValue:1];
    mSlider.value = 0.6;
    lightLevel = mSlider.value;
    [lightnessView addSubview:mSlider];
    UIImage *light123image=[UIImage imageNamed:@"light123.png"];
    UIImageView *lightLeftImageView=[[UIImageView alloc]initWithImage:light123image];
    UIImageView *lightRightImageView=[[UIImageView alloc]initWithImage:light123image];
    lightLeftImageView.frame=CGRectMake(16, 18, 18, 18);
    lightRightImageView.frame=CGRectMake(217,15, 25, 25);
    [lightnessView addSubview:lightLeftImageView];
    [lightnessView addSubview:lightRightImageView];
    
    buttonSkin_1=[UIButton buttonWithType:UIButtonTypeCustom];
    buttonSkin_2=[UIButton buttonWithType:UIButtonTypeCustom];
    buttonSkin_3=[UIButton buttonWithType:UIButtonTypeCustom];
    buttonSkin_4=[UIButton buttonWithType:UIButtonTypeCustom];
    
    buttonSkin_4.frame=CGRectMake(196,60, 40, 40);
    buttonSkin_2.frame=CGRectMake(78,60, 40, 40);
    buttonSkin_3.frame=CGRectMake(137,60, 40, 40);
    buttonSkin_1.frame=CGRectMake(19,60, 40, 40);
    
    [self setBgColorBtnStatus];
    [lightnessView addSubview:buttonSkin_1];
    [lightnessView addSubview:buttonSkin_2];
    [lightnessView addSubview:buttonSkin_3];
    [lightnessView addSubview:buttonSkin_4];
    
    
}

-(void)setBgColorBtnStatus
{
    [buttonSkin_1 setImage:[UIImage imageNamed:bgColorIndex==1? @"skin_icon1_now":@"skin_icon1"] forState:UIControlStateNormal];
    [buttonSkin_1 setImage:[UIImage imageNamed:@"skin_icon1_now"] forState:UIControlEventTouchDown];
    [buttonSkin_1 addTarget:self action:@selector(changedColor_1) forControlEvents:UIControlEventTouchDown];
    
    [buttonSkin_2 setImage:[UIImage imageNamed:bgColorIndex==2? @"skin_icon2_now":@"skin_icon2"] forState:UIControlStateNormal];
    [buttonSkin_2 setImage:[UIImage imageNamed:@"skin_icon2_now"] forState:UIControlEventTouchDown];
    [buttonSkin_2 addTarget:self action:@selector(changedColor_2) forControlEvents:UIControlEventTouchDown];
    
    [buttonSkin_3 setImage:[UIImage imageNamed:bgColorIndex==3? @"skin_icon3_now.png":@"skin_icon3"] forState:UIControlStateNormal];
    [buttonSkin_3 setImage:[UIImage imageNamed:@"skin_icon3_now"] forState:UIControlEventTouchDown];
    [buttonSkin_3 addTarget:self action:@selector(changedColor_3) forControlEvents:UIControlEventTouchDown];
    
    [buttonSkin_4 setImage:[UIImage imageNamed:bgColorIndex==4? @"skin_icon4_now":@"skin_icon4"] forState:UIControlStateNormal];
    [buttonSkin_4 setImage:[UIImage imageNamed:@"skin_icon4_now"] forState:UIControlEventTouchDown];
    [buttonSkin_4 addTarget:self action:@selector(changedColor_4) forControlEvents:UIControlEventTouchDown];
}
-(void)changedColor_1
{
    [[NSNotificationCenter defaultCenter]postNotificationName:CHANGECOLOR_1 object:nil];
    [self saveBackColor:CHANGECOLOR_1];
    [self setBgColorBtnStatus];
}

-(void)changedColor_2
{
    [[NSNotificationCenter defaultCenter]postNotificationName:CHANGECOLOR_2 object:nil];
    [self saveBackColor:CHANGECOLOR_2];
    [self setBgColorBtnStatus];
}

-(void)changedColor_3
{
    [[NSNotificationCenter defaultCenter]postNotificationName:CHANGECOLOR_3 object:nil];
    [self saveBackColor:CHANGECOLOR_3];
    [self setBgColorBtnStatus];
}

-(void)changedColor_4
{
    [[NSNotificationCenter defaultCenter]postNotificationName:CHANGECOLOR_4 object:nil];
    [self saveBackColor:CHANGECOLOR_4];
    [self setBgColorBtnStatus];
    
}

-(void)saveBackColor:(NSString *)colorString
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:colorString forKey:BACKCOLOR];
    
}

-(void)onChapterSlide1:(id)sender
{
    UISlider *slider=sender;
    lightLevel = slider.value;
    [[UIScreen mainScreen] setBrightness: slider.value];
}
@end
