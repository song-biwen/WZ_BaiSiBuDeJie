//
//  WZTextFieldPlaceHolder.m
//  百思不得姐
//
//  Created by songbiwen on 16/6/14.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZTextFieldPlaceHolder.h"
#import <objc/runtime.h>


#define KPlaceHolderHeight 20
@implementation WZTextFieldPlaceHolder

/** 重写该方法改变placeHolder颜色 */
//- (void)drawPlaceholderInRect:(CGRect)rect {
////    [super drawPlaceholderInRect:rect]; 
//    
//    [self.placeholder drawInRect:CGRectMake(0, (self.height - KPlaceHolderHeight)/2.0 , self.width, KPlaceHolderHeight) withAttributes:@{NSFontAttributeName:self.font,NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
//    
//}

+ (void)initialize {
    [super initialize];
    
//    [self getIvars];
    
//    [self getProperties];
}

+ (void)getIvars {
    
    unsigned int count = 0;
    
    //拷贝出所有成员变量列表
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar var = ivars[i];
        WZLog(@"%s",ivar_getName(var));
    }
    
    //释放
    free(ivars);
    
}

+ (void)getProperties {
    
    unsigned int count = 0;
    //拷贝出所有属性列表
    objc_property_t *properties = class_copyPropertyList([UITextField class], &count);
    for (int i = 0; i < count; i ++) {
        objc_property_t property = properties[i];
        WZLog(@"%s",property_getName(property));
    }
    
    free(properties);
    
}

/** Xib */
- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    //用来设置光标的颜色
    self.tintColor = self.textColor;
    
    //取消第一响应
    [self resignFirstResponder];
}

/** 纯代码 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //用来设置光标的颜色
        self.tintColor = self.textColor;
        
        //取消第一响应
        [self resignFirstResponder];
    }
    return self;
}


/** 当前文本聚焦时会调用 */
- (BOOL)becomeFirstResponder {
    
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}

/** 当前文本失去聚焦时调用 */
- (BOOL)resignFirstResponder {
    
    [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    UILabel *placeHolderLabel = [self valueForKeyPath:@"_placeholderLabel"];
    placeHolderLabel.textColor = placeHolderColor;
}

@end

/*
 
 2016-06-14 15:59:16.531 百思不得姐[5607:234995] _textStorage
 2016-06-14 15:59:16.532 百思不得姐[5607:234995] _borderStyle
 2016-06-14 15:59:16.532 百思不得姐[5607:234995] _minimumFontSize
 2016-06-14 15:59:16.532 百思不得姐[5607:234995] _delegate
 2016-06-14 15:59:16.532 百思不得姐[5607:234995] _background
 2016-06-14 15:59:16.532 百思不得姐[5607:234995] _disabledBackground
 2016-06-14 15:59:16.532 百思不得姐[5607:234995] _clearButtonMode
 2016-06-14 15:59:16.532 百思不得姐[5607:234995] _leftView
 2016-06-14 15:59:16.532 百思不得姐[5607:234995] _leftViewMode
 2016-06-14 15:59:16.533 百思不得姐[5607:234995] _rightView
 2016-06-14 15:59:16.533 百思不得姐[5607:234995] _rightViewMode
 2016-06-14 15:59:16.533 百思不得姐[5607:234995] _traits
 2016-06-14 15:59:16.533 百思不得姐[5607:234995] _nonAtomTraits
 2016-06-14 15:59:16.533 百思不得姐[5607:234995] _fullFontSize
 2016-06-14 15:59:16.533 百思不得姐[5607:234995] _padding
 2016-06-14 15:59:16.533 百思不得姐[5607:234995] _selectionRangeWhenNotEditing
 2016-06-14 15:59:16.533 百思不得姐[5607:234995] _scrollXOffset
 2016-06-14 15:59:16.533 百思不得姐[5607:234995] _scrollYOffset
 2016-06-14 15:59:16.534 百思不得姐[5607:234995] _progress
 2016-06-14 15:59:16.534 百思不得姐[5607:234995] _clearButton
 2016-06-14 15:59:16.534 百思不得姐[5607:234995] _clearButtonOffset
 2016-06-14 15:59:16.534 百思不得姐[5607:234995] _leftViewOffset
 2016-06-14 15:59:16.534 百思不得姐[5607:234995] _rightViewOffset
 2016-06-14 15:59:16.534 百思不得姐[5607:234995] _backgroundView
 2016-06-14 15:59:16.534 百思不得姐[5607:234995] _disabledBackgroundView
 2016-06-14 15:59:16.534 百思不得姐[5607:234995] _systemBackgroundView
 2016-06-14 15:59:16.534 百思不得姐[5607:234995] _floatingContentView
 2016-06-14 15:59:16.534 百思不得姐[5607:234995] _contentBackdropView
 2016-06-14 15:59:16.535 百思不得姐[5607:234995] _fieldEditorBackgroundView
 2016-06-14 15:59:16.535 百思不得姐[5607:234995] _fieldEditorEffectView
 2016-06-14 15:59:16.535 百思不得姐[5607:234995] _displayLabel
 2016-06-14 15:59:16.535 百思不得姐[5607:234995] _placeholderLabel
 2016-06-14 15:59:16.535 百思不得姐[5607:234995] _dictationLabel
 2016-06-14 15:59:16.535 百思不得姐[5607:234995] _suffixLabel
 2016-06-14 15:59:16.535 百思不得姐[5607:234995] _prefixLabel
 2016-06-14 15:59:16.535 百思不得姐[5607:234995] _iconView
 2016-06-14 15:59:16.536 百思不得姐[5607:234995] _label
 2016-06-14 15:59:16.536 百思不得姐[5607:234995] _labelOffset
 2016-06-14 15:59:16.536 百思不得姐[5607:234995] _interactionAssistant
 2016-06-14 15:59:16.536 百思不得姐[5607:234995] _selectGestureRecognizer
 2016-06-14 15:59:16.536 百思不得姐[5607:234995] _inputView
 2016-06-14 15:59:16.536 百思不得姐[5607:234995] _inputAccessoryView
 2016-06-14 15:59:16.536 百思不得姐[5607:234995] _systemInputViewController
 2016-06-14 15:59:16.536 百思不得姐[5607:234995] _atomBackgroundView
 2016-06-14 15:59:16.536 百思不得姐[5607:234995] _textFieldFlags
 2016-06-14 15:59:16.537 百思不得姐[5607:234995] _deferringBecomeFirstResponder
 2016-06-14 15:59:16.537 百思不得姐[5607:234995] _avoidBecomeFirstResponder
 2016-06-14 15:59:16.537 百思不得姐[5607:234995] _setSelectionRangeAfterFieldEditorIsAttached
 2016-06-14 15:59:16.538 百思不得姐[5607:234995] _animateNextHighlightChange
 2016-06-14 15:59:16.538 百思不得姐[5607:234995] _tvUseVibrancy
 2016-06-14 15:59:16.538 百思不得姐[5607:234995] _baselineLayoutConstraint
 2016-06-14 15:59:16.538 百思不得姐[5607:234995] _baselineLayoutLabel
 2016-06-14 15:59:16.538 百思不得姐[5607:234995] _tvCustomTextColor

 */
