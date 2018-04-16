//
//  LMBookShelfVC.m
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMBookShelfVC.h"
#import "MacroFunctions.h"
#import "LMReadingVC.h"
#import "BookEntity.h"


@interface LMBookShelfVC ()
{
    UICollectionView *_collectionView;
    UICollectionView *_selectCollsctionView;
    NSMutableArray *_lBooks;
    LMOpenBookAnimtor *transition ;
    NSMutableArray *selectArray;
}
@end

@implementation LMBookShelfVC

static NSString * const reuseIdentifier = @"CellNormal";
static NSString * const selectReuseIdentifier = @"CellSelect";

- (void)loadView
{
    [super loadView];
    self.view = [[UIView alloc]initWithFrame:SCREEN_BOUNDS];
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc]initWithFrame:SCREEN_BOUNDS collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.tag = 100;
    [self.view addSubview:_collectionView];
    
    _selectCollsctionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 44+20, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    _selectCollsctionView.backgroundColor = [UIColor whiteColor];
    _selectCollsctionView.dataSource = self;
    _selectCollsctionView.delegate = self;
    _selectCollsctionView.tag = 200;
    [self.view addSubview:_selectCollsctionView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    selectArray = [NSMutableArray array];
    _lBooks = [NSMutableArray arrayWithArray:[[DatebaseManage sharedDatebase]fetchBooks]];
    BookEntity *book  =_lBooks[1];
    NSLog(@"_lBooks[b_summary]  ===    %@",book.b_summary);
     NSLog(@"_lBooks[b_id]  ===    %@",book.b_id);
     NSLog(@"_lBooks[b_category_name]  ===    %@",book.b_category_name);
     NSLog(@"_lBooks[b_author]  ===    %@",book.b_author);
     NSLog(@"_lBooks[b_name]  ===    %@",book.b_name);
     NSLog(@"_lBooks[b_source]  ===    %@",book.b_source);
    [self createNavi];

    // Register cell classes
    [_collectionView registerClass:[BookNormalCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [_selectCollsctionView registerClass:[BookSelectedCell class] forCellWithReuseIdentifier:selectReuseIdentifier];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.delegate = self;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [_collectionView addGestureRecognizer:longPress];
    // Do any additional setup after loading the view.
}

-(void)longPress:(UILongPressGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan) {
        [self createSelectNavi];
    }
}

-(void)leftButtonClick:(id)action
{
    if ([self.title isEqualToString:@"整理书架"]) {
        [self createNavi];
    }
}

-(void)rightButtonClick:(id)action
{
     if ([self.title isEqualToString:@"整理书架"])
     {
         if (selectArray.count>0) {
             for (int i = 0; i<selectArray.count; i++) {
                 NSIndexPath *indexPath = selectArray[i];
                 if (indexPath.row>=i) {
                     [_lBooks removeObjectAtIndex:indexPath.row-i];
                 }else
                 {
                      [_lBooks removeObjectAtIndex:0];
                 }
                 
                 
             }
             [selectArray removeAllObjects];
             [_selectCollsctionView reloadData];
             [_collectionView reloadData];
         }
         [self createNavi];
     }
    
}

-(void)createNavi
{
     self.title = @"我的书架";
    [self createLeftButtonWithString:nil];
    [self createRightButtonWithString:nil];
    _collectionView.hidden = NO;
    _selectCollsctionView.hidden = YES;
}

-(void)createSelectNavi
{
    self.title = @"整理书架";
    [self createLeftButtonWithString:@"取消"];
    [self createRightButtonWithString:@"删除"];
    _collectionView.hidden = YES;
    _selectCollsctionView.hidden = NO;
    [_selectCollsctionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -gesture delegate
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    if (touch.view != self.collectionView) {
//        return NO;
//    }
//    
//    return YES;
//}
#pragma mark <UICollectionViewDataSource>
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_lBooks count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 100) {
        BookNormalCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        [cell.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.delegate = self;
        }];
        [cell configNormalCell:[_lBooks objectAtIndex:indexPath.row]];
        //    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
        return cell;

    }else
    {
        BookSelectedCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:selectReuseIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        [cell selectCellWithTag:2];
//        cell.backgroundColor = [UIColor redColor];
        [cell.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.delegate = self;
        }];
        [cell configNormalCell:[_lBooks objectAtIndex:indexPath.row]];
        
        //    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
        return cell;

    }
    
    // Configure the cell

}


#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(96, 150);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (collectionView.tag == 100) {
        self.selectedIndex = indexPath;
        BookEntity *selectBook = [_lBooks objectAtIndex:indexPath.row];
        
        LMReadingVC *readingVC = [[LMReadingVC alloc]init];
        UINavigationController *readNav =[[UINavigationController alloc] initWithRootViewController:readingVC];
        readingVC.currentBook = selectBook;
        NSLog(@"selectBook.b_name  =  %@",selectBook.b_author);
        readNav.transitioningDelegate = self;
        readNav.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:readNav animated:YES completion:^{
            [_lBooks removeObject:selectBook];
            [_lBooks insertObject:selectBook atIndex:0];
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
            [_collectionView reloadData];
        }];
        
        //    readingVC.hidesBottomBarWhenPushed = YES;
        
        //    [self.navigationController pushViewController:readingVC animated:YES];
        return;

    }else
    {
        BookSelectedCell *cell = (BookSelectedCell * )[collectionView cellForItemAtIndexPath:indexPath];
        if ([selectArray containsObject:indexPath]) {
            [selectArray removeObject:indexPath];
        }else
        {
            [selectArray addObject:indexPath];
        }
        [cell selectCellWithTag:1];
//        [cell reloadInputViews];
    }
}

// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}



// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}



// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return YES;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
#pragma mark - 动画代理
#pragma mark - 定制转场动画 (Present 与 Dismiss动画代理)
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    
    // 推出控制器的动画
    BookNormalCell *cell = (BookNormalCell*)[_collectionView cellForItemAtIndexPath:self.selectedIndex];
    if (!transition) {
        transition = [[LMOpenBookAnimtor alloc] init];
    }
    transition.transitiontype = ControllerTransitionTypePresent;
    transition.animatedView = cell;
    // 退出控制器动画
    return transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    // 推出控制器的动画
    BookNormalCell *cell = (BookNormalCell*)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0 ]];
    if (!transition) {
        transition = [[LMOpenBookAnimtor alloc] init];
    }
    transition.transitiontype = ControllerTransitionTypeDismiss;
    transition.animatedView = cell;
    // 退出控制器动画
    return transition;
}


#pragma mark - book cell delegate
- (void)bookCellMoveBeginPoint:(CGPoint )beginP andEndPoint:(CGPoint)endP;
{
    [self.selectCollsctionView moveItemAtIndexPath:[self.selectCollsctionView indexPathForItemAtPoint:beginP] toIndexPath:[self.selectCollsctionView indexPathForItemAtPoint:endP]];
    NSLog(@"endP.x = %f,   endP.y = %f",endP.x,endP.y);
    
    NSInteger begin =[self.selectCollsctionView indexPathForItemAtPoint:beginP].row;
    NSInteger end = [self.selectCollsctionView indexPathForItemAtPoint:endP].row;
    NSLog(@"结束  %ld",(long)end);
    BookEntity *book = [_lBooks objectAtIndex:begin];
    [_lBooks insertObject:book atIndex:end+1];
    [_lBooks removeObjectAtIndex:begin];
    [_collectionView reloadData];
//    [_selectCollsctionView reloadData];
    
}
@end
