//
//  WZEssenceTopComentModel.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/23.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 最热评论Model */
@class WZEssenceUserModel;

@interface WZEssenceTopComentModel : NSObject

//用户信息
@property (nonatomic, strong) WZEssenceUserModel *user;

//语言时长
@property (nonatomic, assign) NSInteger voicetime;

//语言链接
@property (nonatomic, copy) NSString *voiceuri;

//点暂数字
@property (nonatomic, assign) NSInteger like_count;

//评论内容
@property (nonatomic, copy) NSString *content;

@end
