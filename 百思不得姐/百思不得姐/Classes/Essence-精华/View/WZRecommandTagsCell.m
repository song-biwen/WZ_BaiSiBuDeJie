//
//  WZRecommandTagsCell.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/12.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZRecommandTagsCell.h"
#import <UIImageView+WebCache.h>
#import "WZRecommandTag.h"

@implementation WZRecommandTagsCell

+ (WZRecommandTagsCell *)cellWithTableView:(UITableView *)tableView {
    WZRecommandTagsCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}


- (void)setRecommandTag:(WZRecommandTag *)recommandTag {
    if (_recommandTag != recommandTag) {
        _recommandTag = recommandTag;
    }
    
    [self.conver_imageView setHeader:_recommandTag.image_list];
    
    self.name_label.text = _recommandTag.theme_name;
    
    NSString *sub_number = nil;
    if ([_recommandTag.sub_number intValue] < 10000) {
        sub_number = [NSString stringWithFormat:@"已有%@人订阅",_recommandTag.sub_number];
    }else {
        sub_number = [NSString stringWithFormat:@"已有%.1f万人订阅",[_recommandTag.sub_number intValue]/10000.0];
    }
    self.number_label.text = sub_number;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.line_view.backgroundColor = WZColorDefault;
    
    self.line_view.hidden = YES;//取消使用该控件，通过重写系统方法来实现，cell之间的间隙
}


//重写setFrame方法,改变cell的x width height值，实现cell之间的间隙
- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

@end
