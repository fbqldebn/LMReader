//
//  BookSelectedCell.h
//  LMReader
//
//  Created by 于君 on 16/5/26.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BookSelectCellDelegate <NSObject>

@optional
- (void)bookCellMoveBeginPoint:(CGPoint )beginP andEndPoint:(CGPoint)endP;

@end

@interface BookSelectedCell : UICollectionViewCell
{
    UIImageView *_backImageV;
    UIImageView *_coverImageV;
    UILabel *_bookNameLB;
    UIImageView *_selectImageView;
    BOOL _isSelect;
    CGPoint beginPoint;
}

@property (strong, nonatomic)UIImageView *coverImageV;
@property(assign,nonatomic)id<BookSelectCellDelegate>delegate;

- (void)configNormalCell:(id)model;
-(void)selectCellWithTag:(NSInteger)tag;

@end
