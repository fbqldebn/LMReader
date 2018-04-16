//
//  LMSearchViewController.m
//  LMReader
//
//  Created by 许爱爱 on 16/6/16.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMSearchViewController.h"

@implementation LMSearchViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"搜索";
}

-(void)initData
{
    self.sDataAry = [[NSMutableArray alloc]init];
    btnAry = [[NSMutableArray alloc]init];
    requestAry = [[NSMutableArray alloc]init];
    changeId =  0;
}
-(void)createView
{
    self.searchB = [[UISearchBar alloc]init];
    self.searchB.frame = CGRectMake(0, 44, SCREEN_WIDTH, 44);
    self.searchB.showsScopeBar = YES;
    [self.view addSubview:self.searchB];
    
    
    loadingView = [[MBProgressHUD alloc]initWithView:self.view];
  
    
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, SCREEN_HEIGHT-80)];
    UIImageView *networkFailedView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-175)/2,10, 175, 225)];
    backView.backgroundColor = [UIColor whiteColor];
    networkFailedView.image = LOADIMAGE(@"network_note", @"png");
    backView.userInteractionEnabled = YES;
    [backView addSubview:networkFailedView];
    tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureHandle)];
    [backView addGestureRecognizer:tapGesture];
    
    
    //    [self loadData];
    [self requestMarkData:YES];
    
    self.view.backgroundColor = UIColorFromRGB(0xe8e8e8);
    
    //    [self.searchB sizeToFit];
    
    
    //lable
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, self.searchB.frame.size.height + self.searchB.frame.origin.y+10, 200, 30)];
    label.text = @"搜索热词:";
    label.textColor = UIColorFromRGB(0x868686);
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:Ifont size:16];
    [self.view addSubview:label];
    
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 90-20, SCREEN_WIDTH, SCREEN_HEIGHT-88-49)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.7;
    [self.view addSubview:bgView];
    bgView.hidden = YES;
    //    [self setGuidePageS];

}

