//
//  LMClassViewController.m
//  LMReader
//
//  Created by 许爱爱 on 16/6/16.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMClassViewController.h"

@implementation LMClassViewController

float leftMar;
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    self.scrollView.delegate = self;
    searchResults = [[NSMutableArray alloc]init];
    
    leftMar = ISiPad?0:0;
    cellWidth = ISiPad?(SCREEN_WIDTH-20)/4:(SCREEN_WIDTH-20)/3;
  }

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"分类";
    [self initData];
    [self requestCategoryData:YES];
    [self createScrollView];
}

-(void)initData
{
    cateDic = [[NSMutableDictionary alloc]init];
    cateDataDic = [[NSMutableDictionary alloc]init];
    self.cateAry = [[NSMutableArray alloc]init];
    isB = YES;
    cateInt = 0;
    
    catalogList= [CatalogList shareCatalogList];
    vAry = [[NSMutableArray alloc]init];
    ary = [[NSArray alloc]init];
    categoryArray = [[NSMutableArray alloc]init];
}

-(void)createScrollView
{
    
}


- (void)requestCategoryData:(BOOL)refresh
{
    
    NSString *requestString = [NSString stringWithFormat:@"%@librarysort.action",COMMENURL];
    self.request = [HTTPRequest getRequestDocumentWithUrl:requestString params:@{@"cat":@"novel"} success:^(GDataXMLDocument *responseDict) {
        NSLog(@"成功");
        {
            
            if (responseDict) {
//                [self showLoadingViewWithStatus:LMLoadingStatusSuccess message:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self refreshViewWithXMLData:responseDict];
                });
                
            }

//            [refreshHeader endRefreshing];
            [self refreshViewWithXMLData:responseDict];
            //            LMPaser *paser = [[LMPaser alloc]init];
            //            self.myArray = [paser paserRecommend:responseDict];
            //            NSLog(@"self.myArray.count  ====    %d",self.myArray.count);
            //            [self.myTableView reloadData];
            //                [self initUI];
        }
        
    } fail:^(NSString *errorMsg) {
        NSLog(@"失败");
//        [self showLoadingViewWithStatus:LMLoadingStatusFailure message:nil];

//        [refreshHeader endRefreshing];
    }];

    //    if(!cateDataDic.count)
    //    {
    //        [self showLoadingViewWithStatus:LMLoadingStatusStart message:nil];
    //    }
//    [self showLoadingViewWithStatus:LMLoadingStatusStart message:nil];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GETGDataXML:[[NSString alloc]initWithFormat:@"%@%@",commonUrl,@"librarysort.action"] parameters:@{@"cat":@"novel"} success:^(NSURLRequest *request, NSHTTPURLResponse *response, GDataXMLDocument *XMLDocument) {
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
    
}

