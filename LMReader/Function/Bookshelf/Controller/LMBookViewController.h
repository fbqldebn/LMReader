//
//  LMBookViewController.h
//  LMReader
//
//  Created by 许爱爱 on 16/6/12.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMViewController.h"
#import "PageModelControll.h"
#import "DTAttStringManage.h"
#import "BookEntity.h"
#import "LMReadingVC.h"

@interface LMBookViewController : LMViewController

@property(nonatomic)int bgColorInt;
@property(nonatomic,strong)PageModelControll *pageModelControl;
@property(nonatomic,strong)BookEntity *currentBook;
@property (nonatomic, strong) NSMutableArray *markAry;

@end
