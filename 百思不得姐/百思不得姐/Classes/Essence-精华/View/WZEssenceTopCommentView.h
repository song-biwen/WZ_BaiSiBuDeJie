//
//  WZEssenceTopCommentView.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/23.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 最热评论 */
@class WZEssenceListModel;
@interface WZEssenceTopCommentView : UIView

+ (instancetype)topCommentView;

@property (nonatomic, strong) WZEssenceListModel *listModel;

@end
