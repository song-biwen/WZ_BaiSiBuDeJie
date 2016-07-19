//
//  WZWaterFlowController.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/19.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZWaterFlowController.h"
#import "WZWaterFlowLayout.h" //瀑布流
#import "WZWaterFlowCell.h" //cell
#import "WZShopModel.h" //model

static NSString *const cellIdentifier = @"WZWaterFlowCell";

@interface WZWaterFlowController ()
<UICollectionViewDataSource,WZWaterFlowLayoutDelegate,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
//数据
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation WZWaterFlowController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"瀑布流";
    
    [self setUpNav];
    //设置collectionView
    [self setUpCollectionView];
    //设置刷新控件
    [self setUpRefresh];
}

- (void)headerRefresh {
    [self loadingDataWithHeaderRefresh:YES];
}

- (void)footerRefresh {
    [self loadingDataWithHeaderRefresh:NO];
}

- (void)loadingDataWithHeaderRefresh:(BOOL)isHeaderRefresh {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (isHeaderRefresh) {
            [self.dataSource removeAllObjects];
        }
        
        [self.dataSource addObjectsFromArray:[WZShopModel mj_objectArrayWithFilename:@"1.plist"]];
        [self.collectionView reloadData];
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    });
}


//设置刷新控件
- (void)setUpRefresh {
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    self.collectionView.mj_footer.hidden = !self.dataSource.count;
}

- (void)backAction {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

/** 初始化nav */
- (void)setUpNav {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:WZFont(14)} forState:UIControlStateNormal];
}

/** 设置collectionView */
- (void)setUpCollectionView {
    
    //定义collectionView的布局对象
    WZWaterFlowLayout *layout = [[WZWaterFlowLayout alloc] init];
    layout.delegate = self;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WZWaterFlowCell class]) bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    
    self.collectionView = collectionView;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    self.collectionView.mj_footer.hidden = !self.dataSource.count;
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WZWaterFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.shopModel = self.dataSource[indexPath.row];
    cell.backgroundColor = [UIColor brownColor];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WZShopModel *shopModel = self.dataSource[indexPath.row];
    WZLog(@"...%@...%@",shopModel.img,shopModel.price);
}
#pragma mark - WZWaterFlowLayoutDelegate
- (CGFloat)waterFlowLayout:(WZWaterFlowLayout *)waterFlowLayout heightForRowAtIndex:(NSUInteger)index widthOfItem:(CGFloat)width {
    WZShopModel *shopModel = self.dataSource[index];
    return width * shopModel.h / shopModel.w;
}
@end
