//
//  BookNormalCell.m
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "BookNormalCell.h"
#import <Masonry/Masonry.h>
#import "BookEntity.h"

@interface BookNormalCell()
{
    CGPoint beginCenter;
    BOOL isSelected;
}
@end

@implementation BookNormalCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _layoutSubview];
//        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)_layoutSubview
{
    _backImageV = [[UIImageView alloc]init];
    _backImageV.image = [UIImage imageNamed:@"pic_bg.png"];
    _coverImageV = [[UIImageView alloc]init];
    _bookNameLB = [[UILabel alloc]init];
    _bookNameLB.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_backImageV];
    [_backImageV addSubview:_coverImageV];
    [self addSubview:_bookNameLB];
    [self _updateConstraint];
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
}

- (void)configNormalCell:(id)model;
{
    BookEntity *entity = model;
    _bookNameLB.text = entity.b_name;
    _coverImageV.image = [UIImage imageNamed:entity.b_id];
}
- (void)longPressGestureAction:(UILongPressGestureRecognizer *)gesture
{
    NSLog(@"长按书本进入编辑模式");
    [self setSelected:isSelected ? NO : YES];
    
}

- (void)setSelected:(BOOL)selected {
    isSelected = selected;
    if (isSelected) {
//        [_checkedImageView setHidden:NO];
//        [isSelected setHidden:NO];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    else {
//        [_checkedImageView setHidden:YES];
//        [isSelected setHidden:YES];
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
