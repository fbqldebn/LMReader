//
//  AdCommonDef.h
//  AdViewDevelop
//
//  Created by laizhiwen on 14-11-5.
//  Copyright (c) 2014年 maming. All rights reserved.
//

#ifndef AdViewDevelop_AdCommonDef_h
#define AdViewDevelop_AdCommonDef_h

#define ADVIEW_VERSION_STR @"322"

#import "AdCommonNetworkType.h"
#import <UIKit/UIKit.h>

//和SDKTYPE匹配
typedef enum tagAdViewSDKType {
    AdViewSDKType_Banner = 0,
    AdViewSDKType_Instl = 1,
    AdViewSDKType_SpreadScreen = 4,
    AdViewSDKType_Native = 5,
}AdViewSDKType;

BOOL isForeignAd(AdViewSDKType sdkType, int networkType);

#endif

#define USER_TEST_SERVER			0

#define DEBUG_INFO					0

#if USER_TEST_SERVER		//test server, ip server
//banner
#define kAdViewDefaultConfigURL                 @"https://test2014.adview.cn/agent/agent1.php"
#define kAdViewDefaultImpMetricURL              @"https://test2014.adview.cn/agent/agent2.php"
#define kAdViewDefaultClickMetricURL            @"https://test2014.adview.cn/agent/agent3.php"
#define kAdViewDefaultRequestMetricURL          @"https://test2014.adview.cn/agent/banner_request.php"
#define kAdViewDefaultCustomAdURL               @"https://test2014.adview.cn/agent/custom.php"
//adinstl
#define kAdInstlDefaultConfigURL                @"https://test2014.adview.cn/agent/adinstl_config.php"
#define kAdInstlDefaultRequestMetricURL         @"https://test2014.adview.cn/agent/adinstl_request.php"
#define kAdInstlDefaultImpMetricURL             @"https://test2014.adview.cn/agent/adinstl_display.php"
#define kAdInstlDefaultClickMetricURL           @"https://test2014.adview.cn/agent/adinstl_click.php"
#define kAdInstlDefaultCustomAdURL              @"https://test2014.adview.cn/agent/custom.php"
//adspread
#define kAdSpreadScreenDefaultConfigURL         @"https://test2014.adview.cn/agent/spreadscreen_config.php"
#define kAdSpreadScreenDefaultRequestMetricURL  @"https://test2014.adview.cn/agent/spreadscreen_request.php"
#define kAdSpreadScreenDefaultImpMetricURL      @"https://test2014.adview.cn/agent/spreadscreen_display.php"
#define kAdSpreadScreenDefaultClickMetricURL    @"https://test2014.adview.cn/agent/spreadscreen_click.php"
#define kAdSpreadScreenDefaultCustomAdURL       @"https://test2014.adview.cn/agent/custom.php"
//adnative
#define kAdNativeDefaultConfigURL               @"https://test2014.adview.cn/agent/adNative_config.php"
#define kAdNativeDefaultRequestMetricURL        @"https://test2014.adview.cn/agent/adNative_reqinfo.php"
#define kAdNativeDefaultImpMetricURL            @"https://test2014.adview.cn/agent/adNative_display.php"
#define kAdNativeDefaultClickMetricURL          @"https://test2014.adview.cn/agent/adNative_click.php"
#define kAdNativeDefaultCustomAdURL             @"https://test2014.adview.cn/agent/custom.php"

#define CONFIG_REACH_CHECK		0		//现在的check针对ip:124.207.233.116不可行，域名估计没问题

