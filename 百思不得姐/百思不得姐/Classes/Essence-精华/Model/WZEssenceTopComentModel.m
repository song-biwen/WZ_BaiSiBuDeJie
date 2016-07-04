//
//  WZEssenceTopComentModel.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/23.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZEssenceTopComentModel.h"
#import "WZEssenceUserModel.h"

@implementation WZEssenceTopComentModel
{
     CGFloat _cellHeight; //成员变量;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

- (CGFloat)cellHeight {
    
    if (!_cellHeight) {
        
        CGSize maxSize = CGSizeMake(WZScreenWidth - 58 - 30, MAXFLOAT);
        CGFloat commentH = [self.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:WZFont(15)} context:nil].size.height;//15为最热评论标签的高度
        _cellHeight = WZEssenceBaseCellMargin + 13 + WZEssenceBaseCellMargin + commentH + WZEssenceBaseCellMargin + 1; //13为性别高度 1 为分割线
    }
    
    return _cellHeight;
}

@end
