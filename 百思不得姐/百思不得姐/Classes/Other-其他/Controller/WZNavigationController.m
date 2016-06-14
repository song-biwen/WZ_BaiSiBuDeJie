//
//  WZNavigationController.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/3.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZNavigationController.h"

@interface WZNavigationController ()

@end

@implementation WZNavigationController

+ (void)initialize {
    /** 
     只设置该导航控制器 子视图的导航栏背景图片
     [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]] setBackgroundImage:WZImage(@"navigationbarBackgroundWhite") forBarMetrics:UIBarMetricsDefault];
     */
    
    
    //设置所有导航栏的背景图片
    [[UINavigationBar appearance] setBackgroundImage:WZImage(@"navigationbarBackgroundWhite") forBarMetrics:UIBarMetricsDefault];
    
    WZLogFunc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 当在此处设置该方法，那么viewDidLoad将运行多次,该方法将运行多次
      [self.navigationBar setBackgroundImage:WZImage(@"navigationbarBackgroundWhite") forBarMetrics:UIBarMetricsDefault];
     */
   
//    WZLogFunc;
}

/** 自定义返回按钮 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:WZColor(1, 1, 1, 1.0) forState:UIControlStateNormal];
        [button setTitleColor:WZColor(255, 0, 0, 1.0) forState:UIControlStateHighlighted];
        [button setImage:WZImage(@"navigationButtonReturn") forState:UIControlStateNormal];
        [button setImage:WZImage(@"navigationButtonReturnClick") forState:UIControlStateHighlighted];
        button.size = CGSizeMake(60, 40);
        //设置左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //让button内容向左移动
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//        button.backgroundColor = [UIColor redColor];
//        [button sizeToFit];
        
        
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        
        //隐藏bottomBar
        [viewController setHidesBottomBarWhenPushed:YES];
        
    }
    
    
    //如果viewController 自身设置了leftBarButtonItem ,则用自身的，没有则用上面的
    [super pushViewController:viewController animated:animated];
}


- (void)buttonAction {
    [self popViewControllerAnimated:YES];
}


@end
