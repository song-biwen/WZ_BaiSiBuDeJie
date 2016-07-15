//
//  WZTagButton.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/15.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZTagButton.h"

@implementation WZTagButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        [self setImage:WZImage(@"chose_tag_close_icon") forState:UIControlStateNormal];
        self.backgroundColor = WZColorTagDefault;
    }
    return self;
}


- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    self.width += 3 * WZTagMargin;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = WZTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + WZTagMargin;
}
@end
