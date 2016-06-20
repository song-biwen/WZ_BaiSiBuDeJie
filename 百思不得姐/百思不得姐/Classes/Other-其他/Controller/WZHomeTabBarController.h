//
//  WZHomeTabBarController.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/3.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZHomeTabBarController : UITabBarController
/** 显示登录注册页面 */
+ (void)showLoginRegisterController;

/** 使登录注册页面消失 */
+ (void)dismissLoginRegisterController;

@end
