//
//  WZTagTextField.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/15.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZTagTextField.h"

@implementation WZTagTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.placeholder = @"多个标签用逗号或换行分隔";
        self.font = WZFont(14);
        self.returnKeyType = UIReturnKeyNext;
        self.height = WZTagHeight;
        self.width = WZScreenWidth;
    }
    return self;
}

- (void)deleteBackward {
    
    !self.deleteBlock ?: self.deleteBlock();
    [super deleteBackward];
}

@end
