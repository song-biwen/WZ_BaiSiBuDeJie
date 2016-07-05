//
//  WZTopWindow.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/5.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZTopWindow.h"

@implementation WZTopWindow
static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, WZScreenWidth, 20)];
    window_.windowLevel = UIWindowLevelAlert;
    window_.backgroundColor = [UIColor redColor];
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+ (void)show
{
    window_.hidden = NO;
}

+ (void)hide
{
    window_.hidden = YES;
}

/**
 * 监听窗口点击
 */
+ (void)windowClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superview
{
    
    for (UIScrollView *subview in superview.subviews) {
        
        // 主窗口
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        
        // 以主窗口左上角为坐标原点, 计算self的矩形框
        CGRect newFrame = [keyWindow convertRect:subview.frame fromView:superview];
        CGRect winBounds = keyWindow.bounds;
        
        // 主窗口的bounds 和 self的矩形框 是否有重叠
        BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
        
        BOOL isShowingOnKeyWindow = !subview.isHidden && subview.alpha > 0.01 && subview.window == keyWindow && intersects;
        
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        // 继续查找子控件
        [self searchScrollViewInView:subview];
    }
}

@end
