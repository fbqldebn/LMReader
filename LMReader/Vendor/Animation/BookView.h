//
//  BookView.h
//  LMReader
//
//  Created by 于君 on 16/5/27.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookView : UIView
@property (nonatomic) UIView *cover;
@property (nonatomic) UIView *content;

- (void)setupBookCoverImage:(UIImage *)image;
@end
