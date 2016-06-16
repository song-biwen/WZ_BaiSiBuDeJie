//
//  WZEssenceCell.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/16.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WZEssenceListModel;
@interface WZEssenceCell : UITableViewCell

+ (instancetype)cellOfTableView:(UITableView *)tableView;

@property (nonatomic, strong) WZEssenceListModel *listModel;

@end
