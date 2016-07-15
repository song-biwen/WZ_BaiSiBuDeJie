//
//  WZAddTagController.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/15.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZAddTagController.h"
#import "WZTagTextField.h" //textField
#import "WZTagButton.h" //button

@interface WZAddTagController ()
<UITextFieldDelegate>
//输入文本框
@property (nonatomic, weak) WZTagTextField *textField;
//确定button
@property (nonatomic, weak) UIButton *doneButton;

//标签按钮数组
@property (nonatomic, strong) NSMutableArray *tagButtons;

@property (nonatomic, weak) UIView *contentView;
@end

@implementation WZAddTagController

- (void)viewDidAppear:(BOOL)animated {
    [self.textField becomeFirstResponder];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航栏
    [self setupNav];
    
    [self setupContentView];
    //初始化textField
    [self setupTextField];
    //初始化doneButton
    [self setupDoneButton];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.hasText) {
        [self addTagButton];
    }else {
        [SVProgressHUD showErrorWithStatus:@"标题标签不能为空"];
    }
    
    return YES;
}

/** 更新textField */
- (void)updateTextFieldFrame {
    WZTagButton *tagButton = self.tagButtons.lastObject;
    CGFloat leftMargin = CGRectGetMaxX(tagButton.frame) + WZTagMargin;
    CGFloat rightMargin = self.contentView.width - leftMargin;
    if (rightMargin > WZTagHeight) {
        self.textField.x = leftMargin;
        self.textField.y = tagButton.y;
    }else {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(tagButton.frame) + WZTagMargin;
    }
}

/** 更新tagButtonframe */
- (void)updateTagButtonFrame {
    for (int i = 0; i < self.tagButtons.count; i ++) {
        WZTagButton *tagButton = self.tagButtons[i];
        if (i == 0) {
            tagButton.x = 0;
        }else {
            WZTagButton *lastTagButton = self.tagButtons[i - 1];
            CGFloat leftMargin = CGRectGetMaxX(lastTagButton.frame) + WZTagMargin;
            CGFloat rightMargin = self.contentView.width - leftMargin;
            if (tagButton.width <= rightMargin) {
                tagButton.x = leftMargin;
                tagButton.y = lastTagButton.y;
                
            }else {
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + WZTagMargin;
            }
        }
    }
}

/** 删除标签 */
- (void)deleteTagButtonAction:(WZTagButton *)button {
    
    [button removeFromSuperview];
    [self.tagButtons removeObject:button];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
        [self updateTextFieldFrame];
    }];
}
/** 
 添加tag
 */
- (void)addTagButton {
    
    if (self.tagButtons.count >= 5) {
        [SVProgressHUD showErrorWithStatus:@"标题标签不能超过5个"];
        return;
    }
    WZTagButton *button = [WZTagButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = self.textField.font;
    [button setTitle:self.textField.text forState:UIControlStateNormal];
    button.height = WZTagHeight;
    [button addTarget:self action:@selector(deleteTagButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    
    self.textField.text = nil;
    self.doneButton.hidden = YES;
    
    [self.tagButtons addObject:button];
    [self updateTagButtonFrame];
    [self updateTextFieldFrame];
    
}

/** 
 初始化doneButton
 */
- (void)setupDoneButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.height = WZTagHeight;
    button.width = WZScreenWidth - 2*WZTagMargin;
    button.titleLabel.font = self.textField.font;
    button.backgroundColor = WZColorTagDefault;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(addTagButton) forControlEvents:UIControlEventTouchUpInside];
    button.hidden = YES;
    [self.contentView addSubview:button];
    
    self.doneButton = button;
}


/** 
 文本发生改变
 */
- (void)textDidChange {
    if (self.textField.hasText) {
        
        [self.doneButton setTitle:self.textField.text forState:UIControlStateNormal];
        self.doneButton.hidden = NO;
        
        NSString *text = self.textField.text;
        NSInteger length = text.length;
        NSString *lastStr = [text substringFromIndex:length - 1];
        NSString *preStr = [text substringToIndex:length - 1];
        if ([lastStr isEqualToString:@","] || [lastStr isEqualToString:@"，"]) {
            if (preStr.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"标题标签不能为空"];
                self.textField.text = nil;
                self.doneButton.hidden = YES;
                return;
            }else {
                self.textField.text = preStr;
                [self addTagButton];
            }
        }
        
        if (self.tagButtons.count > 0) {
            
            WZTagButton *tagButton = self.tagButtons.lastObject;
            CGFloat leftMargin = CGRectGetMaxX(tagButton.frame) + WZTagMargin;
            CGFloat rightMargin = self.contentView.width - leftMargin;
            CGFloat width = [self.textField.text sizeWithAttributes:@{NSFontAttributeName:self.textField.font}].width;
            if (rightMargin > width) {
                self.textField.x = leftMargin;
                self.textField.y = tagButton.y;
            }else {
                self.textField.x = 0;
                self.textField.y = CGRectGetMaxY(tagButton.frame) + WZTagMargin;
            }
        }
        
        self.doneButton.y = CGRectGetMaxY(self.textField.frame) + WZTagMargin;
        
    }else {
        self.doneButton.hidden = YES;
    }
}

/** 初始化textField */
- (void)setupTextField {
    
    WZTagTextField *textField = [[WZTagTextField alloc] init];
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    textField.delegate = self;
    __weak typeof(self) weakSeld = self;
    [textField setDeleteBlock:^{
        if (weakSeld.textField.hasText) {
            return ;
        }
        [weakSeld deleteTagButtonAction:self.tagButtons.lastObject];
    }];
    [self.contentView addSubview:textField];
    self.textField = textField;
    
}

- (void)setupContentView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.x = WZTagMargin;
    contentView.width = self.view.width - 2 * contentView.x;
    contentView.y = 64 + WZTagMargin;
    contentView.height = WZScreenHeight - contentView.y - WZTagMargin;
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

/** 设置导航栏 */
- (void)setupNav {
    self.title = @"添加标签";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:WZFont(14)} forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:WZFont(14)} forState:UIControlStateNormal];
}

/** 取消 */
- (void)cancel {
    [self.navigationController popViewControllerAnimated:YES];
}

/** 确定 */
- (void)done {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)tagButtons {
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}
@end
