//
//  WZEssenceViewController.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/3.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZEssenceViewController.h"

@interface WZEssenceViewController ()

@end

@implementation WZEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = WZImageView(@"MainTitle");
    
    /** 
     UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
     [button setBackgroundImage:WZImage(@"MainTagSubIcon") forState:UIControlStateNormal];
     [button setBackgroundImage:WZImage(@"MainTagSubIconClick") forState:UIControlStateHighlighted];
     button.size = button.currentBackgroundImage.size;
     [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];

     */
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" highlightImageName:@"MainTagSubIconClick" target:self action:@selector(buttonAction)];
}

- (void)buttonAction {
    WZLogFunc;
    
}

@end
