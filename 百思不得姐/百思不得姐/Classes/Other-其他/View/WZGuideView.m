//
//  WZGuideView.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/15.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZGuideView.h"

@implementation WZGuideView

+ (instancetype)guideView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

//引导页显示
+ (void)show {
    NSString *key = @"CFBundleShortVersionString";
    //当前版本号
    NSString *currentVersion = [[NSBundle mainBundle].infoDictionary objectForKey:key];
    //沙盒里面版本
    NSString *sandboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (![currentVersion isEqualToString:sandboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        WZGuideView *guideView = [WZGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        
        //立即存储
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

//引导页消失
- (IBAction)cancelAction:(id)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        [self removeFromSuperview];
    }];
}
@end
