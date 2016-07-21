//
//  WZCollectionViewLayout.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/20.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZCollectionViewLayout.h"

@interface WZCollectionViewLayout ()
@property (nonatomic, strong) NSMutableArray *attrsArray;

@property (nonatomic, assign) CGFloat contentHeight; //内容高度
@end

@implementation WZCollectionViewLayout

- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    self.contentHeight = 0;
    //属性数组初始化
    [self.attrsArray removeAllObjects];
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < itemCount; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return _attrsArray;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSInteger item = indexPath.item;
    CGFloat collectionViewW = self.collectionView.width;
    CGFloat w = collectionViewW * 0.5;
    CGFloat h = w; //默认
    CGFloat x = 0;
    CGFloat y = 0;
    
    if (item > 0) {
        
        NSInteger lastItem = item - 1;
        UICollectionViewLayoutAttributes *lastAttrs = self.attrsArray[lastItem];
        CGFloat lastH = lastAttrs.frame.size.height;
        CGFloat lastX = lastAttrs.frame.origin.x;
        CGFloat lastY = lastAttrs.frame.origin.y;
        
        
        if (item % 3 == 0) {
            x = 0;
            y = CGRectGetMaxY(lastAttrs.frame);
            h = lastH;
        }
        
        else if (item % 3 == 1) {
            if (lastH == w) {
                h = lastH * 0.5;
                x = CGRectGetMaxX(lastAttrs.frame);
                y = lastY;
            }else {
                h = lastH;
                x = lastX;
                y = CGRectGetMaxY(lastAttrs.frame);
            }
        }
        
        else if (item % 3 == 2) {
            if (lastX == w) {
                h = lastH;
                x = lastX;
                y = CGRectGetMaxY(lastAttrs.frame);
            }else {
                h = lastH * 2;
                x = CGRectGetMaxX(lastAttrs.frame);
                y = (item / 3) * w;
            }
        }
        
    }
    
    attrs.frame = CGRectMake(x, y, w, h);
    
    if (self.contentHeight < CGRectGetMaxY(attrs.frame)) {
        self.contentHeight = CGRectGetMaxY(attrs.frame);
    }
    
    return attrs;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(0, self.contentHeight);
}
@end
