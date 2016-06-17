//
//  WZEssencePictureView.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/17.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WZEssenceListModel;

/** 精华-图片View */
@interface WZEssencePictureView : UIView

+ (instancetype)pictureView;

@property (nonatomic, strong) WZEssenceListModel *listModel;
@end
