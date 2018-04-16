//
//  LMPaser.h
//  LMReader
//
//  Created by 许爱爱 on 16/6/24.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
#import "Recommend.h"
#import "LMTitleModel.h"

@interface LMPaser : NSObject<NSXMLParserDelegate>

@property(nonatomic,strong)NSMutableArray *recommMutableArr;

-(NSMutableArray *)paserRecommend:(GDataXMLElement *)element;

@end
