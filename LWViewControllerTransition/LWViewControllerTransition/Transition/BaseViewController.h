//
//  BaseViewController.h
//  HalfScreenTransition
//
//  Created by LeeWong on 2019/2/20.
//  Copyright © 2019年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSInteger, ULViewControllerTransitionStyle) {
    ULViewControllerTransitionStyleNone = 1 << 0,
    ULViewControllerTransitionStyleHalfModal =  1 << 1,
    ULViewControllerTransitionStyleHalfDismiss = 1 << 2,
    ULViewControllerTransitionStyleHalfPush = 1 << 3,
    ULViewControllerTransitionStyleHalfPop = 1 << 4,
};
#define ULMainScreenFrame [[UIScreen mainScreen] bounds]

/** 设备屏幕宽 */
#define ULMainScreenWidth ULMainScreenFrame.size.width

/** 设备屏幕高 */
#define ULMainScreenHeight ULMainScreenFrame.size.height

@interface BaseViewController : UIViewController

- (ULViewControllerTransitionStyle)transitionStyle;

@end


