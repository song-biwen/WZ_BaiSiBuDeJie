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
#import "WZMeModel.h" //model
#import "WZCollectionViewCell.h" //collectioncell


static NSString *cellIndetifier = @"WZMeCell";
static NSString *collectionCellIndetifier = @"CollectionCell";

#define WZMax_clos 4
#define CollectionViewW WZScreenWidth / WZMax_clos
#define CollectionViewH CollectionViewW

@interface WZMeViewController ()
<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *lists;
@end

@implementation WZMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
    
    //设置tablevIew
    [self setupTableView];
    
    //加载数据
    [self loadingData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
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
    else if (indexPath.section == 2) {
        //定义collectionView的布局对象
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //定义collectionview的信息 NSUInteger rows = (square_list.count + max_clos - 1) / max_clos;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WZScreenWidth, (self.lists.count + WZMax_clos - 1) / WZMax_clos * CollectionViewH) collectionViewLayout:layout];
        //加上tag之,为了更好的实现collcetionview的代理方法 collectionView.tag = 899;
        collectionView.bounces = NO;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        //注册单元格
        [collectionView registerClass:[WZCollectionViewCell class] forCellWithReuseIdentifier:collectionCellIndetifier];
        [cell.contentView addSubview:collectionView];
        
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return (self.lists.count + WZMax_clos - 1) / WZMax_clos * CollectionViewH + 1;
    }else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WZLogFunc;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.lists.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WZCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellIndetifier forIndexPath:indexPath];
    cell.contentModel = self.lists[indexPath.row];
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WZLogFunc;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(CollectionViewW, CollectionViewH);
}

- (void)loadingData {
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    parameter[@"a"] = @"square";
    parameter[@"c"] = @"topic";
    WZLog(@"%@",parameter);
    
    [[AFHTTPSessionManager manager] GET:WZUrlDefault parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //            [responseObject writeToFile:@"/Users/songbiwen/Desktop/Me.plist" atomically:YES];
        
        if ([responseObject isKindOfClass:[NSDictionary class]] && [[(NSDictionary *)responseObject allKeys]  containsObject:@"square_list"]) {
            NSArray *square_list = [WZMeModel mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            self.lists = [NSMutableArray arrayWithArray:square_list];
            
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
    }];
    
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
//    tableView.tableFooterView = [[WZMeFooterView alloc] init];//显示不完整
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
