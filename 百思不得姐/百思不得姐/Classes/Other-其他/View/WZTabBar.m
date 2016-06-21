//
//  WZTabBar.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/3.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZTabBar.h"
#import "WZPublishViewController.h"
#import "WZPublishView.h" //发布view

@implementation WZTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        
        //设置背景图片
        [self setBackgroundImage:WZImage(@"tabbar-light")];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:WZImage(@"tabBar_publish_icon") forState:UIControlStateNormal];
        [button setBackgroundImage:WZImage(@"tabBar_publish_click_icon") forState:UIControlStateHighlighted];
        button.size = button.currentBackgroundImage.size;
        [button addTarget:self action:@selector(publishButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.publishButton = button;
        
        [self addSubview:self.publishButton];
        
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    self.publishButton.center = CGPointMake(width/2.0, height/2.0);
    
    CGFloat x_value = 0;
    CGFloat y_value = 0;
    CGFloat H_value = height;
    CGFloat W_value = width/5.0;
    NSInteger index = 0;
    
    for (UIView *view in self.subviews) {
        
        if (![view isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        x_value = W_value * (index > 1 ? (index + 1) : index);
        view.frame = CGRectMake(x_value, y_value, W_value, H_value);
        index ++ ;
    }
}


/** 发布按钮点击 */
- (void)publishButtonAction {
    
//    WZPublishViewController *publishVc = [[WZPublishViewController alloc] init];
//    
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVc animated:NO completion:nil];
    
    
    //2.0 可实现背景半透明效果
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    WZPublishView *publishView = [WZPublishView publishView];
    publishView.frame = window.bounds;
    [window.rootViewController.view addSubview:publishView];
    
    //3.0
//    [WZPublishView show];
}

@end
