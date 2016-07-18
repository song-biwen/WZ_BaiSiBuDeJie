//
//  WZAddTagToolBar.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/14.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZAddTagToolBar.h"
#import "WZAddTagController.h" //添加标签

@interface WZAddTagToolBar ()
//顶部视图
@property (weak, nonatomic) IBOutlet UIView *topView;

//添加按钮
@property (nonatomic, strong) UIButton *addButton;

@property (nonatomic, strong) NSMutableArray *tagLabels;

@end

@implementation WZAddTagToolBar

+ (instancetype)toolBar {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    //初始化addbutton
    [self setupAddButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (int i = 0; i<self.tagLabels.count; i++) {
        UILabel *tagLabel = self.tagLabels[i];
        
        // 设置位置
        if (i == 0) { // 最前面的标签
            tagLabel.x = 0;
            tagLabel.y = 0;
        } else { // 其他标签
            UILabel *lastTagLabel = self.tagLabels[i - 1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + WZTagMargin;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth >= tagLabel.width) { // 按钮显示在当前行
                tagLabel.y = lastTagLabel.y;
                tagLabel.x = leftWidth;
            } else { // 按钮显示在下一行
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + WZTagMargin;
            }
        }
    }
    
    // 最后一个标签
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + WZTagMargin;
    
    // 更新textField的frame
    if (self.topView.width - leftWidth >= self.addButton.width) {
        self.addButton.y = lastTagLabel.y;
        self.addButton.x = leftWidth;
    } else {
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + WZTagMargin;
    }
    
    // 整体的高度
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.addButton.frame) + 16 + 35;
    self.y -= self.height - oldH;
    
}

/** 
 初始化添加标签按钮
 */
- (void)setupAddButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:WZImage(@"tag_add_icon") forState:UIControlStateNormal];
    button.size = button.currentImage.size;
    button.x = WZTagMargin;
    [button addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:button];
    
    self.addButton = button;
}

/** 添加标签按钮Action */
- (void)addButtonAction {
    WZAddTagController *addTagVC = [[WZAddTagController alloc] init];
    __weak typeof(self) weakSelf = self;
    
    [addTagVC setAddTagsBlock:^(NSArray *tags) {
        [weakSelf createTagLabels:tags];
    }];
    
    addTagVC.tags = [self.tagLabels valueForKeyPath:@"text"];
    
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
//    WZLog(@"%@",vc);
//    WZLog(@"%@",vc.presentedViewController);
    [(UINavigationController *)vc.presentedViewController pushViewController:addTagVC animated:YES];
    
}


/**
 * 创建标签
 */
- (void)createTagLabels:(NSArray *)tags
{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (int i = 0; i<tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.backgroundColor = WZColorTagDefault;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tags[i];
        tagLabel.font = WZFont(14);
        // 应该要先设置文字和字体后，再进行计算
        [tagLabel sizeToFit];
        tagLabel.width += 2 * WZTagMargin;
        tagLabel.height = WZTagHeight;
        tagLabel.textColor = [UIColor whiteColor];
        [self.topView addSubview:tagLabel];
    }
    
    // 重新布局子控件
    [self setNeedsLayout];
}


/** 
 * @
 */
- (IBAction)peopleAction {
    WZLogFunc;
}

/** 
 * # 选择主题
 */
- (IBAction)themeAction {
    WZLogFunc;
}


- (NSMutableArray *)tagLabels {
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

@end
