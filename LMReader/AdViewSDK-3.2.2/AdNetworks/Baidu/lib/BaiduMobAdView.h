//
//  BaiduMobAdView.h
//  BaiduMobAdSdk
//
//  Created by jaygao on 11-9-6.
//  Copyright 2011年 Baidu. All rights reserved.
//
//  Baidu Mobads SDK Version 3.1
//

#import <UIKit/UIKit.h>
#import "BaiduMobAdDelegateProtocol.h"

#define kBaiduAdViewSizeDefaultWidth 320
#define kBaiduAdViewSizeDefaultHeight 48
#define kBaiduAdViewBanner320x48 CGSizeMake(320, 48)
#define kBaiduAdViewBanner468x60 CGSizeMake(468, 60)
#define kBaiduAdViewBanner728x90 CGSizeMake(728, 90)

#define kBaiduAdViewSquareBanner300x250 CGSizeMake(300, 250)
#define kBaiduAdViewSquareBanner600x500 CGSizeMake(600, 500)
/**
 *  投放广告的视图接口,更多信息请查看[百度移动联盟主页](http://mssp.baidu.com)
 */

/**
 *  广告类型
 * 0 banner广告
 */
typedef enum _BaiduMobAdViewType {
    BaiduMobAdViewTypeBanner = 0
} BaiduMobAdViewType;


@interface BaiduMobAdView : UIView {
    @private
    UIColor                     *_textColor DEPRECATED_ATTRIBUTE;
    UIColor                     *_backgroundColor DEPRECATED_ATTRIBUTE;
    CGFloat                      _alpha DEPRECATED_ATTRIBUTE;
    
    NSString                     *_aduTag;
    id<BaiduMobAdViewDelegate>  _delegate;
}

///---------------------------------------------------------------------------------------
/// @name 属性
///---------------------------------------------------------------------------------------

/**
 *  委托对象
 */
@property (nonatomic ,assign)   id<BaiduMobAdViewDelegate>  delegate;

/**
 *  广告类型
 */
@property (nonatomic) BaiduMobAdViewType AdType;

/**
 *  设置／获取当前广告（文字）的文本颜色
 */
@property (nonatomic, retain)   UIColor                     *textColor DEPRECATED_ATTRIBUTE;


/**
 *  - 设置是否需要启动SDK的自动轮播机制
 *  - autoplayEnabled设置为YES（默认值）时，SDK会自动根据一定的时间间隔播放不同的广告。开发者无须编写额外的代码控制广告的更新和展示。
 */

@property (nonatomic)           BOOL                        autoplayEnabled;

/**
 *  设置/获取代码位id
 */
@property (nonatomic, copy) NSString                    *AdUnitTag;

/**
 *  SDK版本
 */
@property (nonatomic, readonly) NSString                    *Version;

/**
 *  - 开始广告展示请求,会触发所有资源的重新加载，推荐初始化以后调用一次
 *  如果关闭轮播, 在需要时调用 start 来实现轮播.
 */
- (void) start;



@end

