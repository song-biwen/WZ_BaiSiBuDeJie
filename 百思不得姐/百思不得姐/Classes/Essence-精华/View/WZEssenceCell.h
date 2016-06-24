//
//  WZEssenceCell.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/16.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WZEssenceListModel;

/** 精华cell */
@interface WZEssenceCell : UITableViewCell

+ (instancetype)cell;

+ (instancetype)cellOfTableView:(UITableView *)tableView;

/** cell 高度 */
+ (CGFloat)heightOftableViewCell:(WZEssenceListModel *)model;

//数据model
@property (nonatomic, strong) WZEssenceListModel *listModel;
@end
