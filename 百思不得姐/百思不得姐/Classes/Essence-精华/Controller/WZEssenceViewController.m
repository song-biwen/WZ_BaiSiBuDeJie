//
//  WZEssenceViewController.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/3.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZEssenceViewController.h"
#import "WZRecommandTagsViewController.h" //推荐关注
#import "WZEssenceAllController.h"//全部
#import "WZEssenceVideoController.h" //视频
#import "WZEssenceVoiceController.h" //声音
#import "WZEssencePictureController.h" //图片
#import "WZEssenceWordController.h"  //段子


@interface WZEssenceViewController ()
<UIScrollViewDelegate>

//指示器
@property (nonatomic, weak) UIView *line_view;
//当前选中的按钮
@property (nonatomic, weak) UIButton *selectedButton;
//顶部的titleView
@property (nonatomic, weak) UIView *title_view;
//内容
@property (nonatomic, weak) UIScrollView *content_View;

@end

@implementation WZEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = WZImageView(@"MainTitle");
    self.view.backgroundColor = WZColorDefault;
    
    //设置导航栏
    [self setupNav];
    //设置titleView
    [self setupTitleView];
    
    //设置子控制器
    [self setupChildViewControllers];
    
    //设置contentView
    [self setupContentView];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
    UITableViewController *tableViewController = [self.childViewControllers objectAtIndex:index];
    
    CGFloat top = self.title_view.bottom;
    CGFloat bottom = self.tabBarController.tabBar.height;
    tableViewController.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    tableViewController.tableView.x = scrollView.contentOffset.x;
    tableViewController.tableView.y = 0; //默认y = 20，手动修改为0
    tableViewController.tableView.height = scrollView.height; //设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    tableViewController.tableView.scrollIndicatorInsets = tableViewController.tableView.contentInset; //设置滚动条内边距
    
    [scrollView addSubview:tableViewController.tableView];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
    UIButton *button = (UIButton *)[self.title_view viewWithTag:index + 1];
    [self changeAction:button];
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 按钮点击->推荐标签 */
- (void)buttonAction {
    WZLogFunc;
    
    WZRecommandTagsViewController *VC = [[WZRecommandTagsViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}


/** 切换视图 */
- (void)changeAction:(UIButton *)sender {
    
    self.selectedButton.enabled = YES;
    sender.enabled = NO;
    [self changeLineViewCenterX:sender];
    
    CGPoint currentPoint = self.content_View.contentOffset;
    [self.content_View setContentOffset:CGPointMake(self.content_View.width * (sender.tag - 1), currentPoint.y) animated:YES];
}

/** 改变指示器centerX的位置 */
- (void)changeLineViewCenterX:(UIButton *)selectedButton {
    
    self.selectedButton = selectedButton;

    [UIView animateWithDuration:0.25 animations:^{
         self.line_view.width = selectedButton.titleLabel.width;
         self.line_view.centerX = selectedButton.centerX;
    }];
}

/** 添加自控制器 */
- (void)addChildViewControllerWithSender:(NSString *)className {
    Class class = NSClassFromString(className);
    [self addChildViewController:[[class alloc] init]];
}

/** 
  设置子控制器
 */
- (void)setupChildViewControllers {
    
    [self addChildViewControllerWithSender:NSStringFromClass([WZEssenceAllController class])];
    [self addChildViewControllerWithSender:NSStringFromClass([WZEssenceVideoController class])];
    [self addChildViewControllerWithSender:NSStringFromClass([WZEssenceVoiceController class])];
    [self addChildViewControllerWithSender:NSStringFromClass([WZEssencePictureController class])];
    [self addChildViewControllerWithSender:NSStringFromClass([WZEssenceWordController class])];
}

/** 设置ContentView */
- (void)setupContentView {
    
    //取消自动偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.width * self.childViewControllers.count, scrollView.height);
    self.content_View = scrollView;
    
    [self.view insertSubview:scrollView atIndex:0];
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 设置titleView */
- (void)setupTitleView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 40)];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    self.title_view = titleView;
    [self.view addSubview:titleView];
    
    //指示器
    UIView *line_view = [[UIView alloc] init];
    line_view.height = 2;
    line_view.y = titleView.height - line_view.height;
    line_view.backgroundColor = [UIColor redColor];
    self.line_view = line_view;
    [titleView addSubview:line_view];
    
    //设置里面切换item
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSUInteger title_count = titles.count;
    CGFloat width = self.view.width * 1.0 / title_count;
    CGFloat height = titleView.height;
    for (int i = 0; i < title_count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i + 1;
        button.frame = CGRectMake(width * i, 0, width, height);
        button.titleLabel.font = WZFont(14);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [button addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [titleView addSubview:button];
        
        //设置第一个按钮的选择按钮
        if (i == 0) {
            button.enabled = NO;
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            line_view.width = button.titleLabel.width;
            line_view.centerX = button.centerX;
            
            self.selectedButton = button;
        }
    }
}

/** 设置导航栏 */
- (void)setupNav {
    
    /**
     UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
     [button setBackgroundImage:WZImage(@"MainTagSubIcon") forState:UIControlStateNormal];
     [button setBackgroundImage:WZImage(@"MainTagSubIconClick") forState:UIControlStateHighlighted];
     button.size = button.currentBackgroundImage.size;
     [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
     
     */
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" highlightImageName:@"MainTagSubIconClick" target:self action:@selector(buttonAction)];
}



@end
