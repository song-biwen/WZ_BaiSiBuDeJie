//
//  WZCommentCell.h
//  百思不得姐
//
//  Created by songbiwen on 16/7/4.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 评论 */
@class WZEssenceTopComentModel;

@interface WZCommentCell : UITableViewCell

+ (instancetype)cellOfTableView:(UITableView *)tableView;

@property (nonatomic, strong) WZEssenceTopComentModel *comentModel;

@end
