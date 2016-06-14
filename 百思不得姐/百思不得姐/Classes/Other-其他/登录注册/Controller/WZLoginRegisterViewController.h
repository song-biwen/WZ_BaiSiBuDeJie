//
//  WZLoginRegisterViewController.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/13.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 登录注册 */
@interface WZLoginRegisterViewController : UIViewController
//手机号
@property (weak, nonatomic) IBOutlet UITextField *phone_textField;

//密码
@property (weak, nonatomic) IBOutlet UITextField *password_textField;


//登录框的水平约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *horizontalConstraint;

@end
