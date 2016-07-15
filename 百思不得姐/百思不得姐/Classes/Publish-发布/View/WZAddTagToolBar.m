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
@end
