//
//  LCPickerView.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/19.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import "LCPickerView.h"

@interface LCPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, assign) LCPickerViewType viewType;
@end

@implementation LCPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [self initWithPickerViewType:LCPickerViewTypeData];
    return self;
}

- (instancetype)initWithPickerViewType:(LCPickerViewType)type {
    
    self = [super initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - KSafeAreaBottomHeight)];
    if (self) {
        [self setBackgroundColor:RGBA(0, 0, 0, 0.5)];
        
        self.viewType = type;
        self.topViewBackgroundColor = KAppShallowGrayColor;
        self.cancelTitle = @"取消";
        self.confirmTitle = @"确定";
        self.cancelTextColor = KAppBlueColor;
        self.confirmTextColor = KAppBlueColor;
        
        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTapGesture.numberOfTapsRequired = 1;
        singleTapGesture.numberOfTouchesRequired = 1;
        singleTapGesture.delegate = self;
        [self addGestureRecognizer:singleTapGesture];
        
        [self addSubview:self.coverView];
        [self.coverView addSubview:self.topView];
        [self.topView addSubview:self.titleLabel];
        [self.topView addSubview:self.cancelButton];
        [self.topView addSubview:self.confirmButton];
        if (self.viewType == LCPickerViewTypeData) {
            [self.coverView addSubview:self.pickerView];
        }else {
            [self.coverView addSubview:self.datePicker];
        }
        
        [self layoutPageSubviews];
    }
    return self;
}

- (void)layoutPageSubviews {
    
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(260);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.coverView);
        make.height.mas_equalTo(40);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(5);
        make.centerY.equalTo(self.topView);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(35);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView).offset(-5);
        make.centerY.equalTo(self.topView);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(35);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.confirmButton.mas_left).offset(-10);
        make.left.equalTo(self.cancelButton.mas_right).offset(10);
        make.centerY.equalTo(self.topView);
        make.height.mas_equalTo(30);
    }];
    
    if (self.viewType == LCPickerViewTypeData) {
        [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.coverView);
            make.height.mas_equalTo(220);
        }];
    }else {
        [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.coverView);
            make.height.mas_equalTo(220);
        }];
    }
}

- (void)showPickerView {
    
    if (self.viewType == LCPickerViewTypeData) {
        [self.pickerView reloadInputViews];
    }else {
        [self.datePicker reloadInputViews];
    }
    [kAppDelegate.getCurrentUIVC.navigationController.view addSubview:self];
}

#pragma mark - UIPickerViewDelegate && UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.dataArray.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *detail;
    id data = [self.dataArray objectAtIndex:row];
    if ([data isKindOfClass:[NSDictionary class]]) {
        detail = [data objectForKey:self.key];
    }else {
        detail = data;
    }
    return detail;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews) {
        if (singleLine.frame.size.height < 1){
            singleLine.backgroundColor = [UIColor lightGrayColor];
        }
    }
    //设置文字的属性
    UILabel *pickerLabel = [[UILabel alloc] init];
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    pickerLabel = [[UILabel alloc] init];
    pickerLabel.adjustsFontSizeToFitWidth = YES;
    [pickerLabel setTextAlignment:NSTextAlignmentCenter];
    [pickerLabel setFont:[UIFont boldSystemFontOfSize:17]];
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([touch.view isDescendantOfView:self.coverView]) {
        return NO;
    }
    return YES;
}

#pragma mark - event response
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    [self removeFromSuperview];
}

- (void)confirmButtonClick:(UIButton *)sender {
    
    if (self.viewType == LCPickerViewTypeData) {
        NSInteger row = [self.pickerView selectedRowInComponent:0];
        if ([self.delegate respondsToSelector:@selector(pickerView:didSelectRow:)]) {
            [self.delegate pickerView:self didSelectRow:row];
        }
    }else {
        if ([self.delegate respondsToSelector:@selector(pickerView:didChangeDate:)]) {
            [self.delegate pickerView:self didChangeDate:self.datePicker.date];
        }
    }
    [self removeFromSuperview];
}

- (void)cancelButtonClick:(UIButton *)sender {
    
    [self removeFromSuperview];
}

#pragma mark - getters and setters
- (UIView *)coverView {
    
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = KWhiteColor;
        _coverView.layer.cornerRadius = 5;
        _coverView.layer.masksToBounds = YES;
    }
    return _coverView;
}

- (UIView *)topView {
    
    if (!_topView) {
        _topView = [[UIView alloc] init];
    }
    return _topView;
}

- (UIButton *)confirmButton {
    
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] init];
        [_confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIButton *)cancelButton {
    
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIPickerView *)pickerView {
    
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.backgroundColor = KWhiteColor;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UIDatePicker *)datePicker {
    
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.backgroundColor = KWhiteColor;
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [_datePicker setDate:[NSDate new] animated:YES];
    }
    return _datePicker;
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    self.titleLabel.text = title;
}

- (void)setTopViewBackgroundColor:(UIColor *)topViewBackgroundColor {
    
    _topViewBackgroundColor = topViewBackgroundColor;
    self.topView.backgroundColor = topViewBackgroundColor;
}

- (void)setCancelTitle:(NSString *)cancelTitle {
    
    _cancelTitle = cancelTitle;
    self.cancelButton.hidden = kStringIsEmpty(cancelTitle);
    [self.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
}

- (void)setConfirmTitle:(NSString *)confirmTitle {
    
    _confirmTitle = confirmTitle;
    self.confirmButton.hidden = kStringIsEmpty(confirmTitle);
    [self.confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
}

- (void)setCancelTextColor:(UIColor *)cancelTextColor {
    
    _cancelTextColor = cancelTextColor;
    [self.cancelButton setTitleColor:cancelTextColor forState:UIControlStateNormal];
}

- (void)setConfirmTextColor:(UIColor *)confirmTextColor {
    
    _confirmTextColor = confirmTextColor;
    [self.confirmButton setTitleColor:confirmTextColor forState:UIControlStateNormal];
}

- (void)setKey:(NSString *)key {
    
    _key = key;
}

- (void)setDataArray:(NSArray *)dataArray {
    
    _dataArray = dataArray;
}

- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode {
    
    _datePickerMode = datePickerMode;
    _datePicker.datePickerMode = datePickerMode;
}

- (void)setMaxDate:(NSDate *)maxDate {
    
    _maxDate = maxDate;
    [self.datePicker setMaximumDate:maxDate];
}

- (void)setMinDate:(NSDate *)minDate {
    
    _minDate = minDate;
    [self.datePicker setMinimumDate:minDate];
}

@end
