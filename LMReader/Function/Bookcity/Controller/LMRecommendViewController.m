//
//  LMRecommendViewController.m
//  LMReader
//
//  Created by 许爱爱 on 16/6/16.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMRecommendViewController.h"
#import "HTTPRequest.h"


@interface LMRecommendViewController ()
{
    YiRefreshHeader *refreshHeaderA;
    YiRefreshFooter *refreshFooterA;
    YiRefreshHeader *refreshHeaderB;
    YiRefreshFooter *refreshFooterB;
    YiRefreshHeader *refreshHeaderC;
    YiRefreshFooter *refreshFooterC;
    
    float cell_Height;
    float image_Width;
    float fontSize;
}
@end


@implementation LMRecommendViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"最新推荐";
    
    if (ISiPad) {
        cell_Height = 120;
        image_Width = 78;
        fontSize = 20;
    }else
    {
        fontSize = 16;
        image_Width = 58;
        cell_Height = 77;
    }

    [self dataAllocMemory];
    [self initUI];
    [self requestCategoryData:nil refresh:YES];

    
}

#pragma mark -init data

- (void)dataAllocMemory
{
    self.cid = [[NSMutableArray alloc]init];
    self.myArray = [NSMutableArray array];
    self.boyArray = [NSMutableArray array];
    self.girlArray = [NSMutableArray array];
    
}

- (void)requestCategoryData:(NSString *)category refresh:(BOOL)refresh
{
    _reloading = YES;
    
    NSInteger pageIndex=0;
    NSString *requestString = [NSString stringWithFormat:@"%@libraryrecommended.action",COMMENURL];
    if (!category||[self.cid indexOfObject:category]==0) {
        pageIndex = self.myArray.count/10+1;
        
        self.request = [HTTPRequest getRequestWithUrl:requestString params:@{@"pageidx":@(pageIndex),@"numperpage":@"10",@"catid":category?category:@"",@"cat":@"novel"} success:^(GDataXMLElement *responseDict) {
            NSLog(@"成功");
            {
                LMPaser *paser = [[LMPaser alloc]init];
                self.myArray = [paser paserRecommend:responseDict];
                NSLog(@"self.myArray.count  ====    %d",self.myArray.count);
                [self.myTableView reloadData];
//                [self initUI];
            }
            
        }fail:^(NSString *errorMsg) {
            NSLog(@"失败");
        }];

        
    }else if ([self.cid indexOfObject:category]==1)
    {
        pageIndex = self.boyArray.count/10+1;
        
        self.request = [HTTPRequest getRequestWithUrl:requestString params:@{@"pageidx":@(pageIndex),@"numperpage":@"10",@"catid":category?category:@"",@"cat":@"novel"} success:^(GDataXMLElement *responseDict) {
            NSLog(@"成功");
            {
                LMPaser *paser = [[LMPaser alloc]init];
                self.boyArray = [paser paserRecommend:responseDict];
                [self.boyTableView reloadData];
                NSLog(@"boyArray  ====    %d",self.boyArray.count);
//                [self initUI];
            }
            
        }fail:^(NSString *errorMsg) {
            NSLog(@"失败");
        }];

    }else if ([self.cid indexOfObject:category]==2)
    {
        pageIndex = self.girlArray.count/10+1;
        
        self.request = [HTTPRequest getRequestWithUrl:requestString params:@{@"pageidx":@(pageIndex),@"numperpage":@"10",@"catid":category?category:@"",@"cat":@"novel"} success:^(GDataXMLElement *responseDict) {
            NSLog(@"成功");
            {
                LMPaser *paser = [[LMPaser alloc]init];
                self.girlArray = [paser paserRecommend:responseDict];
                NSLog(@"girlArray  ====    %d",self.girlArray.count);
                [self.girlTableView reloadData];
//                [self initUI];
            }
            
        }fail:^(NSString *errorMsg) {
            NSLog(@"失败");
        }];

    }
    if (pageIndex==1&&!category) {
//        [self showLoadingViewWithStatus:LMLoadingStatusStart message:nil];
    }
    
    
    
}




