//
//  LMOpenBookAnimtor.m
//  LMReader
//
//  Created by 于君 on 16/5/24.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMOpenBookAnimtor.h"
#import "LMBookShelfVC.h"
#import "BookNormalCell.h"

#define    IMAGE_FRAME_NORMAL    CGRectMake(20, 20, 370 / 4.f, 576 / 4.f)
#define    IMAGE_FRAME_BIG       CGRectMake(100, 100, 370 / 2.f, 576 / 2.f)
#define    SHOW_IMAGE            [UIImage imageNamed:@"demo"]
@implementation LMOpenBookAnimtor

- (void)animateTransitionEvent {
    [CATransaction flush];
    self.toViewController.view.alpha   = 1.f;
    LMBookShelfVC *shelfVC ;
    BookNormalCell *cell = self.animatedView;
    if (!tmpImageView) {
        tmpImageView = [[UIImageView alloc] initWithFrame:self.animatedView.coverImageV.bounds];
    }
    tmpImageView.image = self.animatedView.coverImageV.image;
    CGFloat scaleX;
    CGFloat scaleY;
    scaleX = SCREEN_WIDTH / cell.coverImageV.bounds.size.width;
    scaleY = SCREEN_HEIGHT / cell.coverImageV.bounds.size.height;
    CATransform3D transformblank;
    CABasicAnimation *rotation;
    // CABasicAnimation *translationX;  // 如果沿X轴翻转,则用不到这个变量.
    CABasicAnimation *translationY; // 如果沿Y轴翻转,则用不到这个变量.
    CABasicAnimation *translationZ;
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.delegate = self;
    animationGroup.duration = self.transitionDuration;
    
    if (self.transitiontype==ControllerTransitionTypePresent) {
        [self.containerView addSubview:self.toViewController.view];
        UITabBarController *tabbarVC = (UITabBarController*)self.fromViewController;
        UINavigationController* nav = tabbarVC.viewControllers[0];
        shelfVC = (LMBookShelfVC*)nav.viewControllers[0];
        CGPoint center = [shelfVC.view convertPoint:self.animatedView.coverImageV.center fromView:cell];
        tmpImageView.center = center;
        [self.containerView addSubview:tmpImageView];
        self.toViewController.view.transform =
        CGAffineTransformConcat(CGAffineTransformMakeScale(1.0/scaleX, 1.0/scaleY), CGAffineTransformMakeTranslation(center.x-SCREEN_WIDTH/2, center.y-SCREEN_HEIGHT/2));
        
        transformblank = CATransform3DMakeRotation(-M_PI_2 / 1.01, 0.0, 1.0, 0.0);
        transformblank.m34 = 1.0f / 200.0f;
        transformblank = CATransform3DConcat(transformblank, CATransform3DMakeScale(scaleX, scaleY, 1));
        tmpImageView.layer.anchorPoint = CGPointMake(0, 0.5);
        tmpImageView.layer.position = CGPointMake(tmpImageView.frame.origin.x,tmpImageView.frame.origin.y+ CGRectGetHeight(tmpImageView.frame)/2);
        
    }else if(self.transitiontype==ControllerTransitionTypeDismiss)
    {
        UITabBarController *tabbarVC = (UITabBarController*)self.toViewController;
        UINavigationController* nav = tabbarVC.viewControllers[0];
        shelfVC = (LMBookShelfVC*)nav.viewControllers[0];
        cell = self.animatedView;
        tmpImageView.hidden = NO;
    }

    [UIView animateWithDuration:self.transitionDuration
                          delay:0.0f
         usingSpringWithDamping:3 initialSpringVelocity:0.f options:0 animations:^{
             if (self.transitiontype==ControllerTransitionTypePresent) {
                 
                 tmpImageView.layer.position = CGPointMake(0, SCREEN_HEIGHT/2);
                 tmpImageView.layer.transform = transformblank;
                 self.toViewController.view.transform =
                 CGAffineTransformIdentity;
             }else
             {
                 
                 BookNormalCell *firstCell = (BookNormalCell*)[shelfVC.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                 CGPoint center = [shelfVC.view convertPoint:firstCell.coverImageV.center fromView:firstCell];
                 CGPoint point =CGPointMake(center.x-(CGRectGetWidth(self.animatedView.frame)/2.0),center.y);
                 tmpImageView.layer.position = point;

                 self.fromViewController.view.transform =CGAffineTransformConcat(CGAffineTransformMakeScale(1.0/scaleX, 1.0/scaleY), CGAffineTransformMakeTranslation(center.x-SCREEN_WIDTH/2, center.y-SCREEN_HEIGHT/2));
                 tmpImageView.layer.transform = CATransform3DIdentity;
             }             
         } completion:^(BOOL finished) {
             if (self.transitiontype==ControllerTransitionTypeDismiss) {
                 [tmpImageView removeFromSuperview];
                 
             }else
             {
                 self.toViewController.view.transform =
                 CGAffineTransformIdentity;
                 tmpImageView.hidden = YES;
             }
             
            [self completeTransition];
         }];
}

@end
