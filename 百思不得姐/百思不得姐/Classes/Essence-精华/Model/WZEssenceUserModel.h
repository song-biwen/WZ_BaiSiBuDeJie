//
//  WZEssenceUserModel.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/23.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 用户Model */
@interface WZEssenceUserModel : NSObject
//头像
@property (nonatomic, copy) NSString *profile_image;

//用户名
@property (nonatomic, copy) NSString *username;

//性别
@property (nonatomic, copy) NSString *sex;

@end
