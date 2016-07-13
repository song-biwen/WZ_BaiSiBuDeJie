//
//  WZPublishViewController.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/3.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZPublishViewController.h"
#import "WZVerticalButton.h" //图片与文字竖直排列
#import <POP.h> //动画


#define WZTimeInterval 0.1

@interface WZPublishViewController ()
@property (nonatomic, strong) NSMutableArray *subViews;
@end

@implementation WZPublishViewController

/**
 pop和Core Animation的区别
 1.Core Animation的动画只能添加到layer上
 2.pop的动画能添加到任何对象
 3.pop的底层并非基于Core Animation, 是基于CADisplayLink
 4.Core Animation的动画仅仅是表象, 并不会真正修改对象的frame\size等值
 5.pop的动画实时修改对象的属性, 真正地修改了对象的属性
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.subViews = [NSMutableArray array];
    
    //构建子控件
    [self setupSubViews];
}

/** 按钮的点击事件 */
- (void)buttonAction:(UIButton *)sender {
    
    [self dismissWithCompletionBlock:^{
        WZLog(@"按钮点击事情");
        
    }];
}

/** 取消 */
- (IBAction)cancelAction {
    [self dismissWithCompletionBlock:nil];
}

- (void)dismissWithCompletionBlock:(void (^)())blcok {
    
    self.view.userInteractionEnabled = NO;
    
    for (NSInteger i = 0; i < self.subViews.count; i ++) {
        
        UIView *view = self.subViews[i];
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat viewX = view.x;
        CGFloat viewY = view.y;
        CGFloat viewH = view.height;
        
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(viewX, viewY)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(viewX, viewH + WZScreenHeight)];
        animation.beginTime = CACurrentMediaTime() + WZTimeInterval * i;
        [view pop_addAnimation:animation forKey:nil];
        if (i == self.subViews.count - 1) {
            [animation setCompletionBlock:^(POPAnimation *animation, BOOL isFinished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                
                blcok ? blcok() : nil;
                
            }];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissWithCompletionBlock:nil];
}

//构建子控件
- (void)setupSubViews {
    self.view.userInteractionEnabled = NO;
    
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    CGFloat margin = 20;
    int maxColumn = 3;
    CGFloat buttonWidth = 72;
    CGFloat buttonHeight = buttonWidth + 30;
    CGFloat buttonXSpace = (WZScreenWidth - 2 * margin - buttonWidth * maxColumn)/(maxColumn - 1);
    CGFloat buttonYSpace = margin;
    CGFloat buttonStartY = (WZScreenHeight - 2 * buttonHeight - margin) * 0.5;
    
    for (int i = (int)titles.count - 1; i >= 0; i --) {
        
        int row = i / maxColumn;
        int column = i % maxColumn;
        
        WZVerticalButton *button = [[WZVerticalButton alloc] init];
        [self.view addSubview:button];
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:WZImage(images[i]) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.titleLabel.font = WZFont(14);
        CGFloat buttonX = margin + column * (buttonWidth + buttonXSpace);
        CGFloat buttonY = buttonStartY + row * (buttonHeight + buttonYSpace);
        
        //        button.width= buttonWidth;
        //        button.height = buttonHeight;
        //        button.x = buttonX;
        //        button.y = buttonY;
        
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //添加动画
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, -buttonHeight, buttonWidth, buttonHeight)];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight)];
        animation.beginTime = CACurrentMediaTime() + WZTimeInterval * (titles.count - 1 - i);
        [button pop_addAnimation:animation forKey:nil];
        
        [self.subViews addObject:button];
    }
    
    //app_slogan
    UIImageView *sloganImageView = [[UIImageView alloc] initWithImage:WZImage(@"app_slogan")];
    CGFloat imageViewX = WZScreenWidth * 0.5;
    CGFloat imageViewY = WZScreenHeight * 0.2;
    
    //    sloganImageView.center = CGPointMake(WZScreenWidth * 0.5, WZScreenHeight * 0.2);
    [self.view addSubview:sloganImageView];
    //添加动画
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(imageViewX, -sloganImageView.height)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(imageViewX, imageViewY)];
    animation.beginTime = CACurrentMediaTime() + WZTimeInterval * titles.count;
    [sloganImageView pop_addAnimation:animation forKey:nil];
    [animation setCompletionBlock:^(POPAnimation *animation, BOOL isFinished) {
        self.view.userInteractionEnabled = YES;
    }];
    [self.subViews addObject:sloganImageView];
}
@end
