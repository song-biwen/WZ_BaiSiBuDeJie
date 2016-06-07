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
 下次学习0723 04
 
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
 
 
 */
#endif /* ___h */
