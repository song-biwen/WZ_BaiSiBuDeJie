//
//  WZWaterFlowLayout.h
//  百思不得姐
//
//  Created by songbiwen on 16/7/19.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WZWaterFlowLayout;
@protocol WZWaterFlowLayoutDelegate <NSObject>
@required
- (CGFloat)waterFlowLayout:(WZWaterFlowLayout *)waterFlowLayout heightForRowAtIndex:(NSUInteger)index widthOfItem:(CGFloat)width;
@optional
- (CGFloat)columnCountInwaterFlowLayout:(WZWaterFlowLayout *)waterFlowLayout;
- (CGFloat)columnMarginInwaterFlowLayout:(WZWaterFlowLayout *)waterFlowLayout;
- (CGFloat)rowMarginInwaterFlowLayout:(WZWaterFlowLayout *)waterFlowLayout;
- (UIEdgeInsets)edgeInsetsInwaterFlowLayout:(WZWaterFlowLayout *)waterFlowLayout;
@end

@interface WZWaterFlowLayout : UICollectionViewLayout
@property (nonatomic, assign) id<WZWaterFlowLayoutDelegate> delegate;
@end
