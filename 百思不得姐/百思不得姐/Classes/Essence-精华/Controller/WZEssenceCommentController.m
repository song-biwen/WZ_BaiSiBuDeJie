//
//  WZEssenceCommentController.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/24.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZEssenceCommentController.h"
#import "WZEssenceListModel.h" //model
#import "WZEssenceTopComentModel.h" //model
#import <MJRefresh.h>
#import <MJExtension.h>
#import "WZCommentCell.h" //cell
#import "WZEssenceCell.h" //cell
#import "WZTableViewHeaderFooterView.h" //自定义headerfooterview

#import <AVFoundation/AVFoundation.h>


@interface WZEssenceCommentController ()
<UITableViewDelegate, UITableViewDataSource,WZCommentCellDelegate>

{
    NSString *lastcid;
    NSInteger currentPage;
    NSInteger totalCount;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//输入框底部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboard_bottomConstraint;

//网络请求
@property (nonatomic, strong) AFHTTPSessionManager *manager;

//数据
@property (nonatomic, strong) NSMutableArray *hotComments;//最热评论
@property (nonatomic, strong) NSMutableArray *latestComments;//最新评论

//保存之前的热门评论
@property (nonatomic, strong) WZEssenceTopComentModel *saved_top_cmt;


//音频播放
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation WZEssenceCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    [self setupHeader];
    
    //集成刷新控件
    [self setupRefresh];
}

#pragma mark -- WZCommentCellDelegate
- (void)playVoiceWithCommentModel:(WZEssenceTopComentModel *)comentModel {
    
    if (_player.playing) {
        [_player stop];
    }
    
    NSError *error;
    NSString *voiceuri = comentModel.voiceuri;
    NSString *fileName = [[voiceuri stringByReplacingOccurrencesOfString:WZUrlPre withString:@""] stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [docDirPath stringByAppendingString:[NSString stringWithFormat:@"/%@",fileName]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        NSLog(@"...将数据保存在本地");
        
        //将数据保存到本地指定位置
        NSURL *voiceUrl = WZUrl(voiceuri);
        NSData *voiceData = [NSData dataWithContentsOfURL:voiceUrl];
        [voiceData writeToFile:filePath atomically:YES];
        
    }
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filePath] error:&error];
    if (error) {
        NSLog(@"error:%@",[error description]);
        return;
    }
    //准备播放
    [_player prepareToPlay];
    //播放
    [_player play];
    NSLog(@"----播放本地数据success");
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sectionCount = 0;
    if (self.hotComments.count > 0) {
        sectionCount ++;
    }
    
    if (self.latestComments.count > 0) {
        sectionCount ++;
    }
    
    return sectionCount;
}


//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    NSString *title = @"";
//    if (self.hotComments.count > 0 && section == 0) {
//        title = @"最热评论";
//    }else if (self.latestComments.count > 0) {
//        title = @"最新评论";
//    }
//    
//    return title;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self arrayOfSection:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WZCommentCell *cell = [WZCommentCell cellOfTableView:tableView];
    cell.delegate = self;
    cell.comentModel = [self modelOfIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = WZColorDefault;
//    
//    UILabel *label = [[UILabel alloc] init];
//    label.textColor = [UIColor lightGrayColor];
//    label.font = WZFont(14);
//    label.x = WZEssenceBaseCellMargin;
//    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    label.width = 100;
//    
//    
//    NSString *title = @"";
//    if (self.hotComments.count > 0 && section == 0) {
//        title = @"最热评论";
//    }else if (self.latestComments.count > 0) {
//        title = @"最新评论";
//    }
//    label.text = title;
//    
//    [headerView addSubview:label];
//    
//    return headerView;
//}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    WZTableViewHeaderFooterView *header = [WZTableViewHeaderFooterView headerFooterViewOfTableView:tableView];
    
    NSString *title = @"";
    if (self.hotComments.count > 0 && section == 0) {
        title = @"最热评论";
    }else if (self.latestComments.count > 0) {
        title = @"最新评论";
    }
    
    header.header_title = title;
    return header;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self modelOfIndexPath:indexPath] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

//列表滚动时隐藏输入框
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


/** 返回indexPatch对应的model */
- (WZEssenceTopComentModel *)modelOfIndexPath:(NSIndexPath *)indexPath {
    return [self arrayOfSection:indexPath.section][indexPath.row];
}

/** 返回section对应的数组 */
- (NSArray *)arrayOfSection:(NSInteger)section {
    if (section == 0) {
        return self.hotComments.count > 0 ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

/** 加载数据 */
- (void)loadingDataWithHeaderRefresh:(BOOL)isHeaderRefresh {
    
    if (isHeaderRefresh) {
        currentPage = 1;
        lastcid = @"";
    }
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@"dataList" forKey:@"a"];
    [parameters setObject:@"comment" forKey:@"c"];
    [parameters setObject:self.listModel.ID forKey:@"data_id"];
    [parameters setObject:@"1" forKey:@"hot"];
    [parameters setObject:@"0" forKey:@"jbk"];
    [parameters setObject:lastcid forKey:@"lastcid"];
    [parameters setObject:@(currentPage) forKey:@"page"];
    
    WZLog(@"%@",parameters);
    
    [self.manager GET:WZUrlDefault parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        WZLog(@".....%@",responseObject);
        
//        [responseObject writeToFile:@"/Users/songbiwen/Desktop" atomically:YES];
        
        totalCount = [responseObject[@"total"] integerValue];
        
        if (isHeaderRefresh) {
            self.hotComments = [WZEssenceTopComentModel mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
            [self.latestComments removeAllObjects];
        }
       
        [self.latestComments addObjectsFromArray:[WZEssenceTopComentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
        
        
        if (self.latestComments.count + self.hotComments.count >= totalCount) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }else {
            
            WZEssenceTopComentModel *lastModel = self.latestComments.lastObject;
            currentPage ++;
            lastcid = lastModel.ID;
            
            [self.tableView.mj_footer endRefreshing];
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
        
        if (self.latestComments.count + self.hotComments.count >= totalCount) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
        
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        
    }];
}

/** 上拉加载更多 */
- (void)footerRefresh {
    [self loadingDataWithHeaderRefresh:NO];
}

/** 下拉刷新 */
- (void)headerRefresh {
    [self loadingDataWithHeaderRefresh:YES];
}


/** 集成刷新控件 */
- (void)setupRefresh {
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    /** 根据拖拽比例自动切换透明度 */
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //加载数据
    [self.tableView.mj_header beginRefreshing];
}

/** tableView添加header */
- (void)setupHeader {
    
    if (self.listModel.top_cmt) {
        //进评论详情页面，删除原来的热门评论
        self.saved_top_cmt = self.listModel.top_cmt;
        self.listModel.top_cmt = nil;
        [self.listModel setValue:@(0) forKey:@"cellHeight"];
    }
    
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
    
    self.hotComments = [NSMutableArray array];
    self.latestComments = [NSMutableArray array];
    
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
    
    [self.manager.operationQueue cancelAllOperations];
    
    if (self.saved_top_cmt) {
        //还原之前的数据
        self.listModel.top_cmt = self.saved_top_cmt;
        [self.listModel setValue:@(0) forKey:@"cellHeight"];
    }
    
}


- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

@end
