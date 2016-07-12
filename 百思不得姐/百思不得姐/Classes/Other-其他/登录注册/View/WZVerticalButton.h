//
//  WZVerticalButton.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/13.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

/** button 图片与文字竖直排列 */
@class WZMeModel;
@interface WZVerticalButton : UIButton
/** 
 图片的宽度占父视图的比例 scale 0 ~ 1
 */
@property (nonatomic, assign) CGFloat scale;

@property (nonatomic, strong) WZMeModel *meModel;
@end
