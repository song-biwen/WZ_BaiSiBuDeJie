//
//  WZEssenceVideoView.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/23.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZEssenceVideoView.h"
#import "WZEssenceListModel.h"
#import "WZShowImageViewController.h" //图片

@interface WZEssenceVideoView()
//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *corver_imageView;


//播放次数
@property (weak, nonatomic) IBOutlet UILabel *playCount_label;



//播放时长
@property (weak, nonatomic) IBOutlet UILabel *playTime_label;

@end
@implementation WZEssenceVideoView

+ (instancetype)videoView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    //点击图片查看大图
    self.corver_imageView.userInteractionEnabled = YES;
    [self.corver_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigImage)]];
}

//显示大图
- (void)showBigImage {
    
    WZShowImageViewController *showImageVC = [[WZShowImageViewController alloc] init];
    showImageVC.listModel = self.listModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showImageVC animated:YES completion:nil];
    
}

- (void)setListModel:(WZEssenceListModel *)listModel {
    _listModel = listModel;
    
    [self.corver_imageView sd_setImageWithURL:WZUrl(listModel.larger_image)];
    self.playCount_label.text = [NSString stringWithFormat:@"%@播放",listModel.playcount];
    NSInteger voiceTime = listModel.videotime;
    NSInteger hour = voiceTime/(60 * 60);
    voiceTime = voiceTime % (60 * 60);
    NSInteger minute = voiceTime/60;
    NSInteger second = voiceTime % 60;
    
    if (hour > 0) {
        self.playTime_label.text = [NSString stringWithFormat:@"%02zd:%02zd:%02zd",hour,minute,second];
    }else {
        self.playTime_label.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    }
}

@end
