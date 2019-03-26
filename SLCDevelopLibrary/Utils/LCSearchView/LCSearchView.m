//
//  LCSearchView.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/25.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import "LCSearchView.h"

@interface LCSearchView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UITextField *searchTextField;
@end

@implementation LCSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        //构建输入框左侧view  用view包裹imageview作为输入框leftview防止图片紧贴
        [self.leftView addSubview:self.leftImageView];
        [self addSubview:self.searchTextField];
        
        [self layoutPageSubviews];
    }
    return self;
}

- (void)layoutPageSubviews {
    
    self.leftView.frame = CGRectMake(0, 0, 30, 30);
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftView);
        make.left.equalTo(self.leftView).offset(10);
        make.width.height.equalTo(self.leftView).multipliedBy(0.5);
    }];
    
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(30);
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(searchView:textShouldReturn:)]) {
        [self.delegate searchView:self textShouldReturn:textField.text];
    }
    return YES;
}

#pragma mark - event response
- (void)textFieldChanged:(UITextField *)textField {
    
    if ([self.delegate respondsToSelector:@selector(searchView:textDidChange:)]) {
        [self.delegate searchView:self textDidChange:textField.text];
    }
}

- (void)textFieldEditingDidBegin:(UITextField *)textField {
    
    if ([self.delegate respondsToSelector:@selector(searchView:textShouldBeginEditing:)]) {
        [self.delegate searchView:self textShouldBeginEditing:@""];
    }
}

#pragma mark - private method
/** 添加渐变背景layer */
- (void)addBackgroundLayer:(CAGradientLayer *)layer {
    
    [self.layer addSublayer:layer];
    //防止layer遮挡控件
    [self bringSubviewToFront:self.searchTextField];
}

- (void)becomeFirstResponder {
    
    [self.searchTextField becomeFirstResponder];
}

- (void)resignFirstResponder {
    
    [self.searchTextField resignFirstResponder];
}

#pragma mark - getters and setters
- (UIImageView *)leftImageView {
    
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        _leftImageView.image = [UIImage imageNamed:@"icon_search"];
    }
    return _leftImageView;
}

- (UIView *)leftView {
    
    if (!_leftView) {
        _leftView = [[UIView alloc] init];
    }
    return _leftView;
}

- (UITextField *)searchTextField {
    
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] init];
        _searchTextField.backgroundColor = KWhiteColor;
        _searchTextField.layer.cornerRadius = 3;
        _searchTextField.layer.masksToBounds = YES;
        _searchTextField.font = [UIFont systemFontOfSize:15];
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        _searchTextField.leftView = self.leftView;
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.delegate = self;
        [_searchTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        [_searchTextField addTarget:self action:@selector(textFieldEditingDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    }
    return _searchTextField;
}

- (void)setSearchInfo:(NSString *)searchInfo {
    
    _searchInfo = searchInfo;
    self.searchTextField.text = searchInfo;
}

- (void)setPlaceholder:(NSString *)placeholder {
    
    _placeholder = placeholder;
    self.searchTextField.placeholder = placeholder;
}

- (void)setHiddenLeftView:(BOOL)hiddenLeftView {
    
    _hiddenLeftView = hiddenLeftView;
    self.searchTextField.leftView.hidden = hiddenLeftView;
}

- (void)setInputControlBackground:(UIColor *)inputControlBackground {
    
    _inputControlBackground = inputControlBackground;
    self.searchTextField.backgroundColor = inputControlBackground;
}

@end
