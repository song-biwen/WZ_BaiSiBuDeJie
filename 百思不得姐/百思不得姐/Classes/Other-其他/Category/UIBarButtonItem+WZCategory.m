//
//  UIBarButtonItem+WZCategory.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/3.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "UIBarButtonItem+WZCategory.h"

@implementation UIBarButtonItem (WZCategory)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName target:(id)target action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (imageName.length > 0) {
        [button setBackgroundImage:WZImage(imageName) forState:UIControlStateNormal];
    }
    
    if (highlightImageName.length > 0) {
        [button setBackgroundImage:WZImage(highlightImageName) forState:UIControlStateHighlighted];
    }
    
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}
@end
