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
    CGFloat h = (item / 6 == 0 || item % 6 == 5) ? w : w * 0.5;
    CGFloat x = 0;
    CGFloat y = 0;
    
//    ;
//    x = (indexPath.item / 3 == 0 || (indexPath.item / 3 > 0 && indexPath.item % 3 == 1)) ? 0 : w;
//    y = 0;
    
    if (item > 0) {
        UICollectionViewLayoutAttributes *lastAttrs = self.attrsArray[item - 1];
        CGFloat lastH = lastAttrs.frame.size.height;
        CGFloat lastX = lastAttrs.frame.origin.x;
        CGFloat lastY = lastAttrs.frame.origin.y;
        
        if (h == w) {
            x = lastX == 0 ? w : 0;
            y = (item / 3) * h;
        }
        else if (lastH == w && lastX == 0) {
            h = lastH * 0.5;
            x = w;
            y = lastY;
            
        }else if (item % 3 == 0) {
            h = lastH;
            x = 0;
            y = (item / 3) * h;
        }else {
            h = lastH;
            x = lastX;
            y = CGRectGetMaxY(lastAttrs.frame);
        }
    }
    
    attrs.frame = CGRectMake(x, y, w, h);
    return attrs;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(0, 1000);
}
@end
