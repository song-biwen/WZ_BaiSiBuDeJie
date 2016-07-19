//
//  WZWaterFlowCell.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/19.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZWaterFlowCell.h"
#import "WZShopModel.h" //model

@interface WZWaterFlowCell ()
//图片
@property (weak, nonatomic) IBOutlet UIImageView *cover_imageView;
//价格
@property (weak, nonatomic) IBOutlet UILabel *price_label;
@end
@implementation WZWaterFlowCell

- (void)setShopModel:(WZShopModel *)shopModel {
    _shopModel = shopModel;
    
    [self.cover_imageView sd_setImageWithURL:WZUrl(shopModel.img)];
    self.price_label.text = shopModel.price;
}
@end
