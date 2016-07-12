//
//  WZCollectionViewCell.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/12.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZCollectionViewCell.h"
#import "WZMeModel.h"
#import "WZVerticalButton.h"

@interface WZCollectionViewCell ()

@property (nonatomic, strong) WZVerticalButton *button;

@end

@implementation WZCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        WZVerticalButton *button = [WZVerticalButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height);
        button.scale = 0.5;
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        self.button = button;
    }
    
    return self;
}

- (void)setContentModel:(WZMeModel *)contentModel {
    _contentModel = contentModel;
    
    self.button.meModel = contentModel;
}

- (void)buttonAction:(WZVerticalButton *)button {
    WZLogFunc;
    WZLog(@"%@",button.meModel.name);
}
@end
