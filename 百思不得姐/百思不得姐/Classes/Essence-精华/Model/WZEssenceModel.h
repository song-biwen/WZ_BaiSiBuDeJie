//
//  WZEssenceModel.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/16.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 精华model */
@interface WZEssenceModel : NSObject
//总数量
@property (nonatomic, assign) NSInteger count;
//页数
@property (nonatomic, assign) NSInteger page;
//当前页数
@property (nonatomic, assign) NSInteger current_page;

@property (nonatomic, copy) NSString *maxtime;

@property (nonatomic, strong) NSMutableArray *lists;
@end
