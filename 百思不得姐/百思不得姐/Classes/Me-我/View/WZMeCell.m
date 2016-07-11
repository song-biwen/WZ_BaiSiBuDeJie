//
//  WZMeCell.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/11.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZMeCell.h"

@implementation WZMeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //设置背景图片
        self.backgroundView = [[UIImageView alloc] initWithImage:WZImage(@"mainCellBackground")];
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = WZFont(16);
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.imageView.image) {
        self.textLabel.x = WZEssenceBaseCellMargin;
        return;
    }
    self.imageView.width = 35;
    self.imageView.height = self.imageView.width;
    self.imageView.x = WZEssenceBaseCellMargin;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + WZEssenceBaseCellMargin;
}
@end
