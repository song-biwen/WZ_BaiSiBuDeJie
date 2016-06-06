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
#import <AFNetworking.h>

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
    
    
    //获取数据
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
    
}

#pragma WZRecommandLeftTableViewCellDelegate
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
           [self.leftItems addObjectsFromArray:responseObject[@"list"]];
           self.selectedItem = [[NSDictionary alloc] initWithDictionary:self.leftItems.firstObject];
           
           [self fetchRigthTableViewDataWithSender:self.selectedItem[@"id"]];
           [self.left_tableView reloadData];
       }
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
    }];

}

#pragma mark - 获取右边数据
- (void)fetchRigthTableViewDataWithSender:(NSString *)sender {
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:
    @{
    @"a":@"list",
    @"c":@"subscribe",
    @"category_id":sender
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
