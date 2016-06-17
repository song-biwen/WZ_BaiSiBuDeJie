//
//  WZRecommandTag.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/12.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 推荐标签model */
@interface WZRecommandTag : NSObject
@property (nonatomic, copy) NSString *theme_id;
@property (nonatomic, copy) NSString *theme_name;
@property (nonatomic, copy) NSString *image_list;
@property (nonatomic, copy) NSString *sub_number;
@property (nonatomic, copy) NSString *is_sub;
@property (nonatomic, copy) NSString *is_default;
@end
