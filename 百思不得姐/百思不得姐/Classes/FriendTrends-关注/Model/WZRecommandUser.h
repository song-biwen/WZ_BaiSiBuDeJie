//
//  WZRecommandUser.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/12.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 推荐关注-用户 */
@interface WZRecommandUser : NSObject

@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *is_vip;
@property (nonatomic, copy) NSString *fans_count;
@property (nonatomic, copy) NSString *tiezi_count;
@property (nonatomic, copy) NSString *is_follow;
@property (nonatomic, copy) NSString *screen_name;

@end

