//
//  WZCircleLayout.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/21.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZCircleLayout.h"

@interface WZCircleLayout ()
@property (nonatomic, strong) NSMutableArray *attrsArray;
@end
@implementation WZCircleLayout
- (void)prepareLayout {
    [super prepareLayout];
    
    //初始化
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0 ; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.size = CGSizeMake(50, 50);
    CGFloat radius = 100;
    CGFloat oX = self.collectionView.width * 0.5;
    CGFloat oY = self.collectionView.height * 0.5;
    CGFloat angle = 2 * M_PI / count;
    CGFloat centerX = oX + radius * sin(angle * indexPath.item);
    CGFloat centerY = oY + radius * cos(angle * indexPath.item);
    attrs.center = CGPointMake(centerX, centerY);
    return attrs;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(0, 0);
}

- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}
@end