- (void)refreshViewWithXMLData:(GDataXMLDocument*)XMLDocument
{
    [cateDataDic removeAllObjects];
    
    NSError *error;
    GDataXMLElement *rootElement = [XMLDocument rootElement];
    NSArray * categaryList = [rootElement nodesForXPath:@"parentsort" error:&error];
    NSLog(@"categaryList.count  ==  %d",categaryList.count);
    for (GDataXMLElement *categoryElement in categaryList)
    {
        NSArray * itemlist = [categoryElement nodesForXPath:@"sort" error:&error];
        NSMutableArray *mutableArr = [NSMutableArray array];
        for (GDataXMLElement *item in itemlist)
        {
            Catalog *category = [[Catalog alloc]init];
            category.cid = [item attributeForName:@"id"].stringValue;//解析属性
            category.name = [item attributeForName:@"name"].stringValue;//解析属性
            category.focus = [item attributeForName:@"focuson_num"].stringValue;//解析属性
            category.coverId = [item attributeForName:@"coverid"].stringValue;//解析属性
            category.cover_update = [[item attributeForName:@"cover_update"].stringValue boolValue];//解析属性
            category.topspot = [[item attributeForName:@"topspot"].stringValue boolValue];
            
            [mutableArr addObject:category];
          
        }
        [cateDataDic setObject:mutableArr forKey:[categoryElement attributeForName:@"name"].stringValue];
    }
    [self againLoadView];
}
-(void)againLoadView
{
    self.scrollView.contentOffset = location;
    ary =[cateDataDic allKeys];
    //字典排序
    ary = [ary sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;
    }];
    
    UIColor *color2 = UIColorFromRGB(0xC1D98F);
    UIColor *color1 = UIColorFromRGB(0xF6C1D8);
    UIColor *color3 = UIColorFromRGB(0xC0AFD1);
    UIColor *fcolor2 = UIColorFromRGB(0x6C8C27);
    UIColor *fcolor1 = UIColorFromRGB(0xDA557C);
    UIColor *fcolor3 = UIColorFromRGB(0x725A8A);
    UIColor *lineColor2 = UIColorFromRGB(0x8EAB51);
    UIColor *lineColor1 = UIColorFromRGB(0xE580A1);
    UIColor *lineColor3 = UIColorFromRGB(0x917CA6);
    UIColor *selectColor = UIColorFromRGB(0x000000);
    
    int height = 0;
    
    if (cateDataDic.count != 0)
    {
        if (vAry.count != 0)
        {
            for (UIView *v in vAry)
            {
                [v removeFromSuperview];
            }
        }
        for (int i = 0; i < ary.count; i++)
        {
            int g = 0;
            if ([[cateDataDic objectForKey:[ary objectAtIndex:i]] count]%(ISiPad?4:3)>0)
            {
                g = 1;
            }
            UIView *v = [[UIView alloc]initWithFrame:CGRectMake(10, 10+height, self.view.frame.size.width-20, 50+ [[cateDataDic objectForKey:[ary objectAtIndex:i]] count]/(ISiPad?4:3)*45 + g *45+20)];
            v.layer.cornerRadius = 5;
            v.layer.masksToBounds = YES;
            [self.scrollView addSubview:v];
            
            [vAry addObject:v];
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width-20, 1)];
            [v addSubview:lineView];
            
            //分类名
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(leftMar+(ISiPad?15:15), 0, cellWidth, 50)];
            lable.font = [UIFont fontWithName:Ifont size:(ISiPad?20:18)];
            lable.backgroundColor = [UIColor clearColor];
            lable.text = [ary objectAtIndex:i];
            [v addSubview:lable];
            
            if (i%(ISiPad?4:3) == 0)
            {
                v.backgroundColor = color1;
                lable.textColor = fcolor1;
                lineView.backgroundColor = lineColor1;
                
            }
            else if (i%(ISiPad?4:3) == 1)
            {
                v.backgroundColor = color2;
                lable.textColor = fcolor2;
                lineView.backgroundColor = lineColor2;
            }
            else
            {
                v.backgroundColor = color3;
                lable.textColor = fcolor3;
                lineView.backgroundColor = lineColor3;
            }
            
            
            NSArray *a = [[NSArray alloc]init];
            a = [cateDataDic objectForKey:[ary objectAtIndex:i]];
            for (int j = 0; j <a.count ; j++)
            {
                Category *cata = [a objectAtIndex:j];
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(leftMar+((j%(ISiPad?4:3))*cellWidth), 50+(int)(j/(ISiPad?4:3))*45, cellWidth, 50)];
                btn.tag = self.cateAry.count;
                [btn addTarget:self action:@selector(clickCateBtn:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTitle:cata.name forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont fontWithName:Ifont size:(ISiPad?18:16)];
                [btn setTitleColor:selectColor forState:UIControlStateHighlighted];
                [self.cateAry addObject:cata];
                
                UIView *lView = [[UIView alloc]initWithFrame:CGRectMake(btn.frame.size.width, 15, 1, 20)];
                if (i == 0)
                {
                    [btn setTitleColor:fcolor1 forState:UIControlStateNormal];
                    lView.backgroundColor = fcolor1;
                }
                else if ( i == 1)
                {
                    [btn setTitleColor:fcolor2 forState:UIControlStateNormal];
                    lView.backgroundColor = fcolor2;
                }
                else
                {
                    [btn setTitleColor:fcolor3 forState:UIControlStateNormal];
                    lView.backgroundColor = fcolor3;
                }
                if ((j+1)%(ISiPad?4:3)!=0)
                {
                    [btn addSubview:lView];
                }
                
                [v addSubview:btn];
            }
            
            height = v.frame.size.height + v.frame.origin.y;
            
        }
    }
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, height+10)];
}

-(void)clickCateBtn:(id)sender
{
    UIButton *b = (UIButton *)sender;
    cataLog = [self.cateAry objectAtIndex:b.tag];
    LMMoreViewController *moreContentView=[[LMMoreViewController alloc]init];
    
//    moreContentView.catalog = cataLog;
    [self.navigationController pushViewController:moreContentView animated:YES];
   
}

#pragma mark - scrollDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    location = scrollView.contentOffset;
}


@end
