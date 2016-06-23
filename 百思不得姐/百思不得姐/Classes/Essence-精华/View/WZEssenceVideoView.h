//
//  WZEssenceVideoView.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/23.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WZEssenceListModel;
/** 视频 */
@interface WZEssenceVideoView : UIView

+ (instancetype)videoView;

@property (nonatomic, strong) WZEssenceListModel *listModel;

@end
