//
//  WZEssenceVoiceView.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/23.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZEssenceVoiceView.h"
#import "WZEssenceListModel.h"

@interface WZEssenceVoiceView ()
//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *corver_imageView;


//播放次数
@property (weak, nonatomic) IBOutlet UILabel *playCount_label;



//播放时长
@property (weak, nonatomic) IBOutlet UILabel *playTime_label;

@end


@implementation WZEssenceVoiceView

+ (instancetype)voiceView {
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
    // 1.创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    NSArray *arr = @[self.listModel.larger_image];
    
    // 2.设置图片浏览器显示的所有图片
    NSMutableArray *photos = [NSMutableArray array];
    int count = (int)arr.count;
    for (int i = 0; i <count; i++){
        
        NSString *orurl=[arr objectAtIndex:i];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = WZUrl(orurl);
        //设置来源于哪一个UIImageView
        photo.srcImageView = self.corver_imageView;
        
        [photos addObject:photo];
    }
    
    browser.photos = photos;
    
    // 3.设置默认显示的图片索引
    browser.currentPhotoIndex = 0;
    
    // 4.显示浏览器
    [browser show];
}

- (void)setListModel:(WZEssenceListModel *)listModel {
    _listModel = listModel;
    
    [self.corver_imageView sd_setImageWithURL:WZUrl(listModel.larger_image)];
    self.playCount_label.text = [NSString stringWithFormat:@"%@播放",listModel.playcount];
    NSInteger voiceTime = listModel.voicetime;
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
