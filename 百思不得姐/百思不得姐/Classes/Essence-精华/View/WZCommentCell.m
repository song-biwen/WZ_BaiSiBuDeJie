//
//  WZCommentCell.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/4.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZCommentCell.h"
#import "WZEssenceTopComentModel.h" //model
#import "WZEssenceUserModel.h"
#import "WZVerticalButton.h"


@interface WZCommentCell ()
//头像
@property (weak, nonatomic) IBOutlet UIImageView *avator_imageView;
//性别
@property (weak, nonatomic) IBOutlet UIImageView *sex_imageView;
//名称
@property (weak, nonatomic) IBOutlet UILabel *name_label;
//点赞
@property (weak, nonatomic) IBOutlet WZVerticalButton *zan_button;
//内容
@property (weak, nonatomic) IBOutlet UILabel *content_label;
//音频
@property (weak, nonatomic) IBOutlet UIButton *voice_button;
//动画图片
@property (weak, nonatomic) IBOutlet UIImageView *animation_imageView;
@end

@implementation WZCommentCell

+ (instancetype)cellOfTableView:(UITableView *)tableView {
    WZCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.animation_imageView.animationImages = [NSArray arrayWithObjects:WZImage(@"play-voice-icon-0"),WZImage(@"play-voice-icon-1"),WZImage(@"play-voice-icon-2"),WZImage(@"play-voice-icon-3"), nil];
    self.animation_imageView.animationDuration = 1.0;
}

- (void)setComentModel:(WZEssenceTopComentModel *)comentModel {
    _comentModel = comentModel;
    
    WZEssenceUserModel *userModel = comentModel.user;
    
    [self.avator_imageView setHeader:userModel.profile_image];
    
    self.sex_imageView.image = [userModel.sex isEqualToString:@"m"] ? WZImage(@"Profile_manIcon"):WZImage(@"Profile_womanIcon");
    self.name_label.text = userModel.username;
    self.content_label.text = comentModel.content;
    
    [self.zan_button setTitle:[NSString stringWithFormat:@"%zd",comentModel.like_count] forState:UIControlStateNormal];
    
    self.voice_button.hidden = comentModel.voiceuri.length == 0;
    self.animation_imageView.hidden = self.voice_button.hidden;
    self.animation_imageView.image = WZImage(@"play-voice-icon-3");
    [self.voice_button setTitle:[NSString stringWithFormat:@"%zd''",comentModel.voicetime] forState:UIControlStateNormal];
    
}

//播放音频
- (IBAction)play {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(playVoiceWithCommentModel: animationImageView:)]) {
        [self.delegate playVoiceWithCommentModel:self.comentModel animationImageView:self.animation_imageView];
    }
}

//点赞
- (IBAction)zan {
    
    CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    k.values = @[@(0.1),@(1.0),@(1.5)];
    k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
    k.calculationMode = kCAAnimationLinear;
    [self.zan_button.layer addAnimation:k forKey:@"SHOW"];
    self.zan_button.selected = !self.zan_button.selected;
}


#pragma mark - UIMenuController
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

@end
