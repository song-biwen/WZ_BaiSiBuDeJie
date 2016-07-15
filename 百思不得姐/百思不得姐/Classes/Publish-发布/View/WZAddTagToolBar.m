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

@property (nonatomic, strong) NSArray *tags;
@end

@implementation WZAddTagToolBar

+ (instancetype)toolBar {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    //初始化addbutton
    [self setupAddButton];
    
    //更新视图尺寸
    [self updateViewHeight];
}

/** 更新视图的高度 */
- (void)updateViewHeight {
    self.height = 16 + 35;
    self.height += WZTagMargin;
    self.height += self.addButton.height;
    self.height += WZTagMargin;
}

/** 
 初始化添加标签按钮
 */
- (void)setupAddButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:WZImage(@"tag_add_icon") forState:UIControlStateNormal];
    button.size = button.currentImage.size;
    button.x = WZTagMargin;
    button.y = WZTagMargin;
    [button addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:button];
    
    self.addButton = button;
}

/** 添加标签 */
- (void)addButtonAction {
    WZAddTagController *addTagVC = [[WZAddTagController alloc] init];
    __weak typeof(self) weakSelf = self;
    
    [addTagVC setAddTagsBlock:^(NSArray *tags) {
        
        weakSelf.tags = tags;
        [weakSelf.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [weakSelf.tagLabels removeAllObjects];
        
        for (int i = 0; i < tags.count; i ++) {
            
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = WZColorTagDefault;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = WZFont(14);
            label.text = tags[i];
            [label sizeToFit];
            label.height = WZTagHeight;
            label.width += 2 * WZTagMargin;
            [weakSelf.topView addSubview:label];
            [weakSelf.tagLabels addObject:label];
        }
        
        [weakSelf updateTagLabelFrame];
        [weakSelf updateAddButtonFrame];
        
    }];
    
    addTagVC.tags = self.tags;
    
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
//    WZLog(@"%@",vc);
//    WZLog(@"%@",vc.presentedViewController);
    [(UINavigationController *)vc.presentedViewController pushViewController:addTagVC animated:YES];
    
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


/** 更新AddButton */
- (void)updateAddButtonFrame {
    UILabel *lastLabel = self.tagLabels.lastObject;
    CGFloat leftMargin = CGRectGetMaxX(lastLabel.frame) + WZTagMargin;
    CGFloat rightMargin = self.topView.width - leftMargin;
    if (rightMargin > WZTagHeight) {
        self.addButton.x = leftMargin;
        self.addButton.y = lastLabel.y;
    }else {
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastLabel.frame) + WZTagMargin;
    }

    self.height -= self.addButton.height;
    self.height += CGRectGetMaxY(self.addButton.frame);
}

/** 更新TagLabel */
- (void)updateTagLabelFrame {
    for (int i = 0; i < self.tagLabels.count; i ++) {
        UILabel *tagLabel = self.tagLabels[i];
        if (i == 0) {
            tagLabel.x = 0;
            tagLabel.y = WZTagMargin;
            
        }else {
            UILabel *lastLabel = self.tagLabels[i - 1];
            CGFloat leftMargin = CGRectGetMaxX(lastLabel.frame) + WZTagMargin;
            CGFloat rightMargin = self.topView.width - leftMargin;
            if (tagLabel.width <= rightMargin) {
                tagLabel.x = leftMargin;
                tagLabel.y = lastLabel.y;
                
            }else {
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastLabel.frame) + WZTagMargin;
            }
        }
    }
}


- (NSMutableArray *)tagLabels {
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}


- (NSArray *)tags {
    if (!_tags) {
        _tags = [NSArray array];
    }
    return _tags;
}
@end
