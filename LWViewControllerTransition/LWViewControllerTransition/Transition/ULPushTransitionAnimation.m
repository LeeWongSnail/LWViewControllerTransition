//
//  ULPushTransitionAnimation.m
//  HalfScreenTransition
//
//  Created by LeeWong on 2019/2/20.
//  Copyright © 2019年 ws. All rights reserved.
//

#import "ULPushTransitionAnimation.h"
#import "BaseViewController.h"

@implementation ULPushTransitionAnimation


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];

    containerView.backgroundColor = [UIColor yellowColor];

    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor grayColor];
    view.frame = CGRectMake(0, 0, ULMainScreenWidth, 150);
    [containerView addSubview:view];

    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];

    [containerView addSubview:toView];

    if ([toViewController isKindOfClass:[BaseViewController class]] && [toViewController respondsToSelector:@selector(transitionStyle)]) {
        ULViewControllerTransitionStyle style = [(BaseViewController *)toViewController transitionStyle];
        if (style & ULViewControllerTransitionStyleHalfModal) {
            toView.frame = CGRectMake(0, ULMainScreenHeight, ULMainScreenWidth, ULMainScreenHeight-150);
            CGRect toFrame = CGRectMake(0, 150, ULMainScreenWidth, ULMainScreenHeight-150);

            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                toView.frame = toFrame;
            } completion:^(BOOL finished) {
                NSLog(@"%@",fromViewController);
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        } else if (style & ULViewControllerTransitionStyleHalfPush) {
            toView.frame = CGRectMake(ULMainScreenWidth, 150, ULMainScreenWidth, ULMainScreenHeight-150);
            CGRect toFrame = CGRectMake(0, 150, ULMainScreenWidth, ULMainScreenHeight-150);

            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                toView.frame = toFrame;
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        }
    } else {
        NSLog(@"---");
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end
