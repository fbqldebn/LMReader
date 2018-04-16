//
//  LMJianView.m
//  LMReader
//
//  Created by 许爱爱 on 16/6/12.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMJianView.h"
#import <Masonry/Masonry.h>
#import "Consts.h"
#import "MyView.h"

@interface LMJianView()

{
    UIScrollView *backScrollView;
    
    UIImageView *coverImageView;
    UILabel *nameLabel;
    UILabel *autherLabel;
    MyView *desc;

}

@end

@implementation LMJianView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

-(void)createView
{
    backScrollView = [[UIScrollView alloc]init];
//    backScrollView.backgroundColor = [UIColor redColor];
    CGRect rx = CGRectMake(0, 80, SCREEN_WIDTH, SCREEN_HEIGHT-80);
    backScrollView.frame = rx;
    [self addSubview:backScrollView];
    
    coverImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 70, 105)];
    coverImageView.backgroundColor = [UIColor redColor];
    [backScrollView addSubview:coverImageView];

    

    UIFont *font=[UIFont fontWithName:_FONT size:ISiPad?18:16];
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(coverImageView.frame.size.width+coverImageView.frame.origin.x+10, coverImageView.frame.origin.y,200, 20)];
    nameLabel.text = @"啊啊啊啊";
    nameLabel.font = font;
    [backScrollView addSubview:nameLabel];
    
    autherLabel = [[UILabel alloc]initWithFrame:CGRectMake(coverImageView.frame.size.width+coverImageView.frame.origin.x+10, nameLabel.frame.origin.y+nameLabel.frame.size.height+5,200, 20)];
    autherLabel.text = @"作者大神";
    autherLabel.font = font;
    [backScrollView addSubview:autherLabel];
    

    
    CGSize textSize = [_conent sizeWithFont:[UIFont boldSystemFontOfSize:18] constrainedToSize:CGSizeMake(SCREEN_WIDTH-20, 1000) lineBreakMode:NSLineBreakByCharWrapping];
    desc=[[MyView alloc]initWithFrame:CGRectMake(10, 120 +(ISiPad?70:0) , SCREEN_WIDTH-20, textSize.height)];
    desc.content = self.conent;
    
    [backScrollView addSubview:desc];
    //    desc.frame =CGRectMake(10, 120 +(ISiPad?70:0) , SCREEN_WIDTH-20, desc.hightView);
    CGSize svSize=CGSizeMake(backScrollView.contentSize.width,desc.frame.size.height +(ISiPad?200:150));
    backScrollView.contentSize=svSize;

    
    
}

-(void)updateViewWithModel:(BookEntity *)book
{
    NSLog(@"刷新简介数据   %@",book.b_source);
    nameLabel.text = book.b_name;
    autherLabel.text= book.b_author;
    
}

@end
