//
//  WZEssencePictureView.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/17.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZEssencePictureView.h"
#import "WZEssenceListModel.h" //数据model

@interface WZEssencePictureView()

//图片
@property (weak, nonatomic) IBOutlet UIImageView *picture_imageView;

//GIF图标
@property (weak, nonatomic) IBOutlet UIImageView *gif_imageView;

//点击查看大图按钮
@property (weak, nonatomic) IBOutlet UIButton *bigButton;
@end
@implementation WZEssencePictureView

+ (instancetype)pictureView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setListModel:(WZEssenceListModel *)listModel {
    _listModel = listModel;
    
    
    [self.picture_imageView sd_setImageWithURL:WZUrl(_listModel.larger_image)];
    self.gif_imageView.hidden = !_listModel.is_gif;
    self.bigButton.hidden = !_listModel.is_larger;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //设置改属性，解决内容不随
    self.autoresizingMask = UIViewAutoresizingNone;
    
}
@end
