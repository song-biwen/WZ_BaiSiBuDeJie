//
//  WZWaterFlowLayout.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/19.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZWaterFlowLayout.h"

//默认列数
static const NSInteger WZWaterFlowColumnCount = 3;
//每一列的间距
static const CGFloat WZWaterFlowColumnMargin = 10;
//每一行的间距
static const CGFloat WZWaterFlowRowMargin = 10;
//内间距
static const UIEdgeInsets WZWaterFlowEdgeInsets = {10,10,10,10};

@interface WZWaterFlowLayout ()
//属性数组
@property (nonatomic, strong) NSMutableArray *attsArray;
//每列的高度数组
@property (nonatomic, strong) NSMutableArray *heightArray;

//最短的那列
@property (nonatomic, assign) CGFloat contentHeight;

- (CGFloat)columnCount;
- (CGFloat)columnMargin;
- (CGFloat)rowMargin;
- (UIEdgeInsets)edgeInsets;

@end

@implementation WZWaterFlowLayout

- (CGFloat)columnCount {
    if ([self.delegate respondsToSelector:@selector(columnCountInwaterFlowLayout:)]) {
        return [self.delegate columnCountInwaterFlowLayout:self];
    }
    return WZWaterFlowColumnCount;
}


- (CGFloat)columnMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginInwaterFlowLayout:)]) {
        return [self.delegate columnMarginInwaterFlowLayout:self];
    }
    return WZWaterFlowColumnMargin;
}

- (CGFloat)rowMargin {
    if ([self.delegate respondsToSelector:@selector(rowMarginInwaterFlowLayout:)]) {
        return [self.delegate rowMarginInwaterFlowLayout:self];
    }
    return WZWaterFlowRowMargin;
}

- (UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInwaterFlowLayout:)]) {
        return [self.delegate edgeInsetsInwaterFlowLayout:self];
    }
    return WZWaterFlowEdgeInsets;
}


- (NSMutableArray *)heightArray {
    if (!_heightArray) {
        _heightArray = [NSMutableArray array];
    }
    return _heightArray;
}
- (NSMutableArray *)attsArray {
    if (!_attsArray) {
        _attsArray = [NSMutableArray array];
    }
    return _attsArray;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    WZLogFunc;
    self.contentHeight = 0;
    
    [self.heightArray removeAllObjects];
    for (int i = 0; i < self.columnCount; i ++) {
        [self.heightArray addObject:@(self.edgeInsets.top)];
    }
    
    //初始化属性数组
    [self.attsArray removeAllObjects];
    NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < itemsCount;i ++) {
        UICollectionViewLayoutAttributes *atts = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [self.attsArray addObject:atts];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
//    WZLogFunc;
    return self.attsArray;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    WZLogFunc;
    
    UICollectionViewLayoutAttributes *atts = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewW = self.collectionView.width;
    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    CGFloat h = [self.delegate waterFlowLayout:self heightForRowAtIndex:indexPath.row widthOfItem:w];
    
    //选择高度最小的那列，获取列数 高度
    NSInteger column = 0;
    CGFloat height = [self.heightArray[column] doubleValue];
    
    for (NSInteger i = 1; i < self.columnCount; i ++) {
        CGFloat currentHeight = [self.heightArray[i] doubleValue];
        if (currentHeight < height) {
            height = currentHeight;
            column = i;
        }
    }
    
    CGFloat x = self.edgeInsets.left + column * (w +  self.columnMargin);
    CGFloat y = height;
    if (y != self.edgeInsets.top) {
        y = y + self.rowMargin;
    }
    
    atts.frame = CGRectMake(x, y, w, h);
    
    self.heightArray[column] = @(CGRectGetMaxY(atts.frame));
    if (self.contentHeight < [self.heightArray[column] doubleValue]) {
        self.contentHeight = [self.heightArray[column] doubleValue];
    }
    return atts;
}

- (CGSize)collectionViewContentSize {
    
//    WZLogFunc;
    CGFloat height = self.contentHeight;
    height += self.edgeInsets.bottom;
    return CGSizeMake(0, height);
}
@end