-(void)initUI
{
    if (!self.chnalSV) {
        self.chnalSV = [[UIScrollView alloc]init];
    }
    self.chnalSV.showsHorizontalScrollIndicator=NO;
    self.chnalSV.showsVerticalScrollIndicator=NO;
    self.chnalSV.pagingEnabled=YES;
    self.chnalSV.bounces = NO;
    self.chnalSV.userInteractionEnabled = YES;
    self.chnalSV.contentSize = CGSizeMake(SCREEN_WIDTH*3 , 0);
    self.chnalSV.pagingEnabled = YES;
    self.chnalSV.delegate = self;
    [self.view addSubview:self.chnalSV];

    NSArray *ar = @[@"最新",@"男频",@"女频"];
    
    self.titleView = [[UIView alloc]init];
    self.titleView.frame = CGRectMake(0, 44+22, SCREEN_WIDTH, 40);
    [self.view addSubview:self.titleView];
    
    self.chnalSV.frame = CGRectMake(0, self.titleView.frame.size.height+10, SCREEN_WIDTH, SCREEN_HEIGHT-135);
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-135) style:UITableViewStylePlain];
    self.boyTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-135) style:UITableViewStylePlain];
    self.girlTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT-135) style:UITableViewStylePlain];
    self.myTableView.dataSource= self;
    self.boyTableView.dataSource = self;
    self.girlTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.boyTableView.delegate = self;
    self.girlTableView.delegate = self;
    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        
        [self.myTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.boyTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        
        [self.boyTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.girlTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        
        [self.girlTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    self.myTableView.tableFooterView = [[UIView alloc]init];
    self.boyTableView.tableFooterView = [[UIView alloc]init];
    self.girlTableView.tableFooterView = [[UIView alloc]init];
    [self.chnalSV addSubview:self.myTableView];
    [self.chnalSV addSubview:self.boyTableView];
    [self.chnalSV addSubview:self.girlTableView];
    
    __block LMRecommendViewController *weakself = self;
    refreshHeaderA=[[YiRefreshHeader alloc] init];
    
    refreshHeaderA.scrollView=_myTableView;
    [refreshHeaderA header];
    refreshHeaderA.beginRefreshingBlock = ^(){
        [weakself requestCategoryData:weakself.cid.count>0?weakself.cid[0]:nil refresh:YES];
    };
        [refreshHeaderA beginRefreshing];
    
    refreshFooterA=[[YiRefreshFooter alloc] init];
    refreshFooterA.scrollView=_myTableView;
    [refreshFooterA footer];
    refreshFooterA.beginRefreshingBlock=^(){
        [weakself requestCategoryData:weakself.cid.count>0?weakself.cid[0]:nil refresh:NO];
    };
    
    //b
    refreshHeaderB=[[YiRefreshHeader alloc] init];
    
    refreshHeaderB.scrollView=_boyTableView;
    [refreshHeaderB header];
    refreshHeaderB.beginRefreshingBlock = ^(){
        [weakself requestCategoryData:weakself.cid.count>1?weakself.cid[1]:nil refresh:YES];
    };
        [refreshHeaderB beginRefreshing];
    
    refreshFooterB=[[YiRefreshFooter alloc] init];
    refreshFooterB.scrollView=_boyTableView;
    [refreshFooterB footer];
    refreshFooterB.beginRefreshingBlock=^(){
        [weakself requestCategoryData:weakself.cid.count>1?weakself.cid[1]:nil refresh:NO];
    };
    
    refreshHeaderC=[[YiRefreshHeader alloc] init];
    
    refreshHeaderC.scrollView=_girlTableView;
    [refreshHeaderC header];
    refreshHeaderC.beginRefreshingBlock = ^(){
        [weakself requestCategoryData:weakself.cid.count>2?weakself.cid[2]:nil refresh:YES];
    };
        [refreshHeaderC beginRefreshing];
    
    refreshFooterC=[[YiRefreshFooter alloc] init];
    refreshFooterC.scrollView=_girlTableView;
    [refreshFooterC footer];
    refreshFooterC.beginRefreshingBlock=^(){
        [weakself requestCategoryData:weakself.cid.count>2?weakself.cid[2]:nil refresh:NO];
    };
    
    
       for (int i = 0; i<3; i++) {
        NSString *st = [ar objectAtIndex:i];
        self.titalBtn = [[UIButton alloc]initWithFrame:CGRectMake((int)(SCREEN_WIDTH/3)*i, 0, (SCREEN_WIDTH/3)-1, 37)];
        self.titalBtn.titleLabel.font = [UIFont fontWithName:Ifont size:16];
        [self.titleView addSubview:self.self.titalBtn];
        self.titalBtn.tag = 100+i;
        self.titalBtn.backgroundColor = [UIColor clearColor];
        [self.titalBtn setTitle:st forState:UIControlStateNormal];
        if (i==0) {
            [self.titalBtn setTitleColor:UIColorFromRGB(0xff0050) forState:UIControlStateNormal];
        }else
        {
            [self.titalBtn setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
        }
        
        [self.titalBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.titleView.layer.borderWidth = 1;
    self.titleView.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.8].CGColor;
    //添加竖线
    for (int i = 1; i<3; i++) {
        UIView *lView = [[UIView alloc]initWithFrame:CGRectMake((int)(SCREEN_WIDTH/3)*i-1,11,1,20)];
        lView.backgroundColor = UIColorFromRGB(0xafafaf);
        [self.titleView addSubview:lView];
    }
    CGRect p = CGRectMake(0, 37, (SCREEN_WIDTH/3), 3);
    //添加选择线
    self.selectLine = [[UIView alloc]initWithFrame:p];
    self.selectLine.backgroundColor = UIColorFromRGB(0xff0050);
    [self.titleView addSubview:self.selectLine];
}

-(void)click:(UIButton*)btn{
    
    for (UIButton* subview in [self.titleView subviews])
    {
        if ([subview isKindOfClass:[UIButton class]]) {
            [subview setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
        }
    }
    [btn setTitleColor:UIColorFromRGB(0xff0050) forState:UIControlStateNormal];
    for (int i = 0; i<3; i++) {
        if (btn.tag == i+100) {
            [self.chnalSV setContentOffset:CGPointMake(SCREEN_WIDTH*i, 0) animated:YES];
            [UIView animateWithDuration:.3 animations:^{
                //                self.chnalSV.contentOffset = CGPointMake(SCREEN_WIDTH*i, 0);
                
                self.selectLine.frame = CGRectMake((SCREEN_WIDTH/3)*i, 37, (SCREEN_WIDTH/3), 3);
                
            }];
        }
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
  
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ((NSInteger)self.chnalSV.contentOffset.x % (NSInteger)SCREEN_WIDTH)
    {
        return;
    }
    if (scrollView ==self.chnalSV) {
        for (UIButton* subview in [self.titleView subviews])
        {
            if ([subview isKindOfClass:[UIButton class]]) {
                [subview setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
            }
        }
        for (int i = 0; i<3; i++) {
            if (self.chnalSV.contentOffset.x == SCREEN_WIDTH*i) {
                self.selectLine.frame = CGRectMake((SCREEN_WIDTH/3)*i, 37, (SCREEN_WIDTH/3), 3);
                
                switch (i) {
                    case 0:
                    {
                        UIButton *selectBt = (UIButton *)[self.titleView viewWithTag:100];
                        [selectBt setTitleColor:UIColorFromRGB(0xff0050) forState:UIControlStateNormal];
                        if (!self.myArray.count&&self.cid.count>0) {
                            [refreshHeaderA beginRefreshing];
                        }else if(totalItemA<=self.myArray.count)
                        {
                            [_refreshHeaderView egoRefreshFinish];
                            
                        }
                    }
                        break;
                    case 1:
                    {
                        UIButton *selectBt = (UIButton *)[self.titleView viewWithTag:101];
                        [selectBt setTitleColor:UIColorFromRGB(0xff0050) forState:UIControlStateNormal];
                        if (!self.boyArray.count&&self.cid.count>1) {
                            [refreshHeaderB beginRefreshing];
                        }else
                        {
                           
                        }
                    }
                        break;
                    case 2:
                    {
                        UIButton *selectBt = (UIButton *)[self.titleView viewWithTag:102];
                        [selectBt setTitleColor:UIColorFromRGB(0xff0050) forState:UIControlStateNormal];
                        if (!self.girlArray.count&&self.cid.count>2) {
                            [refreshHeaderC beginRefreshing];
                        }else
                        {
                           
                        }
                    }
                        break;
                    default:
                        break;
                }
            }
        }
    }
    
}

#pragma mark tableview method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.myTableView) {
        NSLog(@"self.myArray.count      %d",self.myArray.count);
        return self.myArray.count;
    }
    if (tableView == self.boyTableView) {
        return self.boyArray.count;
    }
    else{
        return self.girlArray.count;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TJCell";
    TJTableViewCell *cell = (TJTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        if (ISiPad) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"TJTableViewCell_iPad" owner:self options:nil] objectAtIndex:0];
        }else
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"TJTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
    }
    
    if (tableView == self.myTableView) {
        [cell reloadCell1:self.myArray index:indexPath.row];
        
    }
    if (tableView == self.boyTableView) {
        [cell reloadCell1:self.boyArray index:indexPath.row];
        
    }
    if (tableView == self.girlTableView) {
        [cell reloadCell1:self.girlArray index:indexPath.row];
        
    }
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xe8e6e6);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *urlString=[[NSString alloc]initWithFormat:@"%@%@",commonUrl,@"bookinfo.action"];
//    
//    [RequestMsg showWaitingIndicator:self.view];
//    if ([tableView isEqual:self.listTab]) {
//        dataAry = self.listAry;
//    }else if ([tableView isEqual:self.blistTab])
//    {
//        dataAry = self.blistAry;
//    }
//    else if ([tableView isEqual:self.clistTab])
//    {
//        dataAry = self.clistAry;
//    }
//    Recommend *bookItem = [dataAry objectAtIndex:indexPath.row];
//    RequestMsg *msg=[[RequestMsg alloc]init:TYPE_BOOKINFO];
//    msg.reqString=urlString;
//    [msg addParams:@"bookid" value:bookItem.bookID];
//    [msg sendMsg:self];
}

-(void)showViewController:(id )obj
{
//    BookInfoViewController *bookInfoViewController;
//    if (ISiPad) {
//        bookInfoViewController=[[BookInfoViewController alloc]initWithNibName:@"BookInfoViewController_iPad" bundle:nil];
//    }
//    else
//    {
//        bookInfoViewController=[[BookInfoViewController alloc]initWithNibName:@"BookInfoViewController" bundle:nil];
//    }
//    bookInfoViewController.bookInfoInterface = obj;
//    bookInfoViewController.title=bookInfoViewController.bookInfoInterface.title;
//    bookInfoViewController.backString=@"书城";
//    
//    [self.navigationController pushViewController:bookInfoViewController animated:YES];
}


@end
