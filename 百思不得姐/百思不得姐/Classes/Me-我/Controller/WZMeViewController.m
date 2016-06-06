//
//  WZMeViewController.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/3.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZMeViewController.h"

@interface WZMeViewController ()

@end

@implementation WZMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     备注
     1.
     self.title = @"我的关注";
     等价于
     self.navigationItem.title = @"我的关注";
     self.tabBarItem.title = @"我的关注";
     */
    
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = WZColorDefault;
    
    /*
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setBackgroundImage:WZImage(@"mine-setting-icon") forState:UIControlStateNormal];
    [button1 setBackgroundImage:WZImage(@"mine-setting-icon-click") forState:UIControlStateHighlighted];
    button1.size = button1.currentBackgroundImage.size;
    button1.tag = 1;
    [button1 addTarget:self action:@selector(buttonActionWithSender:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setBackgroundImage:WZImage(@"mine-moon-icon") forState:UIControlStateNormal];
    [button2 setBackgroundImage:WZImage(@"mine-moon-icon-click") forState:UIControlStateHighlighted];
    button2.size = button2.currentBackgroundImage.size;
    button2.tag = 2;
    [button2 addTarget:self action:@selector(buttonActionWithSender:) forControlEvents:UIControlEventTouchUpInside];
     */
    
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImageName:@"mine-setting-icon" highlightImageName:@"mine-setting-icon-click" target:self action:@selector(settingButtonAction)];
     UIBarButtonItem *item2 = [UIBarButtonItem itemWithImageName:@"mine-moon-icon" highlightImageName:@"mine-moon-icon-click" target:self action:@selector(moonButtonAction)];
    
    self.navigationItem.rightBarButtonItems = @[item1,item2];
    
}

/** 设置 */
- (void)settingButtonAction {
    WZLogFunc;
}

/** 模式 */
- (void)moonButtonAction {
    WZLogFunc;
    
}

@end
