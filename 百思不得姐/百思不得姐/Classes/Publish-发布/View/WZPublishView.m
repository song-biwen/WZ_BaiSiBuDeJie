//
//  WZPublishView.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/21.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZPublishView.h"
#import "WZVerticalButton.h" //图片与文字竖直排列
#import <POP.h> //动画
#import "WZNavigationController.h" //导航
#import "WZPublishWordController.h" //发段子
#import "WZHomeTabBarController.h" //首页
#import "WZWaterFlowController.h" //瀑布流


#define WZTimeInterval 0.1
#define WZRootView [UIApplication sharedApplication].keyWindow.rootViewController.view

@interface WZPublishView()
@property (nonatomic, strong) NSMutableArray *subViews;

@end
@implementation WZPublishView

+ (instancetype)publishView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

static UIWindow *window_;

+ (void)show {
    
    window_ = [[UIWindow alloc] init];
    window_.frame = [UIScreen mainScreen].bounds;
    window_.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
//    window_.windowLevel = UIWindowLevelStatusBar;
    window_.hidden = NO;
    
    WZPublishView *publishView = [WZPublishView publishView];
    publishView.frame = window_.bounds;
    [window_ addSubview:publishView];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.subViews = [[NSMutableArray alloc] init];
    
    
    [self setupSubViews];
}

/** 按钮的点击事件 */
- (void)buttonAction:(UIButton *)sender {
    
    [self dismissWithCompletionBlock:^{
        WZLog(@"按钮点击事情");
        WZLog(@"%@",sender.titleLabel.text);
        NSString *button_title = sender.titleLabel.text;
        
        WZHomeTabBarController *vc = (WZHomeTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        if ([button_title isEqualToString:@"发段子"]) {
            
            if ([[WZLoginTool getUid:YES] length] == 0) return ;
            
            WZPublishWordController *publishWord = [[WZPublishWordController alloc] init];
            WZNavigationController *nav = [[WZNavigationController alloc] initWithRootViewController:publishWord];
            [vc presentViewController:nav animated:YES completion:nil];
        }else {
            
            //瀑布流
            WZWaterFlowController *waterFlowVC = [[WZWaterFlowController alloc] init];
            WZNavigationController *nav = [[WZNavigationController alloc] initWithRootViewController:waterFlowVC];
            [vc presentViewController:nav animated:YES completion:nil];
        }
    }];
}

/** 取消 */
- (IBAction)cancelAction {
    [self dismissWithCompletionBlock:nil];
}

/** 界面消失 */
- (void)dismissWithCompletionBlock:(void (^)())blcok {
    //2.0
    WZRootView.userInteractionEnabled = NO;
    //3.0
//    self.userInteractionEnabled = NO;
    
    for (NSInteger i = 0; i < self.subViews.count; i ++) {
        
        UIView *view = self.subViews[i];
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat viewX = view.x;
        CGFloat viewY = view.y;
        CGFloat viewH = view.height;
        CGFloat viewW = view.width;
        
        animation.fromValue = [NSValue valueWithCGRect:CGRectMake(viewX, viewY, viewW, viewH)];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(viewX, viewH + WZScreenHeight, viewW, viewH)];
        animation.beginTime = CACurrentMediaTime() + WZTimeInterval * i;
        [view pop_addAnimation:animation forKey:nil];
        if (i == self.subViews.count - 1) {
            [animation setCompletionBlock:^(POPAnimation *animation, BOOL isFinished) {
                //2.0
                [self removeFromSuperview];
                WZRootView.userInteractionEnabled = YES;
                
                //3.0
//                window_ = nil;
                
                !blcok ? : blcok();
                
            }];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissWithCompletionBlock:nil];
}

//构建子控件
- (void)setupSubViews {
    
    
    //2.0
        WZRootView.userInteractionEnabled = NO;
    //3.0
//    self.userInteractionEnabled = NO;
    
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
        [self addSubview:button];
        
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
        animation.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX,buttonHeight - WZScreenHeight, buttonWidth, buttonHeight)];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight)];
        animation.beginTime = CACurrentMediaTime() + WZTimeInterval * (titles.count - 1 - i);
        [button pop_addAnimation:animation forKey:nil];
        
        [self.subViews addObject:button];
    }
    
    //app_slogan
    UIImageView *sloganImageView = [[UIImageView alloc] initWithImage:WZImage(@"app_slogan")];
    CGFloat imageViewH = sloganImageView.height;
    CGFloat imageViewW = sloganImageView.width;
    CGFloat imageViewX = (self.width - imageViewW) * 0.5;
    CGFloat imageViewY = WZScreenHeight * 0.2;
    sloganImageView.x = imageViewX;
    sloganImageView.y = imageViewH - WZScreenHeight;
    [self addSubview:sloganImageView];
    //添加动画
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    animation.fromValue = [NSValue valueWithCGRect:CGRectMake(imageViewX, imageViewH - WZScreenHeight, imageViewW, imageViewH)];
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH)];
    animation.beginTime = CACurrentMediaTime() + WZTimeInterval * titles.count;
    [sloganImageView pop_addAnimation:animation forKey:nil];
    [animation setCompletionBlock:^(POPAnimation *animation, BOOL isFinished) {
        
        //2.0
            WZRootView.userInteractionEnabled = YES;
        //3.0
//        self.userInteractionEnabled = YES;
    }];
    [self.subViews addObject:sloganImageView];
}

@end
