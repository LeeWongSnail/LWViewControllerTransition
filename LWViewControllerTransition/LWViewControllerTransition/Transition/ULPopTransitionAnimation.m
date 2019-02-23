//
//  ULPopTransitionAnimation.m
//  HalfScreenTransition
//
//  Created by LeeWong on 2019/2/20.
//  Copyright © 2019年 ws. All rights reserved.
//

#import "ULPopTransitionAnimation.h"
#import "BaseViewController.h"

@implementation ULPopTransitionAnimation


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

    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];

    [containerView addSubview:toView];

    if ([toViewController isKindOfClass:[BaseViewController class]] && [toViewController respondsToSelector:@selector(transitionStyle)]) {
        ULViewControllerTransitionStyle style = [(BaseViewController *)toViewController transitionStyle];
        if (style & ULViewControllerTransitionStyleHalfDismiss) {
            CGRect fromFrame = CGRectMake(0, ULMainScreenHeight, ULMainScreenWidth, ULMainScreenHeight-150);
            UIGraphicsBeginImageContextWithOptions(fromViewController.view.bounds.size, YES, [UIScreen mainScreen].scale);
            [fromViewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();

            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = fromViewController.view.frame;
            imageView.layer.masksToBounds = YES;
            [[transitionContext containerView] addSubview:imageView];

            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                imageView.frame = fromFrame;
            } completion:^(BOOL finished) {
                [imageView removeFromSuperview];
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        } else if (style & ULViewControllerTransitionStyleHalfPop) {
            CGRect fromFrame = CGRectMake(ULMainScreenWidth, 150, ULMainScreenWidth, ULMainScreenHeight-150);
            UIGraphicsBeginImageContextWithOptions(fromViewController.view.bounds.size, YES, [UIScreen mainScreen].scale);
            [fromViewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();

            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = fromViewController.view.frame;
            imageView.layer.masksToBounds = YES;
            [[transitionContext containerView] addSubview:imageView];
            toView.frame = CGRectMake(0, 150, ULMainScreenWidth, ULMainScreenHeight-150);
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                imageView.frame = fromFrame;
            } completion:^(BOOL finished) {
                [imageView removeFromSuperview];
                toView.frame = CGRectMake(0, 150, ULMainScreenWidth, ULMainScreenHeight-150);
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        }
    } else {

    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end
