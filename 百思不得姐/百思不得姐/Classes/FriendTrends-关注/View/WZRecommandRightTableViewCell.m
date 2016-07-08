//
//  WZRecommandRightTableViewCell.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/6.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZRecommandRightTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "WZRecommandUser.h"


@implementation WZRecommandRightTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    WZRecommandRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.backgroundColor = WZColorDefault;
}


- (void)setInfo:(NSDictionary *)info {
    if (_info != info) {
        _info = info;
    }
    
    [self.avator_imageView setHeader:info[@"header"]];
    
    self.name_label.text = info[@"screen_name"];
    
    self.follow_label.text = [NSString stringWithFormat:@"%@人关注",info[@"fans_count"]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setRecommandUser:(WZRecommandUser *)recommandUser {
    if (_recommandUser != recommandUser) {
        _recommandUser = recommandUser;
    }
    
    [self.avator_imageView setHeader:recommandUser.header];
    self.name_label.text = recommandUser.screen_name;
    
    NSString *fans_count = nil;
    if ([_recommandUser.fans_count intValue] < 10000) {
        fans_count = [NSString stringWithFormat:@"%@人关注",_recommandUser.fans_count];
    }else {
        fans_count = [NSString stringWithFormat:@"%.1f万人关注",[_recommandUser.fans_count intValue]/10000.0];
    }
    self.follow_label.text = fans_count;
}
@end
