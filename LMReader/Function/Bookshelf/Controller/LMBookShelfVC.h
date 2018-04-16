//
//  LMBookShelfVC.h
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMViewController.h"
#import "BookNormalCell.h"
#import "BookSelectedCell.h"
#import "LMOpenBookAnimtor.h"

@interface LMBookShelfVC : LMViewController  <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UIViewControllerTransitioningDelegate,BookCellDelegate,BookSelectCellDelegate>

@property(nonatomic,strong)UICollectionView *selectCollsctionView;
@property (strong, nonatomic)UICollectionView *collectionView;
@property (strong, nonatomic)NSIndexPath *selectedIndex;


@end
