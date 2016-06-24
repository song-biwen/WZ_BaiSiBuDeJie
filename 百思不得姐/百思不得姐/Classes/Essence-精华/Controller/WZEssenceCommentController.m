//
//  WZEssenceCommentController.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/24.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZEssenceCommentController.h"
#import "WZEssenceListModel.h" //model
#import "WZEssenceCell.h" //cell

@interface WZEssenceCommentController ()
<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//输入框底部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboard_bottomConstraint;
@end

@implementation WZEssenceCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    [self setupHeader];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd----%zd",indexPath.section,indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

//列表滚动时隐藏输入框
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

/** tableView添加header */
- (void)setupHeader {
    
    UIView *header = [[UIView alloc] init];
    
    WZEssenceCell *cell = [WZEssenceCell cell];
    cell.listModel = self.listModel;
    cell.frame = CGRectMake(0, 0, WZScreenWidth, self.listModel.cellHeight);
    [header addSubview:cell];
    header.height = self.listModel.cellHeight + WZEssenceBaseCellMargin;

    self.tableView.tableHeaderView = header;
}

/** 初始化 */
- (void)setupBasic {
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"comment_nav_item_share_icon" highlightImageName:@"comment_nav_item_share_icon_click" target:self action:@selector(shareAction)];
    
    //tableView
    self.tableView.backgroundColor = WZColorDefault;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    //监听键盘尺寸的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}


/** 监听键盘的改变 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.keyboard_bottomConstraint.constant = WZScreenHeight - frame.origin.y;
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];//立刻刷新
    }];
}

/** 分享 */
- (void)shareAction {
    WZLogFunc;
    [self.view endEditing:YES];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
