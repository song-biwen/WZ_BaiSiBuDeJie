//
//  WZShowImageViewController.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/20.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZShowImageViewController.h"
#import "WZEssenceListModel.h"
#import "WZCircularProgressView.h"


@interface WZShowImageViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scroll_view;
@property (nonatomic, weak) UIImageView *image_view;

@property (weak, nonatomic) IBOutlet WZCircularProgressView *progress_view;

@end

@implementation WZShowImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat pictureW = WZScreenWidth;
    CGFloat pictureH = pictureW * self.listModel.height / self.listModel.width;
    
    UIImageView *image_view = [[UIImageView alloc] init];
    image_view.size = CGSizeMake(pictureW, pictureH);
    
    CGPoint origin;
    if (pictureH > WZScreenHeight) {
        //图片超出屏幕高度
        origin = CGPointMake(0, 0);
        self.scroll_view.contentSize = image_view.size;
        
    }else {
        //图片没有超出屏幕高度
        origin = CGPointMake(0, (WZScreenHeight - pictureH) * 0.5);
        
    }
    
    image_view.origin = origin;
    
    //同步下载进度
    self.progress_view.hidden = YES;
    [self.progress_view setProgress:self.listModel.pictureProgress animated:YES];
    
    [image_view sd_setImageWithURL:WZUrl(self.listModel.larger_image) placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progress_view.hidden= NO;
        self.listModel.pictureProgress = receivedSize * 1.0 / expectedSize;
        [self.progress_view setProgress:self.listModel.pictureProgress animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progress_view.hidden = YES;
        
    }];

    
    [self.scroll_view addSubview:image_view];
    self.image_view = image_view;
    
    
    self.image_view.userInteractionEnabled = YES;
    [self.image_view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction)]];
}

/** 返回 */
- (IBAction)backAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


/** 转发 */
- (IBAction)shareAction {
}

/** 保存 */
- (IBAction)saveAction {
    if (self.image_view.image == nil) return;
    
    UIImageWriteToSavedPhotosAlbum(self.image_view.image, self, @selector(image: didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"图片保存失败"];
    }else {
        [SVProgressHUD showSuccessWithStatus:@"图片保存成功"];
    }
}
@end
