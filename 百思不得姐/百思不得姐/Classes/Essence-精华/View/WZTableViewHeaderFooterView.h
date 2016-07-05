//
//  WZTableViewHeaderFooterView.h
//  百思不得姐
//
//  Created by songbiwen on 16/7/5.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 自定义header footer view */
@interface WZTableViewHeaderFooterView : UITableViewHeaderFooterView
//标题
@property (nonatomic, strong) NSString *header_title;

+ (instancetype)headerFooterViewOfTableView:(UITableView *)tableView;
@end
