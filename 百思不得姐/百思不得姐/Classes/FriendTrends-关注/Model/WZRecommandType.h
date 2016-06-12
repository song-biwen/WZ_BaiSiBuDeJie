//
//  WZRecommandType.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/7.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**推荐关注 - 左边数据model */
@interface WZRecommandType : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *name;

//右边推荐用户
@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger current_page;
@property (nonatomic, assign) NSInteger current_count;

@end
