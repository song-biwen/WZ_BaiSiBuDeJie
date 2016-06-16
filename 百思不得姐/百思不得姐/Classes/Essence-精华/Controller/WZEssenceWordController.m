//
//  WZEssenceWordController.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/15.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZEssenceWordController.h"
#import "WZEssenceCell.h" //cell

#import "WZEssenceModel.h" //模型
#import "WZEssenceListModel.h" //列表数据模型

@interface WZEssenceWordController ()
//网络请求
@property (nonatomic, strong) AFHTTPSessionManager *manager;
//数据模型
@property (nonatomic, strong) WZEssenceModel *essenseModel;

//上一次的请求参数 - 解决多次切换leftTablevIew请求问题
@property (nonatomic, strong) NSDictionary *parameter;
@end

@implementation WZEssenceWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = WZColorDefault;
    
    //集成刷新控件
    [self setupRefresh];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.mj_footer.hidden = self.essenseModel.lists.count == 0;
    return self.essenseModel.lists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    WZEssenceCell *cell = [WZEssenceCell cellOfTableView:tableView];
    cell.listModel = self.essenseModel.lists[indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - 加载数据
- (void)loadDataWithHeaderRefresh:(BOOL)isHeaderRefresh {
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    parameter[@"a"] = @"list";
    parameter[@"c"] = @"data";
    parameter[@"type"] = @"29";
    parameter[@"page"] = isHeaderRefresh ? @(0): @(self.essenseModel.current_page);
    parameter[@"maxtime"] = isHeaderRefresh ? @"": self.essenseModel.maxtime;
    
    self.parameter = parameter;
    
    WZLog(@"%@",parameter);
    
    [[AFHTTPSessionManager manager] GET:KURLPrePath parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        WZLog(@"%@",responseObject);
        //多次请求已最后一次请求为准
        if (self.parameter != parameter) return;
        
        if (isHeaderRefresh) {
            
            [self.essenseModel.lists removeAllObjects];
            self.essenseModel.current_page = 0;
            //字典转模型
            self.essenseModel = [WZEssenceModel mj_objectWithKeyValues:responseObject[@"info"]];
        }
        
        
        self.essenseModel.maxtime = responseObject[@"info"][@"maxtime"];
        //数组转模型
        [self.essenseModel.lists addObjectsFromArray:[WZEssenceListModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        
        if (self.essenseModel.lists.count < self.essenseModel.count) {
            self.essenseModel.current_page ++;
        }
        
        //改变刷新控件状态
        [self changeRefreshStatus];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //多次请求已最后一次请求为准
        if (self.parameter != parameter) return;
        
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        
        //改变刷新控件状态
        [self changeRefreshStatus];
    }];
}


//取消上拉下拉加载状态
- (void)changeRefreshStatus {
    
    if (self.essenseModel.lists.count < self.essenseModel.count) {
        [self.tableView.mj_footer endRefreshing];
    }else {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - 集成控件

//集成控件
- (void)setupRefresh {
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    /** 根据拖拽比例自动切换透明度 */
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //加载数据
    [self.tableView.mj_header beginRefreshing];
}

//下拉加载新数据
- (void)headerRefresh {
    [self loadDataWithHeaderRefresh:YES];
}

//上拉加载更多
- (void)footerRefresh {
    [self loadDataWithHeaderRefresh:NO];
}

/** 
 * 在页面消失的时候，取消网络请求
 */
- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
    self.parameter = nil;
    
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
    
}
@end
