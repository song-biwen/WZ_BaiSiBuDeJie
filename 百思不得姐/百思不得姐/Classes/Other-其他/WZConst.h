//
//  WZConst.h
//  百思不得姐
//
//  Created by songbiwen on 16/6/17.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
 */
typedef enum {
    
    WZEssenceBaseTypeAll = 1,
    WZEssenceBaseTypePicture = 10,
    WZEssenceBaseTypeWord = 29,
    WZEssenceBaseTypeVoice = 31,
    WZEssenceBaseTypeVideo = 41
    
} WZEssenceBaseType;
/*精华cell margin*/
UIKIT_EXTERN CGFloat const WZEssenceBaseCellMargin;


/*精华cell 头部高度*/
UIKIT_EXTERN CGFloat const WZEssenceBaseCellTopHeight;

/*精华cell 底部高度*/
UIKIT_EXTERN CGFloat const WZEssenceBaseCellBottomHeight;

/*精华cell 图片的最大高度*/
UIKIT_EXTERN CGFloat const WZEssenceBaseCellPictureMaxHeight;

/*精华cell 图片超出最大高度后，现在默认高度*/
UIKIT_EXTERN CGFloat const WZEssenceBaseCellPictureDefaultHeight;

//性别
UIKIT_EXTERN NSString *const WZEssenceUserSexMale;
UIKIT_EXTERN NSString *const WZEssenceUserSexFemale;


//tabbar选择通知
UIKIT_EXTERN NSString *const WZTabbarDidSelectedNotification;