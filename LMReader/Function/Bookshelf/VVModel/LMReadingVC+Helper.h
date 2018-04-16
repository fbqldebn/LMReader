//
//  LMReadingVC+Helper.h
//  LMReader
//
//  Created by 于君 on 16/5/30.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMReadingVC.h"

@interface LMReadingVC (Helper)<UIToolbarDelegate>


@property (strong, nonatomic)UIToolbar *topToolBar;

@property (strong, nonatomic)UIToolbar *bottomToolBar;
- (void)addNavBar;
- (void)addBottomToolBar;
-(void)addFontSizeView;
-(void)addLigntnessChangeView;

- (void)tapShowHideToolBar;
- (void)panHideToolBar;
@end
