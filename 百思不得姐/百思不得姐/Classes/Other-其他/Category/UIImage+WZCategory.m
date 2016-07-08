//
//  UIImage+WZCategory.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/8.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "UIImage+WZCategory.h"

@implementation UIImage (WZCategory)

- (UIImage *)circleImage
{
    // NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGFloat width = self.size.width < self.size.height ? self.size.width: self.size.height;
    CGFloat height = width;
    CGRect rect = CGRectMake(0, 0, width, height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 将图片画上去
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


@end
