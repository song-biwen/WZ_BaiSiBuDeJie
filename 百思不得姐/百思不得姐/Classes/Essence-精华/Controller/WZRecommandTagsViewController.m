//
//  WZRecommandTagsViewController.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/12.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZRecommandTagsViewController.h"
#import "WZRecommandTag.h" //推荐标签model
#import "WZRecommandTagsCell.h" //推荐标签cell
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface WZRecommandTagsViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation WZRecommandTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐标签";
    self.view.backgroundColor = WZColorDefault;
    
    self.dataSource = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    
    //获取列表数据
    [self fetchTableViewData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WZRecommandTagsCell *cell = [WZRecommandTagsCell cellWithTableView:tableView];
    cell.recommandTag = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)fetchTableViewData {
    
    NSDictionary *parameter = @{
                                @"a":@"tag_recommend",
                                @"action":@"sub",
                                @"c":@"topic"
                                };
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WZLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSArray class]] && [(NSArray *)responseObject count] > 0) {
            [self.dataSource addObjectsFromArray:[WZRecommandTag mj_objectArrayWithKeyValuesArray:responseObject]];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = WZColorDefault;
    }
    return _tableView;
}
@end
