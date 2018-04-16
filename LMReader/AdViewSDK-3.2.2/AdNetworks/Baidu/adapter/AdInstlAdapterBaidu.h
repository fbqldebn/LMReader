//
//  AdInstlAdapterAderBaidu.h
//  AdInstlSDK_iOS
//
//  Created by adview on 13-10-24.
//
//

#import "BaiduMobAdCommonConfig.h"
#import "BaiduMobAdInterstitial.h"
#import "BaiduMobAdInterstitialDelegate.h"
#import "AdInstlAdNetworkAdapter.h"

@interface AdInstlAdapterBaidu : AdInstlAdNetworkAdapter<BaiduMobAdInterstitialDelegate>
{
    BaiduMobAdInterstitial *interstitialView;
}

@property (nonatomic,retain) BaiduMobAdInterstitial *interstitialView;

+ (AdInstlAdNetworkType)networkType;

@end
