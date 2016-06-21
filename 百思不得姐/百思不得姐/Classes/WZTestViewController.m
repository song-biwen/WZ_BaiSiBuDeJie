//
//  WZTestViewController.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/6.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZTestViewController.h"
#import "WZLoginRegisterViewController.h" //登录注册

@interface WZTestViewController ()

@end

@implementation WZTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"WZTestViewController";
    self.view.backgroundColor = WZColorDefault;
    
    UIButton *button = [[UIButton alloc] init];
    button.center = CGPointMake(WZScreenWidth * 0.5, WZScreenHeight * 0.5);
    button.size = CGSizeMake(100, 30);
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)cancelAction {
    
    WZLog(@"%@",[UIApplication sharedApplication].keyWindow.rootViewController);
    
    id vc = self.navigationController.childViewControllers[0];
    if ([vc isKindOfClass:[WZLoginRegisterViewController class]]) {
        WZLoginRegisterViewController *loginVc = (WZLoginRegisterViewController *)vc;
        [loginVc dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
