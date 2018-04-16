//
//  LMBookViewController.m
//  LMReader
//
//  Created by 许爱爱 on 16/6/12.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMBookViewController.h"
#import "LMJianView.h"
//#import "LMMarkView.h"
//#import "LMJianTableViewCell.h"
//#import "LMMarkTableViewCell.h"
#import "MarkCell.h"

@interface LMBookViewController()<UITableViewDelegate,UITableViewDataSource,MarkCellDelegate>

{
    UIImageView *backImageView;
    
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    UITableView *muTableView;

    LMJianView *jianTableView;
    UITableView *markTableView;
    
    UIButton *backBtn;
}

@end

@implementation LMBookViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.bgColorInt = 1;
    backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iPad_bg_1024"]];
    backImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    backImageView.userInteractionEnabled = YES;
    [self.view addSubview:backImageView];
    NSLog(@"self.pageModelControl.pageFrameset  ==  %@",self.pageModelControl.pageFrameset);
    [self addButtonSegment];
    [self addTableView];
    [self addJianJie];
    [self addShuQian];
    [self addBackButton];
}

-(void)addTableView
{
    muTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-100) style:UITableViewStylePlain];
    muTableView.delegate = self;
    muTableView.tag = 111;
    muTableView.backgroundColor = [UIColor clearColor];
    muTableView.dataSource = self;
    muTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [backImageView addSubview:muTableView];
}

-(void)addJianJie
{
    jianTableView = [[LMJianView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    jianTableView.hidden = YES;
    [jianTableView updateViewWithModel:self.currentBook];
    [backImageView addSubview:jianTableView];
    
//    jianTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-100) style:UITableViewStylePlain];
//    jianTableView.delegate = self;
//    jianTableView.tag = 222;
//    jianTableView.hidden = YES;
//    jianTableView.backgroundColor = [UIColor clearColor];
//    jianTableView.dataSource = self;
//    jianTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [backImageView addSubview:jianTableView];
}

-(void)addShuQian
{
    markTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-100) style:UITableViewStylePlain];
    markTableView.delegate = self;
    markTableView.tag = 333;
    markTableView.hidden = YES;
    markTableView.backgroundColor = [UIColor clearColor];
    markTableView.dataSource = self;
    markTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [backImageView addSubview:markTableView];
}


-(void)addBackButton
{
//    CGRect rx = [UIScreen mainScreen].bounds;
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-25,(SCREEN_HEIGHT - 50)/2, 25, 55)];
    [backBtn setImage:[UIImage imageNamed:@"bookback"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(onBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.backgroundColor = [UIColor clearColor];
    [backImageView addSubview:backBtn];
}

-(void)onBackBtn:(id)sender
{
    [self backView];
}
-(void)backView
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [self.view.superview.layer addAnimation:transition forKey:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}



-(void)addButtonSegment
{
    
    //边线颜色值
    UIColor *c = nil ;
    //背景颜色值
    UIColor *c1 = nil ;
    //标签中的字的颜色
    UIColor *c2 = nil ;
    //选中背景颜色值
    UIColor *c3 = nil;
    c = UIColorFromRGB(0xc2b198);
    c1 = UIColorFromRGB(0xf6ecdd);
    c2 = UIColorFromRGB(0x715936);
    c3 = UIColorFromRGB(0xf0ce9c);
    
    UIView *myview;
    float leftMargin;
    if (ISiPad) {
        leftMargin = 60;
        myview=[[UIView alloc]initWithFrame:CGRectMake(leftMargin, 20, self.view.frame.size.width-leftMargin*2,40)];
        
    }else
    {
        leftMargin = 25;
        myview=[[UIView alloc]initWithFrame:CGRectMake(leftMargin, 20, self.view.frame.size.width-leftMargin*2,40)];
    }
    // 设置圆角
    myview.layer.cornerRadius = 8;
    myview.layer.masksToBounds = YES;
    //加边框
    myview.layer.borderWidth = 0.5;
    myview.layer.borderColor = c.CGColor;
    myview.backgroundColor = c1;
    
    button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(0, 0, (SCREEN_WIDTH-leftMargin*2)/3, 40);
    [button1 setTitle:@"目录" forState:UIControlStateNormal];
    if (self.bgColorInt == 3)
    {
        [button1 setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    }
    else
    {
        [button1 setTitleColor:c2 forState:UIControlStateNormal];
    }
    button1.titleLabel.font=[UIFont boldSystemFontOfSize: 17.0f];
    button1.backgroundColor = c3;
    [button1 addTarget:self action:@selector(segmentleft) forControlEvents:UIControlEventTouchDown];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-leftMargin*2)/3, 0, 0.7, 40)];
    img.backgroundColor = c;
    
    button2=[UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame=CGRectMake((self.view.frame.size.width-leftMargin*2)/3,0, (self.view.frame.size.width-leftMargin*2)/3, 40);
    [button2 setTitle:@"简介" forState:UIControlStateNormal];
    button2.titleLabel.font=[UIFont boldSystemFontOfSize: 17.0f];
    [button2 setTitleColor:c2 forState:UIControlStateNormal];
    button2.backgroundColor = c1;
    [button2 addTarget:self action:@selector(segmentright) forControlEvents:UIControlEventTouchDown];
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-leftMargin*2)/3*2, 0, 0.7, 40)];
    img1.backgroundColor = c;
    
    button3=[UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame=CGRectMake((self.view.frame.size.width-leftMargin*2)/3*2, 0, (self.view.frame.size.width-leftMargin*2)/3, 40);
    [button3 setTitle:@"书签" forState:UIControlStateNormal];
    [button3 setTitleColor:c2 forState:UIControlStateNormal];
    button3.backgroundColor = c1;
    button3.titleLabel.font=[UIFont boldSystemFontOfSize: 17.0f];
    [button3 addTarget:self action:@selector(segmentmark) forControlEvents:UIControlEventTouchDown];
    [myview addSubview:button1];
    [myview addSubview:button2];
    [myview addSubview:button3];
    [myview addSubview:img ];
    [myview addSubview:img1];
    [backImageView addSubview:myview];
    
}

