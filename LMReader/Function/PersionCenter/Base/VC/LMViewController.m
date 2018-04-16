//
//  LMViewController.m
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMViewController.h"



@implementation LMViewController

- (void)loadView
{
    [super loadView];
    self.view = [[UIView alloc]initWithFrame:SCREEN_BOUNDS];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)createLeftButtonWithString:(NSString *)leftTitle
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, NAVIBUTTON_WIDTH, NAVIBUTTON_HEIGHT)];
    
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 13, NAVIBUTTON_WIDTH, 20)];
    leftLabel.text = leftTitle;
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:leftLabel];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    leftButton.backgroundColor  =[UIColor redColor];
    leftButton.frame =CGRectMake(0, 0, NAVIBUTTON_WIDTH, NAVIBUTTON_HEIGHT);
    [backView addSubview:leftButton];
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backView];
    [self.navigationItem setLeftBarButtonItem:leftButtonItem];
}

-(void)leftButtonClick:(id)action
{
    NSLog(@"左边按钮点击");
}

-(void)createRightButtonWithString:(NSString *)rightTitle
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-NAVIBUTTON_WIDTH, 0, NAVIBUTTON_WIDTH, NAVIBUTTON_HEIGHT)];
    
    UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 13, NAVIBUTTON_WIDTH, 20)];
    rightLabel.text = rightTitle;
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:rightLabel];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//       rightButton.backgroundColor  =[UIColor redColor];
    rightButton.frame =CGRectMake(0, 0, NAVIBUTTON_WIDTH, NAVIBUTTON_HEIGHT);
    [backView addSubview:rightButton];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backView];
    [self.navigationItem setRightBarButtonItem:rightButtonItem];

}

-(void)rightButtonClick:(id)action
{
    
}



@end
