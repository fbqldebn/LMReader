//
//  LMThemeViewController.m
//  LMReader
//
//  Created by 许爱爱 on 16/6/16.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMThemeViewController.h"

@implementation LMThemeViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"精品主题";
    
    fontSize = ISiPad?19:16;
    //    [self createNavViewB];
    cateDataDicB = [[NSMutableDictionary alloc]init];
    cateDateAryB = [[NSMutableArray alloc]init];
    topDataArr = [[NSMutableArray alloc ]init];
    isBoutique = YES;
    //    CatalogList *catalogList= [CatalogList shareCatalogList];
    //    if (isBoutique == YES)
    //    {
    //        NSString *urlString=[[NSString alloc]initWithFormat:@"%@%@",commonUrl,@"librarylist.action"];
    //        RequestMsg *msg=[[RequestMsg alloc]init:TYPE_BOOKCITY];
    //        msg.reqString=urlString;
    //        [msg addParams:@"cat" value:@"novel"];
    //        [msg sendMsg:self];
    //        isBoutique = NO;
    //    }
    __block LMThemeViewController *weakself = self;
    refreshHeader =[[YiRefreshHeader alloc] init];
    
    refreshHeader.scrollView=self.tableView;
    [refreshHeader header];
    refreshHeader.beginRefreshingBlock = ^(){
        [weakself requestCategoryTheme:YES];
    };
    [refreshHeader beginRefreshing];
    topView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ISiPad?160:85)];
    topView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    self.tableView.tableHeaderView = topView;
    self.tableView.tableFooterView = [[UIView alloc]init];
    //iOS7 tableview的分割线短一截（这个方法使分割线不短）
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }

}

