//
//  WZRecommandTagsCell.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/12.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WZRecommandTag;

@interface WZRecommandTagsCell : UITableViewCell
+ (WZRecommandTagsCell *)cellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UIImageView *conver_imageView;

@property (weak, nonatomic) IBOutlet UILabel *name_label;

@property (weak, nonatomic) IBOutlet UILabel *number_label;

@property (weak, nonatomic) IBOutlet UIButton *order_button;

//2.0取消该控件
@property (weak, nonatomic) IBOutlet UIView *line_view;

@property (nonatomic, strong) WZRecommandTag *recommandTag;
@end

/** 
 "theme_id": "163",
 "theme_name": "生活百科",
 "image_list": "http:%/%/img.spriteapp.cn%/ugc%/2015%/04%/23%/160559_24190.jpg",
 "sub_number": "36871",
 "is_sub": 0,
 "is_default": 0
 */
