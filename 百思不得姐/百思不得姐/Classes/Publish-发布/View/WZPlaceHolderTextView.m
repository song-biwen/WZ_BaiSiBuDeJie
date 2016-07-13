//
//  WZPlaceHolderTextView.m
//  百思不得姐
//
//  Created by songbiwen on 16/7/13.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZPlaceHolderTextView.h"

@interface WZPlaceHolderTextView ()
/** 占位文字label*/
@property (nonatomic, weak) UILabel *placeHolderLabel;
@end

@implementation WZPlaceHolderTextView

/** 占位文字label */
- (UILabel *)placeHolderLabel {
    if (!_placeHolderLabel) {
        
        UILabel *label = [[UILabel alloc] init];
        label.x = 4;
        label.y = 7;
        label.numberOfLines = 0;
        [self addSubview:label];
        _placeHolderLabel = label;
        
    }
    return _placeHolderLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        
        //默认字体
        self.font = [UIFont systemFontOfSize:15];
        //默认颜色
        self.placeHolderColor = [UIColor darkGrayColor];
        
        //监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

/** 监听文本内容发生改变 */
- (void)textDidChange {
    self.placeHolderLabel.hidden = self.hasText;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.placeHolderLabel.width = self.width - 2 * self.placeHolderLabel.x;
    [self.placeHolderLabel sizeToFit];
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    self.placeHolderLabel.text = placeHolder;
    
    [self setNeedsLayout];
}


- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    _placeHolderColor = placeHolderColor;
    self.placeHolderLabel.textColor = placeHolderColor;
}


- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    self.placeHolderLabel.font = font;
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 * setNeedsDisplay方法 : 会在恰当的时刻自动调用drawRect:方法
 * setNeedsLayout方法 : 会在恰当的时刻调用layoutSubviews方法
 */

@end
