//
//  FirstViewController.m
//  HalfScreenTransition
//
//  Created by LeeWong on 2019/2/20.
//  Copyright © 2019年 ws. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "PresentAnimationDelegate.h"
#import "Masonry.h"
@interface FirstViewController ()
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *jumpButton;
@property (nonatomic, strong) PresentAnimationDelegate *animation;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];

    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(50);
        make.width.equalTo(@100);
        make.height.equalTo(@50);
    }];
    [self.jumpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button.mas_bottom).offset(20);
        make.width.equalTo(@100);
        make.height.equalTo(@50);
        make.left.equalTo(self.button);
    }];

    [self.jumpButton addTarget:self action:@selector(pushtoNext) forControlEvents:UIControlEventTouchUpInside];
    [self.button addTarget:self action:@selector(popToFirst) forControlEvents:UIControlEventTouchUpInside];
    self.animation = [[PresentAnimationDelegate alloc] init];
}

- (ULViewControllerTransitionStyle)transitionStyle {
    return ULViewControllerTransitionStyleHalfModal | ULViewControllerTransitionStyleHalfPop;
}

- (void)popToFirst {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushtoNext {
    SecondViewController *secondVc = [[SecondViewController alloc] init];
    self.navigationController.delegate = self.animation;
    [self.navigationController pushViewController:secondVc animated:YES];
}

- (UIButton *)button {
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"dismiss弹窗" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_button];
    }
    return _button;
}

- (UIButton *)jumpButton {
    if (_jumpButton == nil) {
        _jumpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_jumpButton setTitle:@"跳转" forState:UIControlStateNormal];
        [_jumpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_jumpButton];
    }
    return _jumpButton;
}

@end
