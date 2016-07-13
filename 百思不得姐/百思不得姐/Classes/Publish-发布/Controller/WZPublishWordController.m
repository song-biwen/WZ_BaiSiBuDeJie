//
//  WZPublishWordController.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/13.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZPublishWordController.h"
#import "WZPlaceHolderTextView.h" //带 placeholder 的 textView

@interface WZPublishWordController ()

//带占位文字的textView
@property (nonatomic, weak) WZPlaceHolderTextView *textView;
@end

@implementation WZPublishWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
    
    //设置textView
    [self setupTextView];
}

/** 取消 */
- (void)cancelAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** 发表 */
- (void)publishAction {
    WZLogFunc;
    self.textView.font = [UIFont systemFontOfSize:30];
}


/** 
 * 设置导航栏
 */
- (void)setupNav {
    
    self.title = @"发表文字";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //左边
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateNormal];
    
    //右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(publishAction)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
}

/** 
 * 设置textView
 */
- (void)setupTextView {
    WZPlaceHolderTextView *textView = [[WZPlaceHolderTextView alloc] initWithFrame:self.view.bounds];
    textView.placeHolder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    [self.view addSubview:textView];
    self.textView = textView;
}
@end
