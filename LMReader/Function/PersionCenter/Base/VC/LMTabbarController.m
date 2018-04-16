//
//  LMTabbarController.m
//  LMReader
//
//  Created by 许爱爱 on 16/6/16.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMTabbarController.h"
#import "LMTabbarButton.h"
#import "LMBookShelfVC.h"
#import "LMBaseNavigationController.h"
#import "LMRecommendViewController.h"    //最新推荐
#import "LMClassViewController.h"    //分类
#import "LMThemeViewController.h"  //精品主题


@interface LMTabbarController()

{
    UIImageView *_tabbarView;
    LMTabbarButton *_previousButton;
    NSArray *_nameArray;
    NSArray *_normalImageArray;
    NSArray *_selectImageArray;
}

@end

@implementation LMTabbarController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    for (UIView *obj in self.tabBar.subviews) {
        if (obj != _tabbarView) {
            [obj removeFromSuperview];
        }
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _nameArray = [NSArray arrayWithObjects:@"书架",@"推荐",@"主题",@"分类" ,nil];
    _normalImageArray = [NSArray arrayWithObjects:@"gavicon_search",@"gavicon_push",@"gavicon_toplist",@"gavicon_coteraty" ,nil];
    _selectImageArray = [NSArray arrayWithObjects:@"gavicon_search_now",@"gavicon_push_now",@"gavicon_toplist_now",@"gavicon_coteraty_now" ,nil];
    
    _tabbarView = [[UIImageView alloc]initWithFrame:self.tabBar.bounds];
    _tabbarView.userInteractionEnabled = YES;
    _tabbarView.backgroundColor = [UIColor grayColor];
    _tabbarView.image = [UIImage imageNamed:@""];
    [self.tabBar addSubview:_tabbarView];
    
    
    LMBookShelfVC * first = [[LMBookShelfVC alloc]init];
    UINavigationController * navi1 = [[LMBaseNavigationController alloc]initWithRootViewController:first];
    
    LMRecommendViewController * second = [[LMRecommendViewController alloc]init];
    UINavigationController * navi2 = [[LMBaseNavigationController alloc]initWithRootViewController:second];
    
    LMThemeViewController * third = [[LMThemeViewController alloc]init];
    UINavigationController * navi3 = [[LMBaseNavigationController alloc]initWithRootViewController:third];
    
    LMClassViewController * fourth = [[LMClassViewController alloc]init];
    UINavigationController * navi4 = [[LMBaseNavigationController alloc]initWithRootViewController:fourth];
    
    self.viewControllers = [NSArray arrayWithObjects:navi1,navi2,navi3,navi4, nil];
    
    
    for (int i = 0; i<_nameArray.count; i++) {
         [self creatButtonWithNormalName:_normalImageArray[i] andSelectName:_selectImageArray[i] andTitle:_nameArray[i] andIndex:i];
    }
    LMTabbarButton * button = _tabbarView.subviews[0];
    [self changeViewController:button];
    
}

#pragma mark 创建一个按钮

- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index{
    
    LMTabbarButton * customButton = [LMTabbarButton buttonWithType:UIButtonTypeCustom];
    customButton.tag = index;
    
    CGFloat buttonW = _tabbarView.frame.size.width / 4;
    CGFloat buttonH = _tabbarView.frame.size.height;
    
    customButton.frame = CGRectMake(80 * index, 0, buttonW, buttonH);
    [customButton setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    //[customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateDisabled];
    //这里应该设置选中状态的图片。wsq
    [customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    [customButton setTitle:title forState:UIControlStateNormal];
    
    [customButton addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
    
//    customButton.imageView.contentMode = UIViewContentModeCenter;
    customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    customButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    [_tabbarView addSubview:customButton];
    
    if(index == 0)//设置第一个选择项。（默认选择项） wsq
    {
        _previousButton = customButton;
        _previousButton.selected = YES;
    }
    
}

#pragma mark 按钮被点击时调用
- (void)changeViewController:(LMTabbarButton *)sender
{
    if(self.selectedIndex != sender.tag){ //wsq®
        self.selectedIndex = sender.tag; //切换不同控制器的界面
        _previousButton.selected = ! _previousButton.selected;
        _previousButton = sender;
        _previousButton.selected = YES;
    }
}



@end
