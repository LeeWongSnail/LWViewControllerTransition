//
//  SecondViewController.m
//  HalfScreenTransition
//
//  Created by LeeWong on 2019/2/20.
//  Copyright © 2019年 ws. All rights reserved.
//

#import "SecondViewController.h"
#import "Masonry.h"
@interface SecondViewController ()
@property (nonatomic, strong) UIButton *button;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view.
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(50);
        make.width.equalTo(@100);
        make.height.equalTo(@50);
    }];
    [self.button addTarget:self action:@selector(popToLast) forControlEvents:UIControlEventTouchUpInside];
}

- (void)popToLast {
    [self.navigationController popViewControllerAnimated:YES];
}

- (ULViewControllerTransitionStyle)transitionStyle {
    return ULViewControllerTransitionStyleHalfPush | ULViewControllerTransitionStyleNone;
}

- (UIButton *)button {
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"pop弹窗" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.view addSubview:_button];
    }
    return _button;
}

@end
