//
//  WZEssenceTopCommentView.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/23.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZEssenceTopCommentView.h"
#import "WZEssenceListModel.h"


@interface WZEssenceTopCommentView()

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@end

@implementation WZEssenceTopCommentView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.commentLabel.backgroundColor = WZColorDefault;
}

+ (instancetype)topCommentView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setListModel:(WZEssenceListModel *)listModel {
    _listModel = listModel;
    
    self.commentLabel.text = _listModel.top_comment;
}
@end
