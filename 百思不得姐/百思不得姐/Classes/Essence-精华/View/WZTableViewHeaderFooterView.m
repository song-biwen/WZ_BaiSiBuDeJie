//
//  WZTableViewHeaderFooterView.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/5.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZTableViewHeaderFooterView.h"

@interface WZTableViewHeaderFooterView ()
@property (nonatomic, strong) UILabel *header_label;
@end

@implementation WZTableViewHeaderFooterView

+ (instancetype)headerFooterViewOfTableView:(UITableView *)tableView {
    WZTableViewHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(self)];
    if (headerFooterView == nil) {
        headerFooterView = [[WZTableViewHeaderFooterView alloc] initWithReuseIdentifier:NSStringFromClass(self)];
    }
    return headerFooterView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = WZColorDefault;
        
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor lightGrayColor];
        label.font = WZFont(14);
        label.x = WZEssenceBaseCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.width = 100;
        [self.contentView addSubview:label];
        
        self.header_label = label;
    }
    return self;
}


- (void)setHeader_title:(NSString *)header_title {
    _header_title = header_title;
    self.header_label.text = header_title;
}
@end
