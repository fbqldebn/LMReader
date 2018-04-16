//
//  LMJianView.h
//  LMReader
//
//  Created by 许爱爱 on 16/6/12.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookEntity.h"

@interface LMJianView : UIView

@property(nonatomic, strong)NSString *conent;

-(void)updateViewWithModel:(BookEntity *)book;
@end
