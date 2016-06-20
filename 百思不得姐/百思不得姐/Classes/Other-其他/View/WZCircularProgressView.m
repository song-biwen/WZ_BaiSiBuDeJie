//
//  WZCircularProgressView.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/20.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZCircularProgressView.h"

@implementation WZCircularProgressView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.progressLabel.textColor = [UIColor whiteColor];
    self.roundedCorners = 2.0;
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}
@end
