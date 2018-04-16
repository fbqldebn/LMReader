//
//  AdViewNativeAdInfo.h
//  AdViewDevelop
//
//  Created by maming on 15/12/25.
//  Copyright © 2015年 maming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//物料标题
extern NSString *const AdViewNativeAdTitle;
//物料图标地址
extern NSString *const AdViewNativeAdIconUrl;
//物料图标宽度
extern NSString *const AdViewNativeAdIconWidth;
//物料图标高度
extern NSString *const AdViewNativeAdIconHeight;
//物料详情
extern NSString *const AdViewNativeAdDesc;
//物料图片地址
extern NSString *const AdViewNativeAdImageUrl;
//物料图片宽度
extern NSString *const AdViewNativeAdImageWidth;
//物料图片高度
extern NSString *const AdViewNativeAdImageHeight;
//物料图片点击地址（不为空时,需开发者处理）
extern NSString *const AdViewNativeAdLinkUrl;
//内置AppStoreID
extern NSString *const AdViewNativeAdAPPStoreitid;
//点击类型  详见集成说明文档
extern NSString *const AdViewNativeAdLinkType;
//物料评分
extern NSString *const AdViewNativeAdRating;
//物料来源
extern NSString *const AdViewNativeAdPName;


extern NSString *const AdViewNativeAdPdata;
extern NSString *const AdViewNativeAdJsonStr;
extern NSString *const AdViewNativeAdAdapter;

@interface AdViewNativeAdInfo : NSObject

@property (nonatomic, retain) NSDictionary *nativeAdDict;
@property (nonatomic, retain) NSString *nativeAdID;

- (void)showNativeAdWith:(UIView*)view;
- (void)clickNativeAd;

@end
