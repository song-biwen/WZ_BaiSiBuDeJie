//
//  WZLoginTool.h
//  百思不得姐
//
//  Created by songbiwen on 16/7/18.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZLoginTool : NSObject

/** 保存用户登录id */

+ (void)saveUid:(NSString *)uid;

/** 获取登录用户的id */
+ (NSString *)getUid;

+ (NSString *)getUid:(BOOL)shouldPresentLogin;
@end
