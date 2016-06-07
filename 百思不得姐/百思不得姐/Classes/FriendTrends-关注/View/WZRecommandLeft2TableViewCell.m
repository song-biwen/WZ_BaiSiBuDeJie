//
//  WZRecommandLeft2TableViewCell.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/7.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZRecommandLeft2TableViewCell.h"
#import "WZRecommandType.h"

@implementation WZRecommandLeft2TableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    WZRecommandLeft2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : WZColorDefault;
    self.textLabel.textColor = selected ? [UIColor redColor] : [UIColor darkGrayColor];
    self.leftView.hidden = !selected;
    
}

-(void)setRecommandType:(WZRecommandType *)recommandType {
    _recommandType = recommandType;
    self.textLabel.text = _recommandType.name;
}

@end
