//
//  WZRecommandLeft2TableViewCell.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/7.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WZRecommandType;

@interface WZRecommandLeft2TableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) WZRecommandType *recommandType;

//左边红色view
@property (weak, nonatomic) IBOutlet UIView *leftView;
@end
