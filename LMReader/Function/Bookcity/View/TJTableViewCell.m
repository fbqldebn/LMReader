//
//  TJTableViewCell.m
//  bookcity
//
//  Created by Mac on 14-10-28.
//  Copyright (c) 2014年 309Studio. All rights reserved.
//
#import "TJTableViewCell.h"
#import "recommend.h"
#import "Connector.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"

@implementation TJTableViewCell
-(void)reloadCell1:(id)data index:(NSInteger)row
{
    
    self.backgroundColor = [UIColor clearColor];
    NSMutableArray *ary = [[NSMutableArray alloc]init];
    ary = data;
    Recommend *list = [ary objectAtIndex:row];
    self.name.text =list.bookName;
    self.name.font = [UIFont fontWithName:Ifont size:[[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad?17:16];
    self.name.textColor = UIColorFromRGB(0x414040);
    self.Introduction.text = [list.introduction stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.Introduction.font = [UIFont fontWithName:Ifont size:ISiPad?14:12];
    self.Introduction.textColor = UIColorFromRGB(0x666666);
    self.auther.text = list.author;
    self.auther.font = [UIFont fontWithName:Ifont size:ISiPad?14:12];
    self.auther.textColor = UIColorFromRGB(0x666666);
    self.bookId = list.bookID;
    Connector *con = [[Connector alloc]init];
    NSString *urlStr = [NSString stringWithFormat:@"%@&id=%@&picsize=small",[con getUrl:8 url:nil],list.bookID];
    NSString *URLString =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [[NSURL alloc]initWithString:URLString];
    
    if ([list.coverUpdata isEqualToString:@"true" ])
    {
        SDImageCache *imgCache = [SDImageCache sharedImageCache];
        [imgCache removeImageForKey:[url absoluteString]];
    }
    [self.cover setImageWithURL:url];
    
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)dealloc {
    
}
@end
