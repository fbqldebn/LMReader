//
//  MyView.m
//  bookcity
//
//  Created by Mac on 13-11-6.
//  Copyright (c) 2013年 309Studio. All rights reserved.
//

#import "MyView.h"
#import "Chapter.h"
//#import "Line.h"

#import <QuartzCore/QuartzCore.h>
@implementation MyView
@synthesize content;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //        UIColor *color = [UIColor colorWithRed:0xC1/255 green:0xC1/255 blue:0xC1/255 alpha:1.0];
        //        self.layer.borderColor = color.CGColor;
        //        //        self.layer.borderWidth = 0.1f;
        //        self.layer.cornerRadius = 5.0;
        //        self.layer.shadowColor = [UIColor blackColor].CGColor;
        //        self.layer.shadowOpacity = 0.4;
        //        self.layer.shadowRadius = 3.0;
        //        self.layer.shadowOffset = CGSizeMake(0, 0);
        //        self.clipsToBounds = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置画笔线条粗细
    CGContextSetLineWidth(context, 1.0);
    
    CGContextSetRGBFillColor (context, 85.0f/255.0f, 85.0f/255.0f, 85.0f/255.0f, 1.0);
    CGPoint pt;
    UIFont *font = [UIFont fontWithName:Ifont size:15];
    pt=CGPointMake(15,10);
    
    //绘制正文
    pt.x=15;
    pt.y=10;
    float lineHeght=17;
    float lineSpace=lineHeght/2;
    
    Chapter *chapter=[[Chapter alloc]init];
//    NSArray *titleLines= [chapter wrapLine:content lineWidth:self.frame.size.width-30 font:font fontSize:font.pointSize];
//    for (int i = 0; i<titleLines.count; i++)
//    {
////        Line *line=[titleLines objectAtIndex:i];
////        [line.text drawAtPoint:pt withFont:font];
//        pt.y+=lineHeght;
//        pt.y+=lineSpace;
//    }
//    _hightView = pt.y;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
