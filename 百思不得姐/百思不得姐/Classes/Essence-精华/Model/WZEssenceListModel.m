//
//  WZEssenceListModel.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/16.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZEssenceListModel.h"
#import <MJExtension.h>


@implementation WZEssenceListModel
{
    CGFloat _cellHeight; //成员变量
    CGRect _pictureF; //pictureView 的尺寸
    BOOL _is_larger; //是否是大图
}

//用属性字段替换接口返回数据相应字段
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"small_image":@"image0",
             @"larger_image":@"image1",
             @"middle_image":@"image2"
             };
}

////用属性字段替换接口返回数据相应字段
//+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
//    
//    if ([propertyName isEqualToString:@"small_image"]) return @"image0";
//    if ([propertyName isEqualToString:@"larger_image"]) return @"image1";
//    if ([propertyName isEqualToString:@"middle_image"]) return @"image2";
//    
//    return propertyName;
//}


//在model里面计算cell高度，实现cell上下滚动，重复计算cell的问题
- (CGFloat)cellHeight {
    
    
    if (!_cellHeight) {
//        WZLogFunc;
        
        //顶部高度
        CGFloat topViewH = WZEssenceBaseCellTopHeight;
        _cellHeight += topViewH + WZEssenceBaseCellMargin;
        
        //消息高度
        CGSize maxSize = CGSizeMake(WZScreenWidth - 4 * WZEssenceBaseCellMargin, MAXFLOAT);
        CGFloat messageViewH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:WZFont(14)} context:nil].size.height;
        _cellHeight += messageViewH + WZEssenceBaseCellMargin;
        
        
        if (self.type == WZEssenceBaseTypePicture) {
            //图片
            CGFloat pictureW = maxSize.width;
            CGFloat pictureH = pictureW * self.height / self.width;
            CGFloat pictureX = WZEssenceBaseCellMargin;
            CGFloat pictureY = _cellHeight;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            if (pictureH > WZScreenHeight) {
                //是大图
                pictureH = pictureW;
                _is_larger = YES;
            }
            
            _cellHeight += pictureH + WZEssenceBaseCellMargin;
        }
        
        
        //底部高度
        CGFloat bottomViewH = WZEssenceBaseCellBottomHeight;
        _cellHeight += bottomViewH + WZEssenceBaseCellMargin;
        
    }
    return _cellHeight;
}
@end
