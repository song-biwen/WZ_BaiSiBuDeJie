//
//  笔记.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/3.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#ifndef ___h
#define ___h

/** 
 下次学习0729 05
 
 1.后面带有 UI_APPEARANCE_SELECTOR  字段的方法名 可以通过统一设置属性
 2.随机数函数arc4random_uniform（x），可以用来产生0～(x-1)范围内的随机数 
 3.imageWithRenderingMode
 4.
     self.title = @"我的关注";
     等价于
     self.navigationItem.title = @"我的关注";
     self.tabBarItem.title = @"我的关注";
 5.
    利用KVC替换掉系统的tabbar
    [self setValue:[[WZTabBar alloc] init] forKeyPath:@"tabBar"];
 
 6.
    如果在WZHomeTabBarController里面全局设置各个视图的背景颜色，将会导致提前创建视图。
    所以拒绝这样做法.
 7.在xib里面填写换行文本，换行的操作为 alt + enter
 8.当cell的selection设为none时，当cell被选中时，内部的子控件将不进入高亮状态
   此时设置一下方法将不起作用
    self.textLabel.highlightedTextColor = [UIColor redColor];
 9.
     //设置inset解决两个tablevIew偏移量不同问题
     self.automaticallyAdjustsScrollViewInsets = NO;
     self.left_tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
     self.right_tableView.contentInset = self.left_tableView.contentInset;
 10.
    内存警告
    UIApplicationDidReceiveMemoryWarningNotification
    取消网络请求
 11.
    [NSString stringWithFormat:@"%zd",indexPath.row]
 12.
    重写setFrame方法,改变cell的x width height值，实现cell之间的间隙
 13.
    button 默认的image与titleLabel是左右排列
 14.
    跟网络有关的优化 见WZRecommendViewController
 15. 改变textFiled属性 Placeholder的颜色
     方法一：attributedPlaceholder
     self.phone_textField.delegate = self;
     self.password_textField.delegate = self;
     [self setUpSubViews];
     方法二：重写drawPlaceholderInRect 见WZTextFieldPlaceHolder
     方法三：利用运行时 runtime 见WZTextFieldPlaceHolder
 16.automaticallyChangeAlpha //根据拖拽比例自动切换透明度
 17.self.autoresizingMask = UIViewAutoresizingNone;
    实现效果：控件不会跟着屏幕大小的改变而改变
 */

/**
 类别
 + UIBarButtonItem+WZCategory
 + UIView+WZCategory.h
 */

/** 
 扩展类
 + WZTabBar
 + WZVerticalButton
 + WZTextFieldPlaceHolder
 
 */


/** 
 跟网络相关问题
 + 多次请求
 + 网络不好时，同时下拉新数据，又上拉加载更多
 + 网络不好时，正在请求数据，视图被释放
 */

/** 
 待解决事情：
 - 怎样全局使用登录注册
 - 文件下载，然后显示
 - 怎么批量上传图片啊
 */
#endif /* ___h */
