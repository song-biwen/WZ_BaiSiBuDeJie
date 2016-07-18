//
//  WZLoginTool.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/18.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZLoginTool.h"
#import "WZLoginRegisterViewController.h" //登录注册


#define WZUID @"uid"

@implementation WZLoginTool

/** 保存用户登录id */

+ (void)saveUid:(NSString *)uid {
    [[NSUserDefaults standardUserDefaults] setObject:uid forKey:WZUID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


/** 获取登录用户的id */
+ (NSString *)getUid {
    
    return [WZLoginTool getUid:NO];
}

+ (NSString *)getUid:(BOOL)shouldPresentLogin {
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:WZUID];
    
    if (shouldPresentLogin) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[WZLoginRegisterViewController alloc] init] animated:YES completion:nil];
        });
        
    }
    return uid;
}
@end
