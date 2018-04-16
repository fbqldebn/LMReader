//
//  BookView.m
//  LMReader
//
//  Created by 于君 on 16/5/27.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "BookView.h"

@implementation BookView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _cover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        
        [self addSubview:_cover];
        
    }
    return self;
}

- (void)setupBookCoverImage:(UIImage *)image
{
    _cover.layer.contents = (__bridge id)(image.CGImage);
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
@end
