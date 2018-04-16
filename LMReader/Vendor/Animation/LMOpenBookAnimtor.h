//
//  LMOpenBookAnimtor.h
//  LMReader
//
//  Created by 于君 on 16/5/24.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMBaseAnimtor.h"
#import "BookNormalCell.h"

@interface LMOpenBookAnimtor : LMBaseAnimtor
{
    UIImageView *tmpImageView;
}

@property (strong, nonatomic)BookNormalCell *animatedView;
@end