#else
//banner
#define kAdViewDefaultConfigURL         @"https://config.adview.cn/agent/agent1.php"
#define kAdViewDefaultRequestMetricURL  @"https://report.adview.cn/agent/banner_request.php"
#define kAdViewDefaultImpMetricURL      @"https://report.adview.cn/agent/agent2.php"
#define kAdViewDefaultClickMetricURL    @"https://report.adview.cn/agent/agent3.php"
#define kAdViewDefaultCustomAdURL       @"https://report.adview.cn/agent/custom.php"
//adinstl
#define kAdInstlDefaultConfigURL        @"https://config.adview.cn/agent/adinstl_config.php"
#define kAdInstlDefaultRequestMetricURL @"https://report.adview.cn/agent/adinstl_request.php"
#define kAdInstlDefaultImpMetricURL     @"https://report.adview.cn/agent/adinstl_display.php"
#define kAdInstlDefaultClickMetricURL	@"https://report.adview.cn/agent/adinstl_click.php"
#define kAdInstlDefaultCustomAdURL		@"https://report.adview.cn/agent/custom.php"
//adspread
#define kAdSpreadScreenDefaultConfigURL			@"https://config.adview.cn/agent/spreadscreen_config.php"
#define kAdSpreadScreenDefaultRequestMetricURL	@"https://report.adview.cn/agent/spreadscreen_request.php"
#define kAdSpreadScreenDefaultImpMetricURL		@"https://report.adview.cn/agent/spreadscreen_display.php"
#define kAdSpreadScreenDefaultClickMetricURL	@"https://report.adview.cn/agent/spreadscreen_click.php"
#define kAdSpreadScreenDefaultCustomAdURL		@"https://report.adview.cn/agent/custom.php"
//adnative
#define kAdNativeDefaultConfigURL			@"https://config.adview.cn/agent/adNative_config.php"
#define kAdNativeDefaultRequestMetricURL    @"https://report.adview.cn/agent/adNative_reqinfo.php"
#define kAdNativeDefaultImpMetricURL		@"https://report.adview.cn/agent/adNative_display.php"
#define kAdNativeDefaultClickMetricURL		@"https://report.adview.cn/agent/adNative_click.php"
#define kAdNativeDefaultCustomAdURL			@"https://report.adview.cn/agent/custom.php"

#define CONFIG_REACH_CHECK		1		//现在的check针对ip:adview，域名估计没问题, laizhiwen

#endif

//banner
#define kAdViewRequestMetricURLFmt          @"https://%@/agent/banner_request.php" // request
#define kAdViewImpMetricURLFmt              @"https://%@/agent/agent2.php" // display
#define kAdViewClickMetricURLFmt            @"https://%@/agent/agent3.php" // click
//adinstl
#define kAdInstlRequestMetricURLFmt         @"https://%@/agent/adinstl_request.php"
#define kAdInstlImpMetricURLFmt             @"https://%@/agent/adinstl_display.php"
#define kAdInstlClickMetricURLFmt           @"https://%@/agent/adinstl_click.php"
//adspread
#define kAdSpreadScreenRequestMetricURLFmt      @"https://%@/agent/spreadscreen_request.php"
#define kAdSpreadScreenImpMetricURLFmt		@"https://%@/agent/spreadscreen_display.php"
#define kAdSpreadScreenClickMetricURLFmt    @"https://%@/agent/spreadscreen_click.php"
//adnative
#define kAdNativeRequestMetricURLFmt        @"https://%@/agent/adNative_reqinfo.php"
#define kAdNativeImpMetricURLFmt			@"https://%@/agent/adNative_display.php"
#define kAdNativeClickMetricURLFmt		    @"https://%@/agent/adNative_click.php"

#define KCONFIG_FAIL_NOTIFICATION @"Config_Fail_Notification_%d"
#define KCONFIG_SUCCESS_NOTIFICATION @"Config_Success_Notification_%d"

#define kAWMinimumTimeBetweenFreshAdRequests    2.9f
#define KADVIEW_PUBLISH_CHANNEL_APPSTORE @"AppStore"
#define KADVIEW_PUBLISH_CHANNEL_CYDIA @"Cydia"
#define KADVIEW_PUBLISH_CHANNEL_91Store @"91Store"
#define kAdViewConfigRegetTimeInteval   60