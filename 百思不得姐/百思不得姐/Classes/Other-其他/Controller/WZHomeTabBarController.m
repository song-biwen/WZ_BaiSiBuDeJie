//
//  WZHomeTabBarController.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/3.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZHomeTabBarController.h"
#import "WZEssenceViewController.h" //精华
#import "WZNewViewController.h" //最新
#import "WZPublishViewController.h"
#import "WZFriendTrendsViewController.h" //关注
#import "WZMeViewController.h" //我
#import "WZTabBar.h"
#import "WZNavigationController.h"
#import "WZLoginRegisterViewController.h" //登录注册


@interface WZHomeTabBarController ()
<UITabBarControllerDelegate>

//当前视图控制器
@property (nonatomic, strong) UIViewController *currentViewController;

//登录注册
@property (nonatomic, strong) WZLoginRegisterViewController *loginRegisterVc;

@end

@implementation WZHomeTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    /** 备注 
        1.后面带有 UI_APPEARANCE_SELECTOR  字段的方法名 可以通过统一设置属性
     */
    
    /** 统一设置tabbarItem的文字属性 */
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:WZFont(12)} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:WZFont(12)} forState:UIControlStateSelected];
    
    
    /** 创建子视图 */
    [self configueViewWithViewController:[[WZEssenceViewController alloc] init] tabBarItemWithTitile:@"精华" withImageName:@"tabBar_essence_icon" withSelectedImageName:@"tabBar_essence_click_icon"];
    
    [self configueViewWithViewController:[[WZNewViewController alloc] init] tabBarItemWithTitile:@"新帖" withImageName:@"tabBar_new_icon" withSelectedImageName:@"tabBar_new_click_icon"];
    
//    [self configueViewWithViewController:[[WZPublishViewController alloc] init] tabBarItemWithTitile:nil withImageName:@"tabBar_publish_icon" withSelectedImageName:@"tabBar_publish_click_icon"];
    
    [self configueViewWithViewController:[[WZFriendTrendsViewController alloc] init] tabBarItemWithTitile:@"关注" withImageName:@"tabBar_friendTrends_icon" withSelectedImageName:@"tabBar_friendTrends_click_icon"];
    
    [self configueViewWithViewController:[[WZMeViewController alloc] init] tabBarItemWithTitile:@"我" withImageName:@"tabBar_me_icon" withSelectedImageName:@"tabBar_me_click_icon"];
    
    /** 利用KVC替换掉系统的tabbar */
    [self setValue:[[WZTabBar alloc] init] forKeyPath:@"tabBar"];
    
    self.delegate = self;
}



- (void)configueViewWithViewController:(UIViewController *)VC tabBarItemWithTitile:(NSString *)title withImageName:(NSString *)imageName withSelectedImageName:(NSString *)selectedImageName {
    
    /** 
      1.随机数函数arc4random_uniform（x），可以用来产生0～(x-1)范围内的随机数
      2.这样会提前创建视图 即项目启动时，把【VC viewDidLoad】全部都走一遍
      VC.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
     */
    
    /** 设置tabbarItem的标题 颜色 字体大小 */
    VC.tabBarItem.title = title;
    
    /*
     被取代
     
     [VC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:WZFont(12)} forState:UIControlStateNormal];
     [VC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:WZFont(12)} forState:UIControlStateSelected];
     */
   
    
    
    /** 设置tabbarItem的图片 */
    /** 
        在IB里直接设置图片的renderModel之后，取代
        
     VC.tabBarItem.image = [WZImage(imageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     VC.tabBarItem.selectedImage = [WZImage(selectedImageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     */
    
    VC.tabBarItem.image = WZImage(imageName);
    VC.tabBarItem.selectedImage = WZImage(selectedImageName);
    
    WZNavigationController *nav = [[WZNavigationController alloc] initWithRootViewController:VC];
    [self addChildViewController:nav];
    
}

/** 显示登录注册页面 */
+ (void)showLoginRegisterController {
    
    WZLoginRegisterViewController *loginRegisterVC = [[WZLoginRegisterViewController alloc] init];
    WZNavigationController *nav = [[WZNavigationController alloc] initWithRootViewController:loginRegisterVC];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}

/** 使登录注册页面消失 */
+ (void)dismissLoginRegisterController {
    
    WZLog(@"%@",[UIApplication sharedApplication].keyWindow.rootViewController);
    
}

- (UIViewController *)currentViewController {
    if (!_currentViewController) {
        
        UIViewController *currentVC = nil;
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        if(window.windowLevel != UIWindowLevelNormal)
        {
            NSArray *windows = [[UIApplication sharedApplication] windows];
            for(UIWindow *tmpWin in windows)
            {
                if(tmpWin.windowLevel == UIWindowLevelNormal)
                {
                    window = tmpWin;
                    break;
                }
            }
        }
        
        NSArray *viewsArray = [window subviews];
        if([viewsArray count] > 0)
        {
            
            UIView *frontView = [viewsArray objectAtIndex:0];
            
            id nextResponder = [frontView nextResponder];
            
            if([nextResponder isKindOfClass:[UIViewController class]])
            {
                currentVC = nextResponder;
            }
            else
            {
                currentVC = window.rootViewController;
            }
        }
        
        _currentViewController = currentVC;
    }
    
    return _currentViewController;
}


- (WZLoginRegisterViewController *)loginRegisterVc {
    if (!_loginRegisterVc) {
        _loginRegisterVc = [[WZLoginRegisterViewController alloc] init];
    }
    return _loginRegisterVc;
}

#pragma  mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}
@end
