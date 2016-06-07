//
//  WZRecommendViewController.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/6.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZRecommendViewController.h"
#import "WZRecommandLeftTableViewCell.h" //推荐关注-左边 cell
#import "WZRecommandRightTableViewCell.h" //推荐关注-右边cell
//2.0版本
#import "WZRecommandLeft2TableViewCell.h" //推荐关注-左边cell
#import "WZRecommandType.h" // 推荐关注，左边数据model
#import <AFNetworking.h>
#import <MJExtension.h>



static NSString *const leftIdentifierCell = @"WZRecommandLeft2TableViewCell";

@interface WZRecommendViewController ()
<WZRecommandLeftTableViewCellDelegate>

//左列
@property (nonatomic, strong) NSMutableArray *leftItems;
//右列
@property (nonatomic, strong) NSMutableArray *rightItems;
//key_value对
@property (nonatomic, strong) NSMutableArray *items;


@property (nonatomic, strong) NSDictionary *selectedItem;
@property (nonatomic, strong) UIButton *selected_button;

@end

@implementation WZRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐关注";
    self.view.backgroundColor = WZColorDefault;
    self.left_tableView.backgroundColor = WZColorDefault;
    self.right_tableView.backgroundColor = WZColorDefault;
    
    self.leftItems = [NSMutableArray array];
    self.rightItems = [NSMutableArray array];
    self.items = [NSMutableArray array];
    
    //设置inset解决两个tablevIew偏移量不同问题
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.left_tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.right_tableView.contentInset = self.left_tableView.contentInset;
    
    //获取左边列表数据
    [self fetchLeftTableViewData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rowCount = 0;
    
    if (tableView.tag == 1) {
        rowCount = self.leftItems.count;
    }
    if (tableView.tag == 2) {
        rowCount = self.rightItems.count;
    }
    
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id tableCell = nil;
    if (tableView.tag == 1) {
        
        /*
        NSDictionary *info = self.leftItems[indexPath.row];
        
        WZRecommandLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WZRecommandLeftTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"WZRecommandLeftTableViewCell" owner:self options:nil] lastObject];
        }
        
        cell.delegate = self;
        [cell setInfo:info];
        cell.item_button.tag = indexPath.row;
        cell.item_button.selected = [info isEqualToDictionary:self.selectedItem];
        if (cell.item_button.selected) {
            self.selected_button = cell.item_button;
        }
         */
        
        
        //2.0版本
        
        WZRecommandLeft2TableViewCell *cell = [WZRecommandLeft2TableViewCell cellWithTableView:tableView];
        cell.recommandType = self.leftItems[indexPath.row];
        
        tableCell = cell;
    }
    
    //WZRecommandRightTableViewCell
    if (tableView.tag == 2) {
        
        NSDictionary *info = self.rightItems[indexPath.row];
        
        WZRecommandRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WZRecommandRightTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"WZRecommandRightTableViewCell" owner:self options:nil] lastObject];
        }
        
        [cell setInfo:info];
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
         模拟网速慢的时候
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self fetchRigthTableViewDataWithSender:self.leftItems[indexPath.row]];
        });
         */
        
    }
}

#pragma WZRecommandLeftTableViewCellDelegate 2.0版本时取消使用
- (void)buttonClickForWZRecommandLeftTableViewCellWithSender:(UIButton *)button {
    
    NSUInteger tag = button.tag;
    
    NSDictionary *info = self.leftItems[tag];
    if (![info isEqualToDictionary:self.selectedItem]) {
        
        //取消上一个选中按钮
        self.selected_button.selected = NO;
        self.selectedItem = [[NSDictionary alloc] initWithDictionary:info];
        button.selected = YES;
        self.selected_button = button;
        
        [self fetchRigthTableViewDataWithSender:self.selectedItem[@"id"]];
    }
}

#pragma mark - 获取左边数据
- (void)fetchLeftTableViewData {
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:
    @{
    @"a":@"category",
    @"c":@"subscribe"
    }
    progress:^(NSProgress * _Nonnull downloadProgress) {
       
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
//       WZLog(@"%@",responseObject);
       if ([responseObject[@"list"] isKindOfClass:[NSArray class]] && [(NSArray *)responseObject[@"list"] count] > 0) {
           
           /*
           [self.leftItems addObjectsFromArray:responseObject[@"list"]];
           self.selectedItem = [[NSDictionary alloc] initWithDictionary:self.leftItems.firstObject];
           
           [self fetchRigthTableViewDataWithSender:self.selectedItem[@"id"]];
            */
           
           //2.0版本
           self.leftItems = [WZRecommandType mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
           [self.left_tableView reloadData];
           [self.left_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
           [self fetchRigthTableViewDataWithSender:self.leftItems.firstObject];
       }
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
    }];

}

#pragma mark - 获取右边数据
- (void)fetchRigthTableViewDataWithSender:(id)sender {
    
    NSString *category_id = nil;
    if ([sender isKindOfClass:[NSString class]]) {
        category_id = sender;
    }
    
    if ([sender isKindOfClass:[WZRecommandType class]]) {
        category_id = [(WZRecommandType *)sender id];
    }
    
    if (category_id.length == 0) return;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:
    @{
    @"a":@"list",
    @"c":@"subscribe",
    @"category_id":category_id
    }
    progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

    WZLog(@"%@",responseObject);
    if ([responseObject[@"list"] isKindOfClass:[NSArray class]] && [(NSArray *)responseObject[@"list"] count] > 0) {
       [self.rightItems removeAllObjects];
       [self.rightItems addObjectsFromArray:responseObject[@"list"]];
       [self.right_tableView reloadData];
    }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}


@end
