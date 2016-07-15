//
//  WZPublishWordController.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/13.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZPublishWordController.h"
#import "WZPlaceHolderTextView.h" //带 placeholder 的 textView
#import "WZAddTagToolBar.h"  //toolbar

@interface WZPublishWordController ()
<UITextViewDelegate>
//带占位文字的textView
@property (nonatomic, weak) WZPlaceHolderTextView *textView;

//toolBar
@property (nonatomic, weak) WZAddTagToolBar *toolBar;

@end

@implementation WZPublishWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
    
    //设置textView
    //如果textView初始化值的话，需要调用textViewDidChange
    [self setupTextView];
    
    //设置toolbar
    [self setupToolBar];
}


#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.textView resignFirstResponder];
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
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateDisabled];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    //强制更新
    [self.navigationController.navigationBar layoutIfNeeded];
}


/** 
 * 设置textView
 */
- (void)setupTextView {
    WZPlaceHolderTextView *textView = [[WZPlaceHolderTextView alloc] initWithFrame:self.view.bounds];
    textView.placeHolder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    [self.textView becomeFirstResponder];
}

/** 
 设置toolBar
 */
- (void)setupToolBar {
    WZAddTagToolBar *toolBar = [WZAddTagToolBar toolBar];
    toolBar.width = WZScreenWidth;
    toolBar.x = 0;
    toolBar.y = WZScreenHeight - toolBar.height;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    
    //监听键盘尺寸改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

/** 
 监听键盘尺寸改变
 */
- (void)keyboardWillChangeFrameNotification:(NSNotification *)notification {
    CGRect keyboardF = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, keyboardF.origin.y - WZScreenHeight);
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
