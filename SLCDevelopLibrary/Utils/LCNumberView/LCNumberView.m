//
//  LCNumberView.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/18.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import "LCNumberView.h"

NSString *const LCNumberViewDidChangeForNumber = @"LCNumberViewDidChangeForNumber";

@interface LCNumberView ()

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *subtractButton;
@property (nonatomic, strong) UITextField *countTextField;
@end

@implementation LCNumberView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.addButton];
        [self addSubview:self.subtractButton];
        [self addSubview:self.countTextField];
        
        [self layoutPageSubviews];
    }
    return self;
}

- (void)layoutPageSubviews {
    
    [self.subtractButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self).offset(0);
        make.width.equalTo(self.subtractButton.mas_height);
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self).offset(0);
        make.width.equalTo(self.addButton.mas_height);
    }];
    
    [self.countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self).offset(0);
        make.left.equalTo(self.subtractButton.mas_right).offset(0);
        make.right.equalTo(self.addButton.mas_left).offset(0);
    }];
}

#pragma mark - event response
- (void)addButtonClick:(UIButton *)sender {
    
    NSInteger count = self.countTextField.text.integerValue;
    self.currentNumber = [NSString stringWithFormat:@"%ld",++count];
    self.countTextField.text = self.currentNumber;
    [self handleNumberChange:LCNumberViewChangeTypeAdd];
}

- (void)subtractButtonClick:(UIButton *)sender {
    
    NSInteger count = self.countTextField.text.integerValue;
    if (count <= 1) {
        return;
    }
    self.currentNumber = [NSString stringWithFormat:@"%ld",--count];
    self.countTextField.text = self.currentNumber;
    [self handleNumberChange:LCNumberViewChangeTypeSubtract];
}

- (void)textFieldChanged:(UITextField *)textField {
    
    self.currentNumber = textField.text;
    self.countTextField.text = textField.text;
    [self handleNumberChange:LCNumberViewChangeTypeInput];
}

#pragma mark - private method
/** 事件回调 */
- (void)handleNumberChange:(LCNumberViewChangeType)type {
    
    //delegate或者responder Chain
    NSDictionary *userInfo = @{@"number":self.countTextField.text, @"type":@(type)};
    [self routerEventWithName:LCNumberViewDidChangeForNumber userInfo:userInfo];
    
    if ([self.delegate respondsToSelector:@selector(numberView:didChangeNumber:changeType:)]) {
        [self.delegate numberView:self didChangeNumber:self.countTextField.text changeType:type];
    }
}

#pragma mark - getters and setters
- (UIButton *)addButton {
    
    if (!_addButton) {
        _addButton = [[UIButton alloc] init];
        [_addButton setTitle:@"+" forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UIButton *)subtractButton {
    
    if (!_subtractButton) {
        _subtractButton = [[UIButton alloc] init];
        [_subtractButton setTitle:@"-" forState:UIControlStateNormal];
        [_subtractButton addTarget:self action:@selector(subtractButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subtractButton;
}

- (UITextField *)countTextField {
    
    if (!_countTextField) {
        _countTextField = [[UITextField alloc] init];
        _countTextField.textAlignment = NSTextAlignmentCenter;
        [_countTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _countTextField;
}

- (void)setIsEditing:(BOOL)isEditing {
    
    _isEditing = isEditing;
    self.countTextField.userInteractionEnabled = isEditing;
}

- (void)setBorderColor:(UIColor *)borderColor {
    
    _borderColor = borderColor;
    self.countTextField.layer.borderColor = borderColor.CGColor;
    self.countTextField.layer.borderWidth = 0.5;
}

- (void)setButtonBorderColor:(UIColor *)buttonBorderColor {
    
    _buttonBorderColor = buttonBorderColor;
    self.addButton.layer.borderColor = buttonBorderColor.CGColor;
    self.addButton.layer.borderWidth = 0.5;
    self.subtractButton.layer.borderColor = buttonBorderColor.CGColor;
    self.subtractButton.layer.borderWidth = 0.5;
}

- (void)setButtonTitleColor:(UIColor *)buttonTitleColor {
    
    _buttonTitleColor = buttonTitleColor;
    [self.addButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    [self.subtractButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
}

- (void)setButtonBackgroundColor:(UIColor *)buttonBackgroundColor {
    
    _buttonBackgroundColor = buttonBackgroundColor;
    [self.addButton setBackgroundColor:buttonBackgroundColor];
    [self.subtractButton setBackgroundColor:buttonBackgroundColor];
}

- (void)setCurrentNumber:(NSString *)currentNumber {
    
    _currentNumber = currentNumber;
    self.countTextField.text = currentNumber;
}

@end
