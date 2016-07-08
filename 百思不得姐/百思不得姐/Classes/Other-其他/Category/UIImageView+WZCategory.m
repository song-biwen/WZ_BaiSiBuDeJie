//
//  UIImageView+WZCategory.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/8.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "UIImageView+WZCategory.h"

@implementation UIImageView (WZCategory)

- (void)setHeader:(NSString *)url {
    
    UIImage *place_image = [WZImageDefault circleImage];
    
    [self sd_setImageWithURL:WZUrl(url) placeholderImage:place_image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : place_image;
    }];
}

@end
