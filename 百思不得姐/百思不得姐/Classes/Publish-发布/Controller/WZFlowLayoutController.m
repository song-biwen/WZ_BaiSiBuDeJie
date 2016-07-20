//
//  WZFlowLayoutController.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/20.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZFlowLayoutController.h"
#import "WZFlowLayout.h" //水平布局
#import "WZCollectionViewLayout.h" //混合布局
#import "WZCustomCell.h"//cell

static NSString *const cellIdentifier = @"Cell";

@interface WZFlowLayoutController ()
<UICollectionViewDataSource>
@end

@implementation WZFlowLayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpNav];
    [self setUpCollectionView];
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
    
//    //定义collectionView的布局对象
//    WZFlowLayout *layout = [[WZFlowLayout alloc] init];
//    layout.itemSize = CGSizeMake(100, 100);
//    // 创建CollectionView
//    CGFloat collectionW = self.view.frame.size.width;
//    CGFloat collectionH = 200;
//    CGRect frame = CGRectMake(0, 150, collectionW, collectionH);
//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
//    collectionView.dataSource = self;
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
//    [self.view addSubview:collectionView];

    
    WZCollectionViewLayout *layout = [[WZCollectionViewLayout alloc] init];
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WZCustomCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([WZCustomCell class])];
    [self.view addSubview:collectionView];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WZCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WZCustomCell class]) forIndexPath:indexPath];
    cell.imageName = [NSString stringWithFormat:@"%zd",indexPath.item + 1];
    return cell;
    
}
@end
