//
//  WZEssencePictureView.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/17.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZEssencePictureView.h"
#import "WZEssenceListModel.h" //数据model
#import "WZCircularProgressView.h" //加载进度

@interface WZEssencePictureView()

//图片
@property (weak, nonatomic) IBOutlet UIImageView *picture_imageView;

//GIF图标
@property (weak, nonatomic) IBOutlet UIImageView *gif_imageView;

//点击查看大图按钮
@property (weak, nonatomic) IBOutlet UIButton *bigButton;

//加载进度
@property (weak, nonatomic) IBOutlet WZCircularProgressView *progress_view;

@end
@implementation WZEssencePictureView

+ (instancetype)pictureView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setListModel:(WZEssenceListModel *)listModel {
    _listModel = listModel;
    
    
    [self.picture_imageView sd_setImageWithURL:WZUrl(_listModel.larger_image) placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progress_view.hidden= NO;
        [self.progress_view setProgress:receivedSize * 1.0 / expectedSize animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progress_view.hidden = YES;
        
    }];
    
    //方法1
//    self.gif_imageView.hidden = !_listModel.is_gif;
    
    //方法2
//    NSString *pathExtension = _listModel.larger_image.pathExtension;
//    self.gif_imageView.hidden = ![pathExtension.lowercaseString isEqualToString:@"gif"];
    
    //方法3 在不知道图片扩展名的情况下，知道图片的类型？实现方法：取出图片数据的第一个字节，就可以判断出图片的真实类型
    NSData *data = [NSData dataWithContentsOfURL:WZUrl(_listModel.larger_image)];
    NSString *image_type = [NSData sd_contentTypeForImageData:data];
    self.gif_imageView.hidden = ![image_type isEqualToString:@"image/gif"];
    
    self.bigButton.hidden = !_listModel.is_larger;
    
    
    if (_listModel.is_larger) {
        
        self.bigButton.hidden = NO; //显示点击查看大图
        self.picture_imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.picture_imageView.layer.contentsRect = CGRectMake(0, 0, 1, _listModel.pictureScale); //按比例显示图片的上部分
        
    }else {
        
        self.bigButton.hidden = YES;
        self.picture_imageView.contentMode = UIViewContentModeScaleToFill;
        self.picture_imageView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //设置改属性，解决内容不随
    self.autoresizingMask = UIViewAutoresizingNone;
    
}
@end
