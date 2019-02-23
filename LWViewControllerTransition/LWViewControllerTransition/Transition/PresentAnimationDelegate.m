//
//  PresentAnimationDelegate.m
//  HalfScreenTransition
//
//  Created by LeeWong on 2019/2/20.
//  Copyright © 2019年 ws. All rights reserved.
//

#import "PresentAnimationDelegate.h"
#import "ULPushTransitionAnimation.h"
#import "ULPopTransitionAnimation.h"

@implementation PresentAnimationDelegate


- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {

    id <UIViewControllerAnimatedTransitioning> anim = nil;
    if (operation == UINavigationControllerOperationPush) {
        anim = [[ULPushTransitionAnimation alloc] init];
    } else if (operation == UINavigationControllerOperationPop) {
        anim = [[ULPopTransitionAnimation alloc] init];
    } else {

    }

    return anim;
}

@end
