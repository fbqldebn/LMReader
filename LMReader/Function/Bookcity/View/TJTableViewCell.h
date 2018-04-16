//
//  TJTableViewCell.h
//  bookcity
//
//  Created by Mac on 14-10-28.
//  Copyright (c) 2014年 309Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJTableViewCell : UITableViewCell

//@property (strong, nonatomic)IBOutlet UIImageView *cover;
//
//@property (unsafe_unretained, nonatomic) IBOutlet UILabel *name;
//@property (unsafe_unretained, nonatomic) IBOutlet UILabel *Introduction;
//
//@property (unsafe_unretained, nonatomic) IBOutlet UILabel *auther;

@property (retain, nonatomic) IBOutlet UIImageView *cover;
@property (retain, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UILabel *auther;
@property (retain, nonatomic) IBOutlet UILabel *Introduction;

@property (nonatomic, strong)NSString *bookId;
-(void)reloadCell1:(id)data index:(NSInteger)row;
@end
