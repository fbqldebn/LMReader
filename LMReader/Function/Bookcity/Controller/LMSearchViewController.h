//
//  LMSearchViewController.h
//  LMReader
//
//  Created by 许爱爱 on 16/6/16.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "Connector.h"
#import "LMViewController.h"
#import "MBProgressHUD.h"
#import "HTTPRequest.h"

@interface LMSearchViewController : LMViewController<UISearchBarDelegate,MBProgressHUDDelegate,NSXMLParserDelegate>

{
    NSString *count;
    int changeId;
    NSMutableArray *btnAry;
    NSString *keywordStr;
    NSMutableArray *resultsAry;//搜索界面数组
    NSString *pageIndex;
    NSString *totalitem;
    NSString *bookId;//具体某本书的id
    NSMutableArray *requestAry;//存放请求的数组
    MBProgressHUD *loadingView;
    UIView *bgView;//半透明层
    UIImageView *guideImgView;//引导页
    NSMutableArray *searchData;
    NSString *searchCount;
    NSString * searchPage;
    NSString *searchMessage;
    NSMutableString *currentParsedCharacterData;
    
    UIView *backView;
    UITapGestureRecognizer *tapGesture;
    BOOL currentNetworkStaus;

}

@property (nonatomic, strong) NSURLSessionDataTask *request;
@property (strong, nonatomic) NSMutableArray *sDataAry;
@property(nonatomic,strong)UISearchBar *searchB;

@end
