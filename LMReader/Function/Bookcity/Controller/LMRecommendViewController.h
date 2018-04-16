//
//  LMRecommendViewController.h
//  LMReader
//
//  Created by 许爱爱 on 16/6/16.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMViewController.h"
#import "YiRefreshHeader.h"
#import "YiRefreshFooter.h"
#import "TJTableViewCell.h"
#import "Recommend.h"
#import "LMPaser.h"
#import "EGORefreshTableHeaderView.h"

#define CellHeight (ISiPad?120:77)

@interface LMRecommendViewController : LMViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger totalItemA;
    NSInteger totalItemB;
    NSInteger totalItemC;
    BOOL _reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;

}
@property (nonatomic, strong) NSURLSessionDataTask *request;

@property(nonatomic, strong)UIScrollView *chnalSV;
@property (strong, nonatomic) UIView *titleView;
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)UITableView *boyTableView;
@property(nonatomic,strong)UITableView *girlTableView;

@property (strong, nonatomic)UIView *selectLine;
@property (strong, nonatomic)UIButton *titalBtn;

@property (nonatomic,strong)NSMutableArray *myArray;
@property (nonatomic,strong)NSMutableArray *boyArray;
@property (nonatomic,strong)NSMutableArray *girlArray;

@property (nonatomic, strong)NSMutableDictionary *dic;
@property (nonatomic, strong)NSMutableArray * cid;

@end
