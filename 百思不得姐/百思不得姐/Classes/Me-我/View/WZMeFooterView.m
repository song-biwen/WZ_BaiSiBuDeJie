//
//  WZMeFooterView.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/11.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZMeFooterView.h"
#import "WZMeModel.h" //model
#import "WZVerticalButton.h"
#import <UIButton+WebCache.h>

@implementation WZMeFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];

        
        NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
        parameter[@"a"] = @"square";
        parameter[@"c"] = @"topic";
        WZLog(@"%@",parameter);
        
        [[AFHTTPSessionManager manager] GET:WZUrlDefault parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
//            [responseObject writeToFile:@"/Users/songbiwen/Desktop/Me.plist" atomically:YES];
            
            if ([responseObject isKindOfClass:[NSDictionary class]] && [[(NSDictionary *)responseObject allKeys]  containsObject:@"square_list"]) {
                NSArray *square_list = [WZMeModel mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
                [self creatSquareListView:square_list];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        }];
        
    }
    
    return self;
}

/** 创建视图 */
- (void)creatSquareListView:(NSArray *)square_list {
    
    int max_clos = 4;
    CGFloat buttonW = WZScreenWidth / max_clos;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i < square_list.count; i ++) {
        
        WZMeModel *model = square_list[i];
        
        WZVerticalButton *button = [WZVerticalButton buttonWithType:UIButtonTypeCustom];
        button.scale = 0.5;
        [button setTitle:model.name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button sd_setImageWithURL:WZUrl(model.icon) forState:UIControlStateNormal];
        
        button.x = i % max_clos * buttonW;
        button.y = i / max_clos * buttonH;
        button.width = buttonW;
        button.height = buttonH;
        [self addSubview:button];
    }
    
    // 8个方块, 每行显示4个, 计算行数 8/4 == 2 2
    // 9个方块, 每行显示4个, 计算行数 9/4 == 2 3
    // 7个方块, 每行显示4个, 计算行数 7/4 == 1 2
    
    // 总行数
    //    NSUInteger rows = sqaures.count / maxCols;
    //    if (sqaures.count % maxCols) { // 不能整除, + 1
    //        rows++;
    //    }
    
    // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
    
    NSUInteger rows = (square_list.count + max_clos - 1) / max_clos;
    
    self.height = rows * buttonH;
    
    //重绘
    [self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect {
    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
}

@end
