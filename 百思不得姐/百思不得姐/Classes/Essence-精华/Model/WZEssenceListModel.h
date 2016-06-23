//
//  WZEssenceListModel.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/16.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 精华分类model */
@interface WZEssenceListModel : NSObject

@property (nonatomic, copy) NSString *name;//姓名
@property (nonatomic, copy) NSString *profile_image;//头像
@property (nonatomic, copy) NSString *create_time;//时间
@property (nonatomic, copy) NSString *text;//内容
@property (nonatomic, copy) NSString *cai;//踩的数量
@property (nonatomic, copy) NSString *ding;//顶的数量
@property (nonatomic, copy) NSString *repost; //转发的数量
@property (nonatomic, copy) NSString *comment; //评论的数量
@property (nonatomic, assign) BOOL sina_v; //是否是sina用户
@property (nonatomic, assign) CGFloat height;//图片或视频等其他的内容的高度
@property (nonatomic, assign) CGFloat width; //视频或图片类型帖子的宽度
@property (nonatomic, copy) NSString *small_image; //显示在页面中的视频图片的url 小的
@property (nonatomic, copy) NSString *larger_image; // 显示在页面中的视频图片的url 大的
@property (nonatomic, copy) NSString *middle_image; // 显示在页面中的视频图片的url 中的
@property (nonatomic, assign) WZEssenceBaseType type; //帖子的类型，1为全部 10为图片 29为段子 31为音频 41为视频
@property (nonatomic, assign) BOOL is_gif; //是否是gif动画
@property (nonatomic, assign) NSInteger voicetime;//声音时长voicetime 
@property (nonatomic, assign) NSInteger videotime;//视频时长 videotime
@property (nonatomic, copy) NSString *playcount;//播放次数



/** 
 * 添加辅助参数
 */
//cell高度
@property (nonatomic, assign, readonly) CGFloat cellHeight;
//pictureView 的尺寸
@property (nonatomic, assign, readonly) CGRect pictureF;
//是否是大图
@property (nonatomic, assign, readonly) BOOL is_larger;
//图片缩放比例
@property (nonatomic, assign, readonly) CGFloat pictureScale;
//图片下载进度
@property (nonatomic, assign) CGFloat pictureProgress;

//voiceView 的尺寸
@property (nonatomic, assign, readonly) CGRect voiceF;

//videoView 的尺寸
@property (nonatomic, assign, readonly) CGRect videoF;
@end
