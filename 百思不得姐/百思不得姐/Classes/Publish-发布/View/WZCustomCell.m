//
//  WZCustomCell.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/20.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZCustomCell.h"

@interface WZCustomCell ()

@property (weak, nonatomic) IBOutlet UIImageView *corver_imageView;


@property (weak, nonatomic) IBOutlet UILabel *label;
@end
@implementation WZCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImageName:(NSString *)imageName {
    _imageName = [imageName copy];
    self.corver_imageView.image = [UIImage imageNamed:imageName];
    self.label.text = imageName;
}

@end
