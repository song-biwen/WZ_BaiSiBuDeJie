//
//  WZCommentCell.h
//  百思不得姐
//
//  Created by songbiwen on 16/7/4.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WZEssenceTopComentModel;
@protocol WZCommentCellDelegate <NSObject>

- (void)playVoiceWithCommentModel:(WZEssenceTopComentModel *)comentModel;
@end


/** 评论 */
@class WZEssenceTopComentModel;

@interface WZCommentCell : UITableViewCell

+ (instancetype)cellOfTableView:(UITableView *)tableView;

@property (nonatomic, strong) WZEssenceTopComentModel *comentModel;

@property (nonatomic, assign) id<WZCommentCellDelegate> delegate;

@end