- (void)requestMarkData:(BOOL)refresh
{
//    [self showLoadingViewWithStatus:LMLoadingStatusStart message:nil];
    Connector *con = [[Connector alloc]init];
    NSString *requestString = [NSString stringWithFormat:@"%@",[con getUrl:9 url:COMMENURL]];
    self.request = [HTTPRequest getRequestDocumentWithUrl:requestString params:nil success:^(GDataXMLDocument *responseDict) {
        NSLog(@"成功");
        {
        if (responseDict) {
            
//            [self showLoadingViewWithStatus:LMLoadingStatusSuccess message:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self refreshViewWithXMLData:responseDict];
            });
        }
        }
        
    } fail:^(NSString *errorMsg) {
        NSLog(@"失败");
        //        [self showLoadingViewWithStatus:LMLoadingStatusFailure message:nil];
        
        //        [refreshHeader endRefreshing];
    }];
    
}
            

                    
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GETGDataXML:[NSString stringWithFormat:@"%@",[con getUrl:9 url:commonUrl]] parameters:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, GDataXMLDocument *XMLDocument) {
//        
//        if (XMLDocument) {
//            [self showLoadingViewWithStatus:LMLoadingStatusSuccess message:nil];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self refreshViewWithXMLData:XMLDocument];
//            });
//            
//        }
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, GDataXMLDocument *XMLDocument) {
//        
//        [self showLoadingViewWithStatus:LMLoadingStatusFailure message:nil];
//    }];
//    

- (void)refreshViewWithXMLData:(GDataXMLDocument*)XMLDocument
{
    [self.sDataAry removeAllObjects];
    NSError *error;
    NSArray * categaryList = [XMLDocument nodesForXPath:@"keys" error:&error];
    for (GDataXMLElement *categoryElement in categaryList)
    {
        
        NSArray * itemlist = [categoryElement nodesForXPath:@"key" error:&error];
        
        for (GDataXMLElement *item in itemlist)
        {
            [self.sDataAry addObject:item.stringValue];
        }
    }
    //    count = self.sDataAry.count;
    
    [self setView];
    
}

-(void)setView
{
    
    float x = 0;
    float y = 0;
    if (self.sDataAry.count != 0)
    {
        for (int i = 0; i<7; i++)
        {
            UIButton *btn =  [[UIButton alloc]initWithFrame:CGRectMake((i%2)*((self.view.frame.size.width-30)/2)+10+((i%2)*10), self.searchB.frame.size.height + self.searchB.frame.origin.y + 55 +(int)(i/2)*50 + (i/2)*(ISiPad?30:10), (self.view.frame.size.width-30)/2, 50)];
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            [btn setTitle:[self.sDataAry objectAtIndex:i+(changeId*7)] forState:UIControlStateNormal];
            [btn setTintColor:[UIColor blackColor]];
            btn.titleLabel.font = [UIFont fontWithName:Ifont size:ISiPad?18: 15];
            [btn setTitleColor:UIColorFromRGB(0x3c3c3c) forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
            btn.layer.cornerRadius=3;
            btn.layer.shadowColor=[UIColor blackColor].CGColor;
            btn.layer.shadowOffset=CGSizeMake(1, 1);
            btn.layer.shadowOpacity=0.1;
            btn.layer.shadowRadius=3;
            
            x = btn.frame.origin.x;
            y = btn.frame.origin.y;
            [self.view addSubview:btn];
            [btnAry addObject:btn];
        }
        UIButton *changBtn = [[UIButton alloc]initWithFrame:CGRectMake(x + (self.view.frame.size.width-30)/2 +10, y, (self.view.frame.size.width-30)/2, 50)];
        changBtn.backgroundColor = [UIColor whiteColor];
        [changBtn setTitle:@"换一批" forState:UIControlStateNormal];
        [changBtn setTitleColor:UIColorFromRGB(0xff0050) forState:UIControlStateNormal];
        changBtn.titleLabel.font = [UIFont fontWithName:Ifont size:15];
        changBtn.backgroundColor = [UIColor whiteColor];
        changBtn.layer.cornerRadius=3;
        changBtn.layer.shadowColor=[UIColor blackColor].CGColor;
        changBtn.layer.shadowOffset=CGSizeMake(1, 1);
        changBtn.layer.shadowOpacity=0.2;
        changBtn.layer.shadowRadius=3;
        [changBtn addTarget:self action:@selector(clickChangBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:changBtn];
    }
    
}

                -(void)clickChangBtn
{
    
    if ((changeId+1)*7 < self.sDataAry.count)
    {
        changeId ++;
    }
    else
    {
        changeId = 0;
    }
    for (int i = 0; i< btnAry.count; i++)
    {
        UIButton *btn = [btnAry objectAtIndex:i];
        if(i+changeId*7<self.sDataAry.count)
            [btn setTitle:[self.sDataAry objectAtIndex:i+changeId*7] forState:UIControlStateNormal];
    }
    
}
               
- (void)tapGestureHandle
{
//    [self loadData];
}
-(void)clickBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    bookId = [self.sDataAry objectAtIndex:btn.tag+(changeId*7)];
    [self searchBookAction:btn.titleLabel.text];
}
-(void)searchBookAction:(NSString *)keyword
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    keywordStr  = [keyword copy];
    Connector *con = [[Connector alloc]init];
    NSString *urlStr = [[NSString stringWithFormat:@"%@&cat=novel&pageidx=%d&numperpage=10&keyword=%@",[con getUrl:3 url:COMMENURL],1,[[keyword stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [[NSURL alloc]initWithString:urlStr];
//    ASIHTTPRequest *requestS = [[ASIHTTPRequest alloc]initWithURL:url];
//    requestS.tag = 101;
//    requestS.timeOutSeconds = 5;
//    [requestS setDelegate:self];
//    [requestS startAsynchronous];
}


@end
