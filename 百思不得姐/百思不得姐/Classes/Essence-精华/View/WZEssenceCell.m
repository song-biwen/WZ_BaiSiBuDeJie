//
//  WZEssenceCell.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/16.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZEssenceCell.h"
#import "WZEssenceListModel.h" //数据模型
#import "WZEssencePictureView.h" //图片View

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

//是否是sina用户
@property (weak, nonatomic) IBOutlet UIImageView *sina_imageView;

//消息文本
@property (weak, nonatomic) IBOutlet UILabel *message_label;

//图片View
@property (nonatomic, weak) WZEssencePictureView *pictureView;

@end
@implementation WZEssenceCell

+ (instancetype)cellOfTableView:(UITableView *)tableView {
    WZEssenceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

/** cell 高度 */
+ (CGFloat)heightOftableViewCell:(WZEssenceListModel *)model {
    CGFloat height = 0;
    
    CGFloat topViewH = WZEssenceBaseCellTopHeight;
    CGFloat bottomViewH = WZEssenceBaseCellBottomHeight;
    
    CGSize maxSize = CGSizeMake(WZScreenWidth - 2 * WZEssenceBaseCellMargin, MAXFLOAT);
    CGFloat middleViewH = [model.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:WZFont(14)} context:nil].size.height;
    CGFloat middleViewMargin = 2 * WZEssenceBaseCellMargin;
    
    height = topViewH + bottomViewH + middleViewH + middleViewMargin + WZEssenceBaseCellMargin;
    return height;
    
}

- (void)setListModel:(WZEssenceListModel *)listModel {
    _listModel = listModel;
    
    //    _listModel.sina_v = arc4random_uniform(10) % 2;测试数据
    
    [self.avator_imageView sd_setImageWithURL:WZUrl(_listModel.profile_image) placeholderImage:WZImageDefault];
    self.name_label.text = _listModel.name;
    self.creatTime_label.text = [NSDate intervalFromNow:_listModel.create_time];
    self.sina_imageView.hidden = !_listModel.sina_v;
    self.message_label.text = _listModel.text;
    
    
    if (listModel.type == WZEssenceBaseTypePicture) {
        self.pictureView.listModel = _listModel;
        self.pictureView.frame = _listModel.pictureF;
    }
    
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

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.contentView.backgroundColor = WZColorDefault;
    
    self.avator_imageView.layer.cornerRadius = self.avator_imageView.width/2.0;
    self.avator_imageView.layer.masksToBounds = YES;
    
    //设置背景图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = WZImage(@"mainCellBackground");
    self.backgroundView = imageView;
    
    
}

//重写方法改变cell的大小设置cell间的边距
- (void)setFrame:(CGRect)frame {
    
    frame.origin.x += WZEssenceBaseCellMargin;
    frame.size.width -= 2 * WZEssenceBaseCellMargin;
    frame.size.height -= WZEssenceBaseCellMargin;
    frame.origin.y += WZEssenceBaseCellMargin;
    
    [super setFrame:frame];
}


- (WZEssencePictureView *)pictureView {
    if (!_pictureView) {
        WZEssencePictureView *pictureView = [WZEssencePictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
@end
