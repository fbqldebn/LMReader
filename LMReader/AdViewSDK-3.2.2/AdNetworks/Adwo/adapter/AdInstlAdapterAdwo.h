/*
 
 adview.
 
 */

#import "AdInstlAdNetworkAdapter.h"
#import "AdwoAdSDK.h"

@interface AdInstlAdapterAdwo : AdInstlAdNetworkAdapter<AWAdViewDelegate> {
    UIView *awView;
    BOOL hasLoaded;
}

@property (nonatomic,retain) UIView *awView;
@property (nonatomic,assign) UIViewController *parent;

+ (AdInstlAdNetworkType)networkType;

@end
