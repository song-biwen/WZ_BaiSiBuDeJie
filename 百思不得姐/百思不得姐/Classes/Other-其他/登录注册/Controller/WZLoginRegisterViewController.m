//
//  WZLoginRegisterViewController.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/13.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZLoginRegisterViewController.h"

@interface WZLoginRegisterViewController ()

@end

@implementation WZLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//取消按钮
- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buttonAction:(id)sender {
    WZLogFunc;
    //腾讯微博的高亮图片有问题
}
@end
