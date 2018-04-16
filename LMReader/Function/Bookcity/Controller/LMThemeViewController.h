//
//  LMThemeViewController.h
//  LMReader
//
//  Created by 许爱爱 on 16/6/16.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMViewController.h"
#import "BoutiqueThemeCell.h"
#import "YiRefreshHeader.h"
#import "HTTPRequest.h"
#import "LMPaser.h"
#import "Catalog.h"
#import "Connector.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
#import "LMMoreViewController.h"

@interface LMThemeViewController : LMViewController<UITableViewDelegate,UITableViewDataSource>

{
    NSMutableDictionary *cateDataDicB;
    NSMutableArray *cateDateAryB;
    NSMutableArray *topDataArr;
    NSMutableArray *searchAry;
    UIScrollView *topView;
    Catalog *catalogB;
    BOOL isBoutique;
    NSString *cataid;
    NSString *totalStr;
    float fontSize;
    YiRefreshHeader *refreshHeader;
}
@property (nonatomic, strong) NSURLSessionDataTask *request;

@property(nonatomic,strong)UITableView *tableView;
@end
