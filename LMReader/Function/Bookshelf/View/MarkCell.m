//
//  MarkCell.m
//  IREADER
//
//  Created by 无聊 on 13-5-16.
//  Copyright (c) 2013年. All rights reserved.
//

#import "MarkCell.h"
@implementation MarkCell
@synthesize titleLabel;
@synthesize contentLabel;
@synthesize index;
@synthesize delegate;
@synthesize timeLabel;
@synthesize pageLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCellWithInfo:(NSMutableArray *)markDict
{
    UIColor *color = UIColorFromRGB(0x343043);
    self.backgroundColor = [UIColor clearColor];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:markDict];
    NSString *chapter = [dic objectForKey:@"chapter"];
    NSString *content = [dic objectForKey:@"content"];
    self.titleLabel.textColor = color;
    self.titleLabel.text = chapter;
    self.contentLabel.text = content;
    self.contentLabel.textColor = color;
    //        cell.timeLabel.text = [self compareCurrentTime:[dic objectForKey:@"time"]];
    self.timeLabel.textColor = color;
//    self.delegate = self;
//    self.index = indexPath.row;
    self.pageLabel.frame = CGRectMake(SCREEN_WIDTH-50, 15, 15, 15);
    self.titleLabel.frame = CGRectMake(30, 38, SCREEN_WIDTH-60, 21);
    self.contentLabel.frame = CGRectMake(30, 49, SCREEN_WIDTH-60, 48);
    self.pageLabel.text = [dic objectForKey:@"pageIndex"];
    self.pageLabel.textColor = color;
    [self setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_line.png"]]];
    UIView *v = [[UIView alloc]initWithFrame:self.frame];
    v.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView= v;

}
- (void)clickBtn:(id)sender
{
    [self.delegate deleteMark:index];
}
-                                             (void)dealloc {
   
}
@end
