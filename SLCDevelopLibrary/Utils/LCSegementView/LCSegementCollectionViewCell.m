//
//  LCSegementCollectionViewCell.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/25.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import "LCSegementCollectionViewCell.h"

@interface LCSegementCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (strong, nonatomic) UIView *underLine;
@end

@implementation LCSegementCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.selectColor = [UIColor redColor];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.underLine];
        
        [self layoutPageSubviews];
    }
    return self;
}

- (void)layoutPageSubviews {
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).width.insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    [self.underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(0);
        make.width.equalTo(self.contentView).multipliedBy(0.3);
        make.height.mas_equalTo(1.5);
    }];
}

#pragma mark - getters and setters
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)underLine {
    
    if (!_underLine) {
        _underLine = [[UIView alloc] init];
        _underLine.backgroundColor = self.selectColor;
    }
    return _underLine;
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    self.titleLabel.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor {
    
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}

- (void)setSelectColor:(UIColor *)selectColor {
    
    _selectColor = selectColor;
}

- (void)setIsSelected:(BOOL)isSelected {
    
    if (isSelected) {
        self.underLine.backgroundColor = self.selectColor;
    }else {
        self.underLine.backgroundColor = self.backgroundColor;
    }
}
@end
