//
//  LMBaseAnimtor.h
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ControllerTransitionType){
    ControllerTransitionTypePush,
    ControllerTransitionTypePop,
    ControllerTransitionTypePresent,
    ControllerTransitionTypeDismiss,
};

@interface LMBaseAnimtor : NSObject <UIViewControllerAnimatedTransitioning>

/**
 *  动画类型
 */
@property (nonatomic, assign)ControllerTransitionType transitiontype;
/**
 *  动画执行时间(默认值为0.5s)
 */
@property (nonatomic) NSTimeInterval  transitionDuration;

/**
 *  == 子类重写此方法实现动画效果 ==
 *
 *  动画事件
 */
- (void)animateTransitionEvent;

/**
 *  == 在animateTransitionEvent使用才有效 ==
 *
 *  源头控制器
 */
@property (nonatomic, readonly, weak) UIViewController *fromViewController;

/**
 *  == 在animateTransitionEvent使用才有效 ==
 *
 *  目标控制器
 */
@property (nonatomic, readonly, weak) UIViewController *toViewController;

/**
 *  == 在animateTransitionEvent使用才有效 ==
 *
 *  containerView
 */
@property (nonatomic, readonly, weak) UIView           *containerView;

/**
 *  动画事件结束
 */
- (void)completeTransition;


@end
