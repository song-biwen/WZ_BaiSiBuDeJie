//
//  WZEssenceListModel.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/16.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZEssenceListModel.h"
#import <MJExtension.h>
#import "WZEssenceTopComentModel.h" //最热评论
#import "WZEssenceUserModel.h" //用户信息


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

//将数组里面的字典按照相应的model解析
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"top_cmt":@"WZEssenceTopComentModel"};
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
            
            if (pictureH >= WZEssenceBaseCellPictureMaxHeight) {
                //是大图
                //图片高度比例
                _pictureScale = WZEssenceBaseCellPictureDefaultHeight / pictureH;
                
                pictureH = WZEssenceBaseCellPictureDefaultHeight;
                _is_larger = YES;
            }
            
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellHeight += pictureH + WZEssenceBaseCellMargin;
        }
        
        if (self.type == WZEssenceBaseTypeVoice) {
            //声音
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width + WZEssenceBaseCellMargin;
            CGFloat voiceX = WZEssenceBaseCellMargin;
            CGFloat voiceY = _cellHeight;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + WZEssenceBaseCellMargin;
        }
        
        if (self.type == WZEssenceBaseTypeVideo) {
            //视频
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            CGFloat videoX = WZEssenceBaseCellMargin;
            CGFloat videoY = _cellHeight;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + WZEssenceBaseCellMargin;
        }
        
        //最热评论
        if (self.top_cmt.count > 0) {
            
            WZEssenceTopComentModel *commentModel = self.top_cmt.firstObject;
            WZEssenceUserModel *userModel = commentModel.user;
            
            CGFloat topCommentX = WZEssenceBaseCellMargin;
            CGFloat topCommentY = _cellHeight;
            CGFloat topCommentW = maxSize.width;
            
            NSString *comment = [NSString stringWithFormat:@"%@：%@",userModel.username,commentModel.content];
            _top_comment = comment;
            CGFloat topCommentH = [comment boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:WZFont(12)} context:nil].size.height + 15;//15为最热评论标签的高度
            
            _topCommentViewF = CGRectMake(topCommentX, topCommentY, topCommentW, topCommentH);
            _cellHeight += topCommentH + WZEssenceBaseCellMargin;
            
        }
        
        //底部高度
        CGFloat bottomViewH = WZEssenceBaseCellBottomHeight;
        _cellHeight += bottomViewH + WZEssenceBaseCellMargin;
        
    }
    return _cellHeight;
}
@end
