//
//  BoutiqueThemeCell.m
//  bookcity
//
//  Created by Mac on 13-11-15.
//  Copyright (c) 2013年 309Studio. All rights reserved.
//

#import "BoutiqueThemeCell.h"

@implementation BoutiqueThemeCell
@synthesize listiconImg;
@synthesize listlinkImg;
@synthesize contectLabel;
@synthesize backgView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        self.contectLabel.backgroundColor = UIColorFromRGB(0x1E1E1E);

    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//    CGContextFillRect(context, rect);
//    //上分割线
//    CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xC9C9C9).CGColor);CGContextStrokeRect(context, CGRectMake(0, 0, rect.size.width, 1));
//    //下分割线
//    CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xFFFFFF).CGColor); CGContextStrokeRect(context, CGRectMake(-1, rect.size.height, rect.size.width, 1));

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
   
}
@end
