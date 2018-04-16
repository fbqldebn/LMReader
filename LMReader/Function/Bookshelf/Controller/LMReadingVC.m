//
//  LMReadingVC.m
//  LMReader
//
//  Created by 于君 on 16/5/23.
//  Copyright © 2016年 zwh. All rights reserved.
//

#import "LMReadingVC.h"
#import "LMReadingVC+Helper.h"

#import "DTAttStringManage.h"

@class DemoTextViewController;
@interface LMReadingVC ()<UIGestureRecognizerDelegate>

@end

@implementation LMReadingVC

@synthesize modelController = _modelController;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
//    self.tabBarController.tabBar.hidden = NO;
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jumpChapter:) name:JUMPCHAPTER object:nil];
    [self _chagePageViewControllerStyle:[LMGoble sharedGoble].pageTransition];
    [self addNavBar];
    [self addBottomToolBar];
    [self addFontSizeView];
    [self addLigntnessChangeView];
    
        // Do any additional setup after loading the view.
}
-(void)jumpChapter:(NSNotification *)noti
{
       NSInteger index = 20;
    [[DTAttStringManage sharedManage] parseBook:self.currentBook finish:^{
        DemoTextViewController *startingViewController = [self.modelController viewControllerAtIndex:index storyboard:self.storyboard];
        NSArray *viewControllers ;
        if (startingViewController) {
            viewControllers = @[startingViewController];
        }
        [self.view insertSubview:self.pageViewController.view atIndex:0];
       }];
    
}

- (void)_chagePageViewControllerStyle:(UIPageViewControllerTransitionStyle)type
{
    if (self.pageViewController.transitionStyle!=type||!self.pageViewController) {
        self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:type navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        if (type == UIPageViewControllerTransitionStyleScroll) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_tapActionScrollTransition:)];
            [self.pageViewController.view addGestureRecognizer:tap];
        }
        self.pageViewController.delegate = self;
        [[DTAttStringManage sharedManage] parseBook:self.currentBook finish:^{
            DemoTextViewController *startingViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
            NSArray *viewControllers ;
            if (startingViewController) {
               viewControllers = @[startingViewController];
            }
            
            
            [self.pageViewController setViewControllers:viewControllers direction:type==UIPageViewControllerTransitionStyleScroll?UIPageViewControllerNavigationDirectionForward:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
            
            self.pageViewController.dataSource = self.modelController;
            [self addChildViewController:self.pageViewController];
            [self.view insertSubview:self.pageViewController.view atIndex:0];
            
            // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
            CGRect pageViewRect = self.view.bounds;
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                pageViewRect = CGRectInset(pageViewRect, 0.0, 80.0);
            }
            pageViewRect = CGRectInset(pageViewRect, 0.0, 0.0);
            self.pageViewController.view.frame = pageViewRect;
            
            [self.pageViewController didMoveToParentViewController:self];
            
            // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
            self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
            [self.pageViewController.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIGestureRecognizer *recognize = obj;
                recognize.delegate = self;
                
            }];
            
        }];

    }
}
- (PageModelControll *)modelController {
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[PageModelControll alloc] init];
    }
    return _modelController;
}
- (void)_tapActionScrollTransition:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:self.view];
    if (CGRectContainsPoint(CGRectInset(self.view.bounds, SCREEN_WIDTH/3, 0), touchPoint)) {
        [self tapShowHideToolBar];
    }else if (CGRectContainsPoint(CGRectMake(0, 0, SCREEN_WIDTH/3, SCREEN_HEIGHT),touchPoint))//left
    {
        NSInteger index;
        if (!self.modelController.pageIndex) {
            [self.modelController setLastChapterToCurrent];
            index = self.modelController.pageData.count-1;
//            NSLog(@"index  ====    %ld",(long)index);
//            NSLog(@"self.modelController.pageData =   %@",self.modelController.pageData);
            DemoTextViewController *vc = [self.modelController viewControllerAtIndex:index storyboard:nil];
            WEAK_SELF
            if (vc) {
                [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
                    [weakSelf.modelController setLastChapterToCurrent];
                }];
            }
        }else
        {
            index = self.modelController.pageIndex-1;
            DemoTextViewController *vc = [self.modelController viewControllerAtIndex:index storyboard:nil];
            if (vc) {
                [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
                    
                }];
            }
        }
        
        
        
    }else
    {
        NSInteger index;
        if ([self.modelController indexOfViewController:self.pageViewController.viewControllers[0]]==NSNotFound||self.modelController.pageIndex ==NSNotFound) {
            index = 0;
        }else
        {
            index = self.modelController.pageIndex+1;
        }
        
        DemoTextViewController *vc = [self.modelController viewControllerAtIndex:index storyboard:nil];
        if (vc) {
            [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
                
            }];
        }

    }
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:self.view];
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]&&CGRectContainsPoint(CGRectInset(self.view.bounds, SCREEN_WIDTH/3, 0), touchPoint)) {
        
        [self tapShowHideToolBar];
    
    }else if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])
    {
        
    }
    return YES;
}
-(BOOL)respondsToSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector])
        return YES;
    else if ([self.pageViewController respondsToSelector:aSelector])
        return YES;
    else
        return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) {
        return nil;
    } else if ([self.pageViewController respondsToSelector:aSelector]) {
        return self.pageViewController;
    }
    return nil;
}
#pragma mark -
#pragma mark - UIPageViewController delegate methods
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    [self panHideToolBar];
}
- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    if (UIInterfaceOrientationIsPortrait(orientation) || ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)) {
        // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
//        if (self.pageViewController.viewControllers.count) {
//            UIViewController *currentViewController = self.pageViewController.viewControllers[0];
//            NSArray *viewControllers = @[currentViewController];
//            [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
//        }

        self.pageViewController.doubleSided = NO;
        return UIPageViewControllerSpineLocationMin;
    }
    
    // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
    DemoTextViewController *currentViewController = self.pageViewController.viewControllers[0];
    NSArray *viewControllers = nil;
    NSUInteger indexOfCurrentViewController = [self.modelController indexOfViewController:currentViewController];
    if (indexOfCurrentViewController == 0 || indexOfCurrentViewController % 2 == 0) {
        UIViewController *nextViewController = [self.modelController pageViewController:self.pageViewController viewControllerAfterViewController:currentViewController];
        viewControllers = @[currentViewController, nextViewController];
    } else {
        UIViewController *previousViewController = [self.modelController pageViewController:self.pageViewController viewControllerBeforeViewController:currentViewController];
        viewControllers = @[previousViewController, currentViewController];
    }
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    return UIPageViewControllerSpineLocationMid;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
