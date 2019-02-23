//
//  ULPopTransitionAnimation.h
//  HalfScreenTransition
//
//  Created by LeeWong on 2019/2/20.
//  Copyright © 2019年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ULPopTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning,CAAnimationDelegate>
@property(nonatomic,strong) id <UIViewControllerContextTransitioning>transitionContext;

@end

NS_ASSUME_NONNULL_END
