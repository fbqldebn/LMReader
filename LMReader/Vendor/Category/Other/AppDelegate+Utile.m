//
//  UIApplication+Utile.m
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "AppDelegate+Utile.h"
#import "LMBookShelfVC.h"
#import "LMPersonCenterVC.h"


@implementation AppDelegate (Utile)

- (void)CGApplicationLaunchConfig;
{
    [DatebaseManage sharedDatebase];
    self.viewController = [[LMTabbarController alloc]init];
    
    self.window.rootViewController = self.viewController;
    
   

}
@end
