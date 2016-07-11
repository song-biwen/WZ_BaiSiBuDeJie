//
//  WZMeViewController.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/3.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZMeViewController.h"
#import "WZMeCell.h" //cell
#import "WZMeFooterView.h" //footerView


static NSString *cellIndetifier = @"WZMeCell";

@interface WZMeViewController ()
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation WZMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
    
    //设置tablevIew
    [self setupTableView];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WZMeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = WZImage(@"setup-head-default");
    }else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WZLogFunc;
}

/** 设置tablevIew */
- (void)setupTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [tableView registerClass:[WZMeCell class] forCellReuseIdentifier:cellIndetifier];
    tableView.separatorStyle = UITableViewScrollPositionNone;
    tableView.sectionHeaderHeight = 0;
    tableView.sectionFooterHeight = WZEssenceBaseCellMargin;
    tableView.contentInset = UIEdgeInsetsMake(WZEssenceBaseCellMargin - 35, 0,0, 0);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    tableView.tableFooterView = [[WZMeFooterView alloc] init];
    tableView.height += 900;
    tableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
}


/** 设置导航栏 */
- (void)setupNav {
    /**
     备注
     1.
     self.title = @"我的关注";
     等价于
     self.navigationItem.title = @"我的关注";
     self.tabBarItem.title = @"我的关注";
     */
    
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = WZColorDefault;
    
    /*
     UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
     [button1 setBackgroundImage:WZImage(@"mine-setting-icon") forState:UIControlStateNormal];
     [button1 setBackgroundImage:WZImage(@"mine-setting-icon-click") forState:UIControlStateHighlighted];
     button1.size = button1.currentBackgroundImage.size;
     button1.tag = 1;
     [button1 addTarget:self action:@selector(buttonActionWithSender:) forControlEvents:UIControlEventTouchUpInside];
     
     UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
     [button2 setBackgroundImage:WZImage(@"mine-moon-icon") forState:UIControlStateNormal];
     [button2 setBackgroundImage:WZImage(@"mine-moon-icon-click") forState:UIControlStateHighlighted];
     button2.size = button2.currentBackgroundImage.size;
     button2.tag = 2;
     [button2 addTarget:self action:@selector(buttonActionWithSender:) forControlEvents:UIControlEventTouchUpInside];
     */
    
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImageName:@"mine-setting-icon" highlightImageName:@"mine-setting-icon-click" target:self action:@selector(settingButtonAction)];
    UIBarButtonItem *item2 = [UIBarButtonItem itemWithImageName:@"mine-moon-icon" highlightImageName:@"mine-moon-icon-click" target:self action:@selector(moonButtonAction)];
    
    self.navigationItem.rightBarButtonItems = @[item1,item2];
}

/** 设置 */
- (void)settingButtonAction {
    WZLogFunc;
}

/** 模式 */
- (void)moonButtonAction {
    WZLogFunc;
    
}

@end
