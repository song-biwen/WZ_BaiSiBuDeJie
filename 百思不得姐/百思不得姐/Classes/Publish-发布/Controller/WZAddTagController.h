//
//  WZAddTagController.h
//  百思不得姐
//
//  Created by songbiwen on 16/7/15.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 添加标签 */
@interface WZAddTagController : UIViewController

@property (nonatomic, copy) void (^addTagsBlock)(NSArray *tags);

@property (nonatomic, strong) NSArray *tags;

@end
