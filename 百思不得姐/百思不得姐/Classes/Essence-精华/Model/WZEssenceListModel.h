//
//  WZEssenceListModel.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/16.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZEssenceListModel : NSObject

@property (nonatomic, copy) NSString *name;//姓名
@property (nonatomic, copy) NSString *profile_image;//头像
@property (nonatomic, copy) NSString *create_time;//时间
@property (nonatomic, copy) NSString *text;//内容
@property (nonatomic, copy) NSString *cai;//踩的数量
@property (nonatomic, copy) NSString *ding;//顶的数量
@property (nonatomic, copy) NSString *repost; //转发的数量
@property (nonatomic, copy) NSString *comment; //评论的数量

@end
