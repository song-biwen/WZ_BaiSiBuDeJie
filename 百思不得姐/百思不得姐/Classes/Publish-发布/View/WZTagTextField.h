//
//  WZTagTextField.h
//  百思不得姐
//
//  Created by songbiwen on 16/7/15.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 添加标签textField */
@interface WZTagTextField : UITextField
@property (nonatomic, copy) void (^deleteBlock)();
@end
