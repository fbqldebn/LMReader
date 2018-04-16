//
//  LMClassViewController.h
//  LMReader
//
//  Created by 许爱爱 on 16/6/16.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMViewController.h"
#import "HTTPRequest.h"
#import "Catalog.h"
#import "Category.h"
#import "CatalogList.h"
#import "LMMoreViewController.h"

@protocol classViewControllerDelegate <NSObject>

-(void)backViewC;
-(void)moreContentView:(Catalog *)data;

@end


@interface LMClassViewController : LMViewController<UITableViewDataSource,UITableViewDelegate,classViewControllerDelegate,NSXMLParserDelegate,UIScrollViewDelegate>

{
    NSMutableDictionary *cateDic;
    NSMutableDictionary *catalogInterfaceDict;
    NSMutableDictionary *cateDataDic;//存放类的类别
    int cateInt;
    BOOL isB;
    NSMutableArray *searchResults;
    Catalog *cataLog;
    CatalogList *catalogList;
    NSArray *ary;
    CGPoint  location;
    NSMutableArray *vAry;
    NSString *totalStr;
    float cellWidth;
    NSMutableArray *categoryArray;
    NSString *categoryName;

}

@property (nonatomic, strong) NSURLSessionDataTask *request;
@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *cateAry;
@property (nonatomic, strong) id<classViewControllerDelegate>deledate;

@end
