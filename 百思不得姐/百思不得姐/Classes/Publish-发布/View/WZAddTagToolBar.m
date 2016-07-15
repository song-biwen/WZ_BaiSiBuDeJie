//
//  WZAddTagToolBar.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/14.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZAddTagToolBar.h"

@interface WZAddTagToolBar ()
//顶部视图
@property (weak, nonatomic) IBOutlet UIView *topView;
@end

@implementation WZAddTagToolBar

+ (instancetype)toolBar {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

/** 
 * @
 */
- (IBAction)peopleAction {
    WZLogFunc;
}

/** 
 * # 选择主题
 */
- (IBAction)themeAction {
    WZLogFunc;
}
@end
