//
//  NSDate+WZCategory.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/16.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "NSDate+WZCategory.h"


#define WZDateFormatterStyleForLastYear @"yyyy-MM-dd HH:mm:ss"
#define WZDateFormatterStyleForThisYear @"MM-dd HH:mm:ss"
#define WZDateFormatterStyleForYesterday @"昨天 HH:mm:ss"

@implementation NSDate (WZCategory)

- (BOOL)isThisYear
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}

//- (BOOL)isToday
//{
//    // 日历
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//
//    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
//
//    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
//    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
//
//    return nowCmps.year == selfCmps.year
//    && nowCmps.month == selfCmps.month
//    && nowCmps.day == selfCmps.day;
//}

- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    return [nowString isEqualToString:selfString];
}

- (BOOL)isYesterday
{
    // 2014-12-31 23:59:59 -> 2014-12-31
    // 2015-01-01 00:00:01 -> 2015-01-01
    
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}

//跟当前的时间比较
- (NSDateComponents *)intervalFromNow {
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calender components:unit fromDate:self toDate:[NSDate date] options:0];
    return components;
}

//字符串转时间
+ (NSDate *)dateWithString:(NSString *)string {
    
    NSMutableString *mutable_string = [[NSMutableString alloc] init];
    NSArray *array = [string componentsSeparatedByCharactersInSet:[NSCharacterSet alphanumericCharacterSet]];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj length] > 0) {
            
            if (([mutable_string rangeOfString:@"yyyy"].location == NSNotFound)) {
                [mutable_string appendString:@"yyyy"];
            }
            else if (([mutable_string rangeOfString:@"MM"].location == NSNotFound)) {
                [mutable_string appendString:@"MM"];
            }
            else if (([mutable_string rangeOfString:@"dd"].location == NSNotFound)){
                [mutable_string appendString:@"dd"];
            }
            else if (([mutable_string rangeOfString:@"HH"].location == NSNotFound)){
                [mutable_string appendString:@"HH"];
            }
            else if (([mutable_string rangeOfString:@"mm"].location == NSNotFound)){
                [mutable_string appendString:@"mm"];
            }
            
            [mutable_string appendString:obj];
        }
        
    }];
    
    if (([mutable_string rangeOfString:@"ss"].location == NSNotFound)){
        [mutable_string appendString:@"ss"];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:mutable_string];
    return [dateFormatter dateFromString:string];
    
}

//比较时间
/**
今年
 {
     今天 {
         1分钟内 - 刚刚
         1小时内 - xx分钟前
         大于1小时 - XX小时前
     }
 
     昨天 {
          昨天 HH：mm：ss
     }
 
     其他{
         MM—dd HH：mm：ss
     }
 }
 
 非今年
 {
    yyyy-MM-dd HH:mm:ss
 }
 
 */

//比较时间 sender类型为NSString NSDate
+ (NSString *)intervalFromNow:(id)sender {
    
    NSString *time_string = nil;
    
    NSDate *_date;
    
    if ([sender isKindOfClass:[NSDate class]]) {
        _date = (NSDate *)sender;
    }
    
    if ([sender isKindOfClass:[NSString class]]) {
        //字符串转时间
        _date = [NSDate dateWithString:(NSString *)sender];
    }
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if ([_date isThisYear]) {//今年
        
        if ([_date isToday]) { //今天
            
            //时间组成
            NSDateComponents *components = [_date intervalFromNow];
            
            if (components.hour >= 1) { //大于等于1小时
                time_string = [NSString stringWithFormat:@"%zd小时前",components.hour];
            }
            else if (components.minute >= 1) { // 1分钟 <= 时间 < 1小时
                time_string = [NSString stringWithFormat:@"%zd分钟前",components.minute];
            }else { //1分钟内
                time_string = @"刚刚";
            }
        }
        else if ([_date isYesterday]) { //昨天
            
            [dateFormatter setDateFormat:WZDateFormatterStyleForYesterday];
            time_string = [dateFormatter stringFromDate:_date];
        }
        else { //其他
            
            [dateFormatter setDateFormat:WZDateFormatterStyleForThisYear];
            time_string = [dateFormatter stringFromDate:_date];
            
        }
        
    }else {//非今年
        
        //非今年时间的显示格式为yyyy-MM-dd HH:mm:ss
        [dateFormatter setDateFormat:WZDateFormatterStyleForLastYear];
        time_string = [dateFormatter stringFromDate:_date];
    }
    
    return time_string;
}
@end
