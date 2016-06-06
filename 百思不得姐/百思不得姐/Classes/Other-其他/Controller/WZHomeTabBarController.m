//
//  WZHomeTabBarController.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/3.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZHomeTabBarController.h"
#import "WZEssenceViewController.h"
#import "WZNewViewController.h"
#import "WZPublishViewController.h"
#import "WZFriendTrendsViewController.h"
#import "WZMeViewController.h"
#import "WZTabBar.h"
#import "WZNavigationController.h"


@interface WZHomeTabBarController ()

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

@end
