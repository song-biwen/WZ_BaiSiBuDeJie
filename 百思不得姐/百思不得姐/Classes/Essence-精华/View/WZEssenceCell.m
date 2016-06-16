//
//  WZEssenceCell.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/16.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZEssenceCell.h"
#import "WZEssenceListModel.h" //数据模型

@interface WZEssenceCell()
//头像
@property (weak, nonatomic) IBOutlet UIImageView *avator_imageView;

//姓名
@property (weak, nonatomic) IBOutlet UILabel *name_label;

//时间
@property (weak, nonatomic) IBOutlet UILabel *creatTime_label;

//关注
@property (weak, nonatomic) IBOutlet UIButton *star_button;

//顶
@property (weak, nonatomic) IBOutlet UIButton *ding_button;

//踩
@property (weak, nonatomic) IBOutlet UIButton *cai_button;

//转发
@property (weak, nonatomic) IBOutlet UIButton *repost_button;

//评论
@property (weak, nonatomic) IBOutlet UIButton *comment_button;

@end
@implementation WZEssenceCell

+ (instancetype)cellOfTableView:(UITableView *)tableView {
    WZEssenceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.backgroundColor = WZColorDefault;
    
    self.avator_imageView.layer.cornerRadius = self.avator_imageView.width/2.0;
    self.avator_imageView.layer.masksToBounds = YES;
    
    //设置背景图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = WZImage(@"mainCellBackground");
    self.backgroundView = imageView;
    
}

//重写方法改变cell的大小
- (void)setFrame:(CGRect)frame {
    
    CGFloat margin = 10;
    frame.origin.x += margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

- (void)setListModel:(WZEssenceListModel *)listModel {
    _listModel = listModel;
    
    [self.avator_imageView sd_setImageWithURL:WZUrl(_listModel.profile_image) placeholderImage:WZImageDefault];
    self.name_label.text = _listModel.name;
    self.creatTime_label.text = [NSDate intervalFromNow:_listModel.create_time];
    
    
    [self setupButton:self.ding_button count:[_listModel.ding integerValue] placeholder:@"顶"];
    [self setupButton:self.cai_button count:[_listModel.cai integerValue] placeholder:@"踩"];
    [self setupButton:self.repost_button count:[_listModel.repost integerValue] placeholder:@"转发"];
    [self setupButton:self.comment_button count:[_listModel.comment integerValue] placeholder:@"评论"];
}

//按钮初始化
- (void)setupButton:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder {
    
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }
    else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    
    [button setTitle:placeholder forState:UIControlStateNormal];
}
@end