-(void)segmentmark
{
    button1.backgroundColor = UIColorFromRGB(0xf6ecdd);
    button2.backgroundColor = UIColorFromRGB(0xf6ecdd);
    button3.backgroundColor = UIColorFromRGB(0xf0ce9c);
    
    markTableView.hidden = NO;
    jianTableView.hidden = YES;
    muTableView.hidden = YES;
}


-(void)segmentright
{
    button1.backgroundColor = UIColorFromRGB(0xf6ecdd);
    button2.backgroundColor = UIColorFromRGB(0xf0ce9c);
    button3.backgroundColor = UIColorFromRGB(0xf6ecdd);

    markTableView.hidden = YES;
    jianTableView.hidden = NO;
    muTableView.hidden = YES;
}
-(void)segmentleft
{
   
    button1.backgroundColor = UIColorFromRGB(0xf0ce9c);
    button2.backgroundColor = UIColorFromRGB(0xf6ecdd);
    button3.backgroundColor = UIColorFromRGB(0xf6ecdd);
    markTableView.hidden = YES;
    jianTableView.hidden = YES;
    muTableView.hidden = NO;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath");
    if (self.pageModelControl)
    {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.pageModelControl.chapterIndex inSection:0];
        
//        [[tableView cellForRowAtIndexPath:indexPath ]setSelected:NO];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:JUMPCHAPTER object:nil];
//    [self.pageModelControl changeChapterWithNumber:indexPath.row];
//    DemoTextViewController *vc = [self.pageModelControl viewControllerAtIndex:self.pageModelControl.chapterIndex storyboard:nil];
//    WEAK_SELF
//    if (vc) {
//        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
//            [weakSelf.modelController setLastChapterToCurrent];
//        }];
//    }
//    [pageViewController openChapter:indexPath.row page:0];
    
    [self backView];
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (ISiPad?70:50);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 111) {
        DTAttStringManage *mana = [DTAttStringManage sharedManage];
        return mana.lChapters.count;
    }
//    else if (tableView.tag == 222)
//    {
//        return 1;
//    }else
    {
        return 102;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 111) {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.textLabel.font= [UIFont systemFontOfSize:18];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:(ISiPad?19:14)];
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
        }
        UIColor *c2 = nil;
        c2 = UIColorFromRGB(0x343043);
        cell.textLabel.textColor=c2;
        if (indexPath.row == self.pageModelControl.chapterIndex) {
            cell.textLabel.textColor =UIColorFromRGB(0x797979);
        }
        
        NSString *name = [[DTAttStringManage sharedManage] chapterNameOfIndex:indexPath.row];
        cell.textLabel.text=name;
        
        return cell;
    }
//    else if (tableView.tag == 222)
//    {
//        static NSString *CellIdentifier = @"jianCell";
//        LMJianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil)
//        {
//            cell = [[LMJianTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//            cell.textLabel.font= [UIFont systemFontOfSize:18];
//            cell.textLabel.font = [UIFont boldSystemFontOfSize:(ISiPad?19:14)];
//            cell.backgroundColor = [UIColor clearColor];
//            cell.contentView.backgroundColor = [UIColor clearColor];
//        }
//        return cell;
//    }
    else
    {
        static NSString *identifier = @"MIdentifier";
        MarkCell *cell = nil;
        NSArray *nibsArr = nil;
        cell = [markTableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            nibsArr = [[NSBundle mainBundle]loadNibNamed:@"MarkCell" owner:self options:nil];
            cell = [nibsArr objectAtIndex:0];
        }
        cell.delegate = self;
        [cell updateCellWithInfo:self.markAry];
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSUInteger const kTitleLabelTag = 2;
//
//    if (autoBookmark)
//    {
//        if(autoBookmark.chapterIndex==indexPath.row)
//        {
//            
//            UIColor *c2 = nil;
//            if (bgColorInt == 1 || bgColorInt == 2)
//            {
//                c2 = UIColorFromRGB(0xd18c27);
//            }
//            else if (bgColorInt == 3)
//            {
//                c2 = UIColorFromRGB(0xff953f);
//            }
//            else
//            {
//                c2 = UIColorFromRGB(0xffffff);
//            }
//            cell.textLabel.textColor=c2;
//            
//        }
//        else
//        {
//            UIView *view=[cell viewWithTag:kTitleLabelTag];
//            if (view)
//            {
//                [view removeFromSuperview];
//            }
//            
//        }
//    }
//    //    选中状态的字体颜色
//    cell.textLabel.highlightedTextColor =[UIColor colorWithRed:66.0f/255.0f green:84.0f/255.0f blue:78.0f/255.0f alpha:1.0];
//    
//    
//    //    选中状态加背景图片
//    cell.selectedBackgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"list_line_now.png"]];
    
    
}


@end
