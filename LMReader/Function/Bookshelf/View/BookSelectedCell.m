//
//  BookSelectedCell.m
//  LMReader
//
//  Created by 于君 on 16/5/26.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "BookSelectedCell.h"
#import <Masonry/Masonry.h>
#import "BookEntity.h"

@interface BookSelectedCell()

{
    CGPoint beginCenter;
}

@end

@implementation BookSelectedCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _layoutSubview];
        //        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

-(void)updateSelect
{
    _isSelect = NO;
}

- (void)_layoutSubview
{
    _backImageV = [[UIImageView alloc]init];
    _backImageV.image = [UIImage imageNamed:@"pic_bg.png"];
    _coverImageV = [[UIImageView alloc]init];
    _bookNameLB = [[UILabel alloc]init];
    _bookNameLB.textAlignment = NSTextAlignmentCenter;
    _selectImageView = [[UIImageView alloc]init];
    [_selectImageView setImage:[UIImage imageNamed:@"delete_uncheck"]];
    
    
    [self.contentView addSubview:_backImageV];
    [_backImageV addSubview:_coverImageV];
    [self.contentView addSubview:_bookNameLB];
    
    [_backImageV addSubview:_selectImageView];
    [self _updateConstraint];
    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureAction:)];
//    [self addGestureRecognizer:pan];
}
- (void)_updateConstraint
{
    [_backImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 25, 0));
    }];
    [_coverImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_backImageV).with.insets(UIEdgeInsetsMake(6, 8, 8, 8));
    }];
    [_bookNameLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
        make.left.right.equalTo(self);
    }];
    
    [_selectImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backImageV.mas_right).offset(5);
        make.top.equalTo(_backImageV.mas_top).offset(-3);
        make.width.offset(24);
        make.height.offset(24);
    }];

}

-(void)panGestureAction:(UIPanGestureRecognizer *)gesture
{
        if (gesture.state==UIGestureRecognizerStateChanged) {
            self.center =[gesture locationInView:self.superview];
        }else if (gesture.state == UIGestureRecognizerStateBegan)
        {
            [self.superview bringSubviewToFront:self];
            beginPoint = [gesture locationInView:self.superview];
            beginCenter = self.center;
            self.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }else if (gesture.state == UIGestureRecognizerStateEnded)
        {
            self.transform = CGAffineTransformIdentity;
            UICollectionView *collectV = (UICollectionView*)self.superview;
            if ([collectV indexPathForItemAtPoint:beginPoint]==[collectV indexPathForItemAtPoint:[gesture locationInView:self.superview]]) {
                self.center = beginCenter;
                return;
            }
            [self.delegate bookCellMoveBeginPoint:beginPoint andEndPoint:[gesture locationInView:self.superview]];
            
        }

}

-(void)selectCellWithTag:(NSInteger)tag
{
    if (tag == 1) {
        if (_isSelect==YES) {
            NSLog(@"选中＝＝》取消选中");
            [_selectImageView setImage:[UIImage imageNamed:@"delete_uncheck"]];
            _isSelect = NO;
        }else
        {
            NSLog(@"未选中＝＝》选中");
            [_selectImageView setImage:[UIImage imageNamed:@"delete_check"]];
            _isSelect = YES;
        }

    }else
    {
        [_selectImageView setImage:[UIImage imageNamed:@"delete_uncheck"]];
        _isSelect = NO;
    }
    //    _isSelect = !_isSelect;
}


- (void)configNormalCell:(id)model;
{
    BookEntity *entity = model;
    _bookNameLB.text = entity.b_name;
    _coverImageV.image = [UIImage imageNamed:entity.b_id];

}
@end
