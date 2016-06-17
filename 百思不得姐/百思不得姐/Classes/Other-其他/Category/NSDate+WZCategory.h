//
//  NSDate+WZCategory.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/16.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WZCategory)

//是否是当年
- (BOOL)isThisYear;

//是否是当天
- (BOOL)isToday;

//是否是昨天
- (BOOL)isYesterday;

//跟当前的时间比较
- (NSDateComponents *)intervalFromNow;

//字符串转时间
+ (NSDate *)dateWithString:(NSString *)string;

//比较时间 sender类型为NSString NSDate
+ (NSString *)intervalFromNow:(id)sender;
@end


