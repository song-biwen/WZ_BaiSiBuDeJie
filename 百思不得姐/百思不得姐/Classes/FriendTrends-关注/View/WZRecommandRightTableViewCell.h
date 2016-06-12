//
//  WZRecommandRightTableViewCell.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/6.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WZRecommandUser;

/** 推荐关注-右边列表 */
@interface WZRecommandRightTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UIImageView *avator_imageView;
@property (weak, nonatomic) IBOutlet UIButton *follow_button;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *follow_label;

@property (nonatomic, strong) NSDictionary *info;
//2.0版本
@property (nonatomic, strong) WZRecommandUser *recommandUser;

@end
