//
//  LMTabbarButton.m
//  LMReader
//
//  Created by 许爱爱 on 16/6/16.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMTabbarButton.h"

@implementation LMTabbarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark 设置button内部的image的范围

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageW = 25;
    CGFloat imageH = 25;
    
    return CGRectMake((self.bounds.size.width-imageW)/2, 5, imageW, imageH);
    
}

#pragma mark 设置button内部的title的范围

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * 0.6;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(0, titleY, titleW, titleH);
    
}



@end
