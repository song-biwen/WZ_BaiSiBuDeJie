//
//  WZVerticalButton.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/13.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZVerticalButton.h"

@implementation WZVerticalButton

//代码构建button
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setUp];
}

//xib构建button
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //重写图片
    self.imageView.x = self.scale > 0 ? (self.width - self.width * self.scale)* 0.5: 0;
    self.imageView.y = 0;
    self.imageView.width = self.scale > 0 ? self.width * self.scale : self.width;
    self.imageView.height = self.imageView.width;
    
    //重写标题
    self.titleLabel.x = 0;
    self.titleLabel.top = self.imageView.bottom;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.bottom;
}

//属性设置
- (void)setUp {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
@end
