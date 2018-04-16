//
//  BookNormalCell.h
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BookCellDelegate <NSObject>



@end

@interface BookNormalCell : UICollectionViewCell
{
    UIImageView *_backImageV;
    UIImageView *_coverImageV;
    UILabel *_bookNameLB;
    CGPoint beginPoint;
}

@property (strong, nonatomic)UIImageView *coverImageV;
@property (strong, nonatomic)UIView *content;
@property (assign, nonatomic)id <BookCellDelegate>delegate;
- (void)configNormalCell:(id)model;
@end
