//
//  ViewController.m
//  LWViewControllerTransition
//
//  Created by LeeWong on 2019/2/22.
//  Copyright © 2019 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "PresentAnimationDelegate.h"
#import "Masonry.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) PresentAnimationDelegate *delegate;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blueColor];
    
    self.topView = [[UIView alloc] init];
    self.topView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@150);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@50);
    }];
    self.delegate = [[PresentAnimationDelegate alloc] init];
    [self.button addTarget:self action:@selector(pushToFirst) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pushToFirst {
    FirstViewController *firstVc = [[FirstViewController alloc] init];
    self.navigationController.delegate = self.delegate;
    [self.navigationController pushViewController:firstVc animated:YES];
}

- (UIButton *)button {
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"拉起弹窗" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_button];
    }
    return _button;
}


@end
