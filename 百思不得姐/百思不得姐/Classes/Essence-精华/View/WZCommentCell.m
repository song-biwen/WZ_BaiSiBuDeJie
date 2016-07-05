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
    
    self.avator_imageView.layer.cornerRadius = self.avator_imageView.frame.size.width/2.0;
    self.avator_imageView.layer.borderColor = [UIColor clearColor].CGColor;
    self.avator_imageView.layer.borderWidth = 1.0;
    
}

- (void)setComentModel:(WZEssenceTopComentModel *)comentModel {
    _comentModel = comentModel;
    
    WZEssenceUserModel *userModel = comentModel.user;
    [self.avator_imageView sd_setImageWithURL:WZUrl(userModel.profile_image) placeholderImage:WZImageDefault];
    self.sex_imageView.image = [userModel.sex isEqualToString:@"m"] ? WZImage(@"Profile_manIcon"):WZImage(@"Profile_womanIcon");
    self.name_label.text = userModel.username;
    self.content_label.text = comentModel.content;
    
    [self.zan_button setTitle:[NSString stringWithFormat:@"%zd",comentModel.like_count] forState:UIControlStateNormal];
    
    self.voice_button.hidden = comentModel.voiceuri.length == 0;
    [self.voice_button setTitle:[NSString stringWithFormat:@"%zd''",comentModel.voicetime] forState:UIControlStateNormal];
}

//播放音频
- (IBAction)play {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(playVoiceWithCommentModel:)]) {
        [self.delegate playVoiceWithCommentModel:self.comentModel];
    }
}

@end