-(void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)requestCategoryTheme:(BOOL)load
{
    if (!cateDateAryB.count) {
//        [self showLoadingViewWithStatus:LMLoadingStatusStart message:nil];
    }
    NSString *requestString = [NSString stringWithFormat:@"%@librarylist.action",COMMENURL];
    self.request = [HTTPRequest getRequestDocumentWithUrl:requestString params:@{@"cat":@"novel"} success:^(GDataXMLDocument *responseDict) {
        NSLog(@"成功");
        {
            [refreshHeader endRefreshing];
            [self refreshViewWithXMLData:responseDict];
            //            LMPaser *paser = [[LMPaser alloc]init];
            //            self.myArray = [paser paserRecommend:responseDict];
            //            NSLog(@"self.myArray.count  ====    %d",self.myArray.count);
            //            [self.myTableView reloadData];
            //                [self initUI];
        }

    } fail:^(NSString *errorMsg) {
        NSLog(@"失败");
        [refreshHeader endRefreshing];
    }];
      
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GETGDataXML:[[NSString alloc]initWithFormat:@"%@%@",commonUrl,@"librarylist.action"] parameters:@{@"cat":@"novel"} success:^(NSURLRequest *request, NSHTTPURLResponse *response, GDataXMLDocument *XMLDocument) {
//        
//        
//        if (XMLDocument) {
//            [self showLoadingViewWithStatus:LMLoadingStatusSuccess message:nil];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                
//            });
//            
//        }
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, GDataXMLDocument *XMLDocument) {
//        
//        
//        [self showLoadingViewWithStatus:LMLoadingStatusFailure message:nil];
//    }];
}

- (void)refreshViewWithXMLData:(GDataXMLDocument*)XMLDocument
{
    [cateDateAryB removeAllObjects];
    [topDataArr removeAllObjects];
    NSError *error;
    GDataXMLElement *rootElement = [XMLDocument rootElement];
    NSArray * categaryList = [rootElement nodesForXPath:@"cat" error:&error];
    NSLog(@"categaryList.count  ==  %@",XMLDocument);
    for (GDataXMLElement *categoryElement in categaryList)
    {
        NSArray * itemlist = [categoryElement nodesForXPath:@"subcat" error:&error];
        for (GDataXMLElement *item in itemlist)
        {
            Catalog *category = [[Catalog alloc]init];
            category.cid = [item attributeForName:@"id"].stringValue;//解析属性
            category.name = [item attributeForName:@"name"].stringValue;//解析属性
            category.focus = [item attributeForName:@"focuson_num"].stringValue;//解析属性
            category.coverId = [item attributeForName:@"coverid"].stringValue;//解析属性
            category.cover_update = [[item attributeForName:@"cover_update"].stringValue boolValue];//解析属性
            category.topspot = [[item attributeForName:@"topspot"].stringValue boolValue];
            NSLog(@"[item attributeForName:name].stringValue  ===  %@",[item attributeForName:@"name"].stringValue);
            if (category.topspot) {
                [topDataArr addObject:category];;
            }else
                [cateDateAryB addObject:category];
            category = nil;
            //            if (propertyNameNode.stringValue) {
            //                [cateDateAryB addObject:propertyNameNode.stringValue];
            //            }
        }
        
    }
    [self setRecommended:topDataArr];
    [self.tableView reloadData];
}

//推荐位
-(void)setRecommended:(NSArray *)arr
{
    topDataArr = [[NSMutableArray alloc ]initWithArray:arr];
    
    float imageWidth = (SCREEN_WIDTH-10*arr.count-10)/arr.count;
    for (int i = 0; i < arr.count; i++)
    {
        UIImageView *rImg = [[UIImageView alloc]initWithFrame:CGRectMake(10+i*(imageWidth+10), 10, imageWidth,ISiPad?140:65)];
        rImg.layer.masksToBounds = YES;
        rImg.layer.cornerRadius = 4.0;
        rImg.userInteractionEnabled=YES;
        Connector *con = [[Connector alloc]init];
        Catalog *list = [arr objectAtIndex:i];
        NSString *urlStr = [NSString stringWithFormat:@"%@&id=%@&picsize=small&topspot=1",[con getUrl:8 url:COMMENURL],list.cid];
        NSString *URLString =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [[NSURL alloc]initWithString:URLString];
        
        if (list.cover_update)
        {
            SDImageCache *imgCache = [SDImageCache sharedImageCache];
            [imgCache removeImageForKey:[url absoluteString]];
        }
        
//        [rImg setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ad_defaut"]];
        
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
        [rImg addGestureRecognizer:singleTap];
        singleTap.view.tag = i;
        [topView addSubview:rImg];
    }
    CGRect rx = [ UIScreen mainScreen ].applicationFrame;
    self.tableView.frame = CGRectMake(0, 40, SCREEN_WIDTH, rx.size.height-90);
}

-(void)onClickImage:(id)sender
{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    catalogB = [topDataArr objectAtIndex:tap.view.tag];
    [self performSelectorOnMainThread:@selector(pushView) withObject:nil waitUntilDone:YES];
}

-(void)pushView
{
    LMMoreViewController *moreContentView = [[LMMoreViewController alloc]init];
//    if (ISiPad) {
//        moreContentView=[[LMMoreViewController alloc]initWithNibName:@"MoreContentViewController_iPad" bundle:nil];
//    }
//    else
//    {
//        moreContentView=[[LMMoreViewController alloc]initWithNibName:@"MoreContentViewController" bundle:nil];
//    }
    //    moreContentView.searchResults = searchAry;
//    moreContentView.catalog = catalogB;
//    moreContentView.totalpageStr = totalStr;
    [self.navigationController pushViewController:moreContentView animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (ISiPad?100:77);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cateDateAryB.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BoutiqueThemeCell *cell = nil;
    cell = [self.tableView dequeueReusableCellWithIdentifier:@"bIdentifier"];
    if (!cell)
    {
        if (ISiPad) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"BoutiqueThemeCell_iPad" owner:self options:nil] objectAtIndex:0];
        }else
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"BoutiqueThemeCell" owner:self options:nil] objectAtIndex:0];
        }
        
    }
    Catalog *c = [cateDateAryB objectAtIndex: indexPath.row];
    cell.contectLabel.text = c.name;
    cell.contectLabel.font = [UIFont fontWithName:Ifont size:ISiPad?18: 16];
    cell.contectLabel.textColor = UIColorFromRGB(0x414040);
    cell.subTitleLB.text = [NSString stringWithFormat:@"%@人 在追",c.focus];
    cell.subTitleLB.font  = [UIFont fontWithName:Ifont size:ISiPad?14: 12];
    cell.subTitleLB.textColor = UIColorFromRGB(0x666666);
    Connector *con = [[Connector alloc]init];
    NSString *urlStr = [NSString stringWithFormat:@"%@&id=%@&picsize=small",[con getUrl:8 url:COMMENURL],c.coverId];
    NSString *URLString =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [[NSURL alloc]initWithString:URLString];
    if (c.cover_update)
    {
        SDImageCache *imgCache = [SDImageCache sharedImageCache];
        [imgCache removeImageForKey:[url absoluteString]];
    }
    [cell.listiconImg setImageWithURL:url];
    //    if (indexPath.row%2 == 0)
    //    {
    //        cell.backgView.backgroundColor = UIColorFromRGB(0xFFFFFF);
    //    }
    //    else
    //    {
    //        cell.backgView.backgroundColor = UIColorFromRGB(0xEBEBEB);
    //    }
    //    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xEBEBEB);
    //    cell.selectedBackgroundView.alpha = 0.3;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    searchAry = [[NSMutableArray alloc]init];
    catalogB = [cateDateAryB objectAtIndex: indexPath.row];
    [self performSelectorOnMainThread:@selector(pushView) withObject:nil waitUntilDone:YES];
    //    NSString *urlString=[[NSString alloc]initWithFormat:@"%@/nokiareader/%@",_SERVER_HOST,@"search.action"];
    //    [RequestMsg showWaitingIndicator:self.view];
    //    RequestMsg *msg=[[RequestMsg alloc]init:TYPE_SEARCH];
    //    msg.reqString=urlString;
    //    [msg addParams:@"pageidx" value:@"1"];
    //    [msg addParams:@"numperpage" value:@"10"];
    //    [msg addParams:@"catid" value:catalogB.cid];
    //    [msg addParams:@"cat" value:@"novel"];
    //    [msg sendMsg:self];
}

@end
