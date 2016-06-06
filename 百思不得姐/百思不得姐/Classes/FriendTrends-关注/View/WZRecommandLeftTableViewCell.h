//
//  WZRecommandLeftTableViewCell.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/6.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 推荐关注-左边列表 */

@protocol WZRecommandLeftTableViewCellDelegate <NSObject>

- (void)buttonClickForWZRecommandLeftTableViewCellWithSender:(UIButton *)button;

@end

@interface WZRecommandLeftTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *item_button;

@property (nonatomic, strong) NSDictionary *info;

@property (nonatomic, strong) id <WZRecommandLeftTableViewCellDelegate> delegate;

@end
