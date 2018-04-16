//
//  BoutiqueThemeCell.h
//  bookcity
//
//  Created by Mac on 13-11-15.
//  Copyright (c) 2013年 309Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoutiqueThemeCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *listiconImg;
@property (retain, nonatomic) IBOutlet UIImageView *listlinkImg;
@property (retain, nonatomic) IBOutlet UILabel *contectLabel;
@property (strong, nonatomic) IBOutlet UILabel *subTitleLB;
@property(nonatomic, strong)IBOutlet UIView *backgView;
@end
