//
//  FlipPageSetVC.m
//  LMReader
//
//  Created by 于君 on 16/6/1.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "FlipPageSetVC.h"
static NSString *kCellIdent = @"cellIdent";

@interface FlipPageSetVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSArray *_lDataTB;
    NSIndexPath *lastIndex;
}


@end

@implementation FlipPageSetVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"翻页动画";
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
    _lDataTB = @[@"仿真翻页",@"左右滑动"];
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
    if ([indexPath compare:lastIndex]==NSOrderedSame) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - uitableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([indexPath compare:lastIndex]!=NSOrderedSame) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell = [tableView cellForRowAtIndexPath:lastIndex];
        cell.accessoryType = UITableViewCellAccessoryNone;
        lastIndex = indexPath;
        [LMGoble sharedGoble].pageTransition = indexPath.row;
    }
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
{
    
}
@end
