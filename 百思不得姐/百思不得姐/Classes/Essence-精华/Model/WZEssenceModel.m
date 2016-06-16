//
//  WZEssenceModel.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/16.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZEssenceModel.h"

@implementation WZEssenceModel
- (NSMutableArray *)lists {
    if (!_lists) {
        _lists = [NSMutableArray array];
    }
    return _lists;
}
@end
