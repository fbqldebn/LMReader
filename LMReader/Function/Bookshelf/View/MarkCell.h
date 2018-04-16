//
//  MarkCell.h
//  IREADER
//
//  Created by 无聊 on 13-5-16.
//  Copyright (c) 2013年 刘琴. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MarkCellDelegate <NSObject>

- (void)deleteMark:(int)index;

@end

@interface MarkCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic,strong)IBOutlet UILabel *titleLabel;
@property (nonatomic,strong)IBOutlet UILabel *contentLabel;
@property (retain, nonatomic) IBOutlet UILabel *pageLabel;
@property (nonatomic,assign)int index;
@property (nonatomic,strong)id<MarkCellDelegate>delegate;
- (IBAction)clickBtn:(id)sender;

-(void)updateCellWithInfo:(NSMutableArray *)markDict;

@end
