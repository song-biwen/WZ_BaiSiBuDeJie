//
//  WZFriendTrendsViewController.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/3.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZFriendTrendsViewController.h"

#import "WZRecommendViewController.h" //推荐关注


@interface WZFriendTrendsViewController ()

@end

@implementation WZFriendTrendsViewController

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
    
    self.title = @"我的关注";
    self.view.backgroundColor = WZColorDefault;
    
    /*
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:WZImage(@"friendsRecommentIcon") forState:UIControlStateNormal];
    [button setBackgroundImage:WZImage(@"friendsRecommentIcon-click") forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
     */
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"friendsRecommentIcon" highlightImageName:@"friendsRecommentIcon-click" target:self action:@selector(buttonAction)];
}

- (void)buttonAction {
//    WZLogFunc;
    WZRecommendViewController *vc = [[WZRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
