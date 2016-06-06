//
//  WZRecommandRightTableViewCell.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/6.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZRecommandRightTableViewCell.h"
#import <UIImageView+WebCache.h>


@implementation WZRecommandRightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _avator_imageView.layer.borderWidth = 1.0;
    _avator_imageView.layer.borderColor = [UIColor clearColor].CGColor;
    _avator_imageView.layer.cornerRadius = _avator_imageView.width/2.0;
    _avator_imageView.clipsToBounds = YES;
    self.contentView.backgroundColor = WZColorDefault;
}


- (void)setInfo:(NSDictionary *)info {
    if (_info != info) {
        _info = info;
    }
    
    [self.avator_imageView sd_setImageWithURL:[NSURL URLWithString:info[@"header"]]];
    self.name_label.text = info[@"screen_name"];
    self.follow_label.text = [NSString stringWithFormat:@"%@人关注",info[@"fans_count"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
