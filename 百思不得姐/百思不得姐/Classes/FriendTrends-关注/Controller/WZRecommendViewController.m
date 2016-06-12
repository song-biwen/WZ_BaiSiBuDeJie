//
//  WZRecommendViewController.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/6.
//  Copyright © 2016年 songbiwen. All rights reserved.
// 1.解决重复请求问题
// 2.网络慢带来的细节问题

#import "WZRecommendViewController.h"
#import "WZRecommandLeftTableViewCell.h" //推荐关注-左边 cell
#import "WZRecommandRightTableViewCell.h" //推荐关注-右边cell
//2.0版本
#import "WZRecommandLeft2TableViewCell.h" //推荐关注-左边cell
#import "WZRecommandType.h" // 推荐关注，左边数据model
#import "WZRecommandUser.h" // 推荐关注，右边数据model
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import <SVProgressHUD.h>



static NSString *const leftIdentifierCell = @"WZRecommandLeft2TableViewCell";
#define KSelectedType [self.leftItems objectAtIndex:self.left_tableView.indexPathForSelectedRow.row]

@interface WZRecommendViewController ()
//左列
@property (nonatomic, strong) NSMutableArray *leftItems;

//请求参数 - 解决多次切换leftTablevIew请求问题
@property (nonatomic, strong) NSDictionary *parameter;

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation WZRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐关注";
    self.view.backgroundColor = WZColorDefault;
    self.left_tableView.backgroundColor = WZColorDefault;
    self.right_tableView.backgroundColor = WZColorDefault;
    
    self.leftItems = [NSMutableArray array];
    
    //设置inset解决两个tablevIew偏移量不同问题
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.left_tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.right_tableView.contentInset = self.left_tableView.contentInset;
    
    //集成刷新
    [self setupRefresh];
    //获取左边列表数据
    [self fetchLeftTableViewData];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rowCount = 0;
    
    NSInteger left_count = self.leftItems.count;
    if (left_count > 0) {
        
        if (tableView.tag == 1) {
            rowCount = left_count;
        }
        
        if (tableView.tag == 2) {
            rowCount = [KSelectedType current_count];
            [self checkFooterStatus];
        }
    }
    
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id tableCell = nil;
    if (tableView.tag == 1) {
        //2.0版本
        
        WZRecommandLeft2TableViewCell *cell = [WZRecommandLeft2TableViewCell cellWithTableView:tableView];
        cell.recommandType = self.leftItems[indexPath.row];
        
        tableCell = cell;
    }
    
    //WZRecommandRightTableViewCell
    if (tableView.tag == 2 && (indexPath.row < [KSelectedType current_count])) {
        
        WZRecommandRightTableViewCell *cell = [WZRecommandRightTableViewCell cellWithTableView:tableView];
        cell.recommandUser = [KSelectedType list][indexPath.row];
        tableCell = cell;
    }
    
    return tableCell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat row_height = 44;
    if (tableView.tag == 2) {
        row_height = 60;
    }
    return row_height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 1) {
        /*
         //模拟网速慢的时候
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //2.0解决重复发送请求的问题
            //结束刷新
            [self.right_tableView.mj_footer endRefreshing];
            [self.right_tableView.mj_header endRefreshing];
            self.parameter = nil;
            
            if ([KSelectedType current_count] > 0) {
                //显示之前的数据
                [self.right_tableView reloadData];
            }else {
                //解决切换时，数据没有及时更新的问题
                [self.right_tableView reloadData];
                [self.right_tableView.mj_header beginRefreshing];
            }
        });
        */
        
        //2.0解决重复发送请求的问题
        //结束刷新
        [self.right_tableView.mj_footer endRefreshing];
        [self.right_tableView.mj_header endRefreshing];
        self.parameter = nil;
        
        if ([KSelectedType current_count] > 0) {
            //显示之前的数据
            [self.right_tableView reloadData];
        }else {
            //解决切换时，数据没有及时更新的问题
            [self.right_tableView reloadData];
            [self.right_tableView.mj_header beginRefreshing];
        }
        
    }
}

#pragma mark - 获取左边数据
- (void)fetchLeftTableViewData {
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:
    @{
    @"a":@"category",
    @"c":@"subscribe"
    }
    progress:^(NSProgress * _Nonnull downloadProgress) {
       
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
//       WZLog(@"%@",responseObject);
       if ([responseObject[@"list"] isKindOfClass:[NSArray class]] && [(NSArray *)responseObject[@"list"] count] > 0) {
           
           //2.0版本
           self.leftItems = [WZRecommandType mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
           [self.left_tableView reloadData];
           [self.left_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
           
           //下拉刷新
           [self.right_tableView.mj_header beginRefreshing];
       }
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
    }];

}

#pragma mark - 获取右边数据
- (void)fetchRigthTableViewDataWithHeaderRefresh:(BOOL)isHeaderRefresh {
    
//    WZLogFunc;
    
    //获取选择的左边model
    WZRecommandType *recommandType = KSelectedType;
    if (isHeaderRefresh) {
        recommandType.current_page = 1;
    }
    
    NSDictionary *parameter = @{
                                @"a":@"list",
                                @"c":@"subscribe",
                                @"category_id":[recommandType id],
                                @"page":@(recommandType.current_page)
                                };
    
    self.parameter = parameter;
    
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameter
    
    progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

//    WZLog(@"%@",responseObject);
        
        if ([responseObject[@"list"] isKindOfClass:[NSArray class]] && [(NSArray *)responseObject[@"list"] count] > 0) {
            
            if (isHeaderRefresh) {
                [recommandType.list removeAllObjects];
            }
            [recommandType.list addObjectsFromArray:[WZRecommandUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        }
        
        recommandType.total = [responseObject[@"total"] integerValue];
        recommandType.current_count = recommandType.list.count;
        
        if (recommandType.current_count < recommandType.total) {
            recommandType.current_page ++;
        }
        
        //解决多次切换请求,不是最后一次请求
        if (self.parameter != parameter) return;
        
        [self.right_tableView reloadData];
        
        [self checkFooterStatus];
        [self.right_tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self checkFooterStatus];
        [self.right_tableView.mj_header endRefreshing];
        
        //解决多次切换请求问题
        if (self.parameter != parameter) return;
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        
    }];
}


#pragma mark - 集成刷新
- (void)setupRefresh {
    
    self.right_tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.right_tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}

#pragma mark - 下拉刷新
- (void)headerRefresh {
    [self fetchRigthTableViewDataWithHeaderRefresh:YES];
}

#pragma mark - 上拉刷新
- (void)footerRefresh {
    [self fetchRigthTableViewDataWithHeaderRefresh:NO];
}

#pragma mark - 检查footer状态
- (void)checkFooterStatus {
    
    WZRecommandType *recommandType = KSelectedType;
    self.right_tableView.mj_footer.hidden = recommandType.current_count == 0;
    
    if (recommandType.current_count < recommandType.total) {
        [self.right_tableView.mj_footer endRefreshing];
    }else {
        [self.right_tableView.mj_footer endRefreshingWithNoMoreData];
    }
    
}

#pragma mark - 正在请求数据时，退出当前控制器,导致控制器销毁
- (void)dealloc {
    //取消网络请求
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
