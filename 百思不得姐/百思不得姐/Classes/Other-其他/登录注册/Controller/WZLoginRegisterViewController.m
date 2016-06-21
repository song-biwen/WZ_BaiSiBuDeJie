//
//  WZLoginRegisterViewController.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/13.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZLoginRegisterViewController.h"
#import "WZTestViewController.h"

@interface WZLoginRegisterViewController ()
<UITextFieldDelegate>


@end


#define KPlaceHolderAttributesDefault @{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}

#define KPlaceHolderAttributesHighlight @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}

@implementation WZLoginRegisterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /**
     改变textFiled属性 Placeholder的颜色
     方法一：attributedPlaceholder
         self.phone_textField.delegate = self;
         self.password_textField.delegate = self;
         [self setUpSubViews];
     方法二：重写drawPlaceholderInRect 见WZTextFieldPlaceHolder
     方法三：利用运行时 runtime 见WZTextFieldPlaceHolder
     */
    
}

#pragma mark - 点击空白区域键盘消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
//键盘弹出来
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [self setUpSubViews];
    
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textField.placeholder attributes:KPlaceHolderAttributesHighlight];
    
}

/** 取消按钮事件 */
- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** 切换注册登录 */
- (IBAction)switchLoginRegisterAction:(UIButton *)sender {
    
    //键盘消失
    [self.view endEditing:YES];
    
//    NSString *button_title = sender.titleLabel.text;
//    if ([button_title isEqualToString:@"注册账号"]) {
//        button_title = @"已有账号？";
//        self.horizontalConstraint.constant = - self.view.width;
//    }
//    else if ([button_title isEqualToString:@"已有账号？"]) {
//        button_title = @"注册账号";
//        self.horizontalConstraint.constant = 0;
//    }
//    
//    [sender setTitle:button_title forState:UIControlStateNormal];
    
    self.horizontalConstraint.constant = sender.selected ? 0 : - self.view.width;
    sender.selected = !sender.selected;
    
    //添加动画
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
       
    }];
    
    
}

/** 快速登录 */
- (IBAction)buttonAction:(id)sender {
    WZLogFunc;
    //腾讯微博的高亮图片有问题
    WZTestViewController *textVC = [[WZTestViewController alloc] init];
    [self.navigationController pushViewController:textVC animated:YES];
}

//设置属性
- (void)setUpSubViews {
    
    self.phone_textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:KPlaceHolderAttributesDefault];
    self.password_textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:KPlaceHolderAttributesDefault];
    
}

@end
