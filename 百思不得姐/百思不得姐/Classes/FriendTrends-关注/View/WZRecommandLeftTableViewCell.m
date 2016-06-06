//
//  WZRecommandLeftTableViewCell.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/6.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZRecommandLeftTableViewCell.h"

@implementation WZRecommandLeftTableViewCell

- (void)setInfo:(NSDictionary *)info {
    if (_info != info) {
        _info = info;
    }
    
    [_item_button setTitle:_info[@"name"] forState:UIControlStateNormal];
    [_item_button setTitle:_info[@"name"] forState:UIControlStateSelected];
}

- (IBAction)buttonAction:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(buttonClickForWZRecommandLeftTableViewCellWithSender:)]) {
        [_delegate buttonClickForWZRecommandLeftTableViewCellWithSender:button];
    }
}

@end
