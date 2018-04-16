//
//  LMViewController.h
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMBaseAnimtor.h"
#import <Masonry/Masonry.h>

typedef enum {
    UIModalTransitionStyleOpenBooks = 0x01 << 5,
    
} UIModalTransitionStyleCustom;

@interface LMViewController : UIViewController<UIGestureRecognizerDelegate>

-(void)leftButtonClick:(id)action;
-(void)rightButtonClick:(id)action;
-(void)createLeftButtonWithString:(NSString *)leftTitle;
-(void)createRightButtonWithString:(NSString *)rightTitle;

@end
