//
//  LMPersonCenterVC.m
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMPersonCenterVC.h"
#import "MacroFunctions.h"
#import "FlipPageSetVC.h"

static NSString *kCellIdent = @"cellIdent";
@interface LMPersonCenterVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSArray *_lDataTB;
}
@end

@implementation LMPersonCenterVC


- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.title = @"我";
    [self _initializeData];
    [self _createSubviews];
}
#pragma mark -layout subviews
- (void)_createSubviews
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.tableFooterView = [UIView new];
    [self.view addSubview:_tableview];
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdent];
}
- (void)_initializeData
{
    _lDataTB = @[@"翻页模式"];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_tableview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
}
#pragma mark uitableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _lDataTB.count;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdent];
    cell.textLabel.text = _lDataTB[indexPath.row];
    return cell;
}

#pragma mark - uitableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    FlipPageSetVC *flipVC = [[FlipPageSetVC alloc]init];
    flipVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:flipVC animated:YES];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
{
    
}

@end
