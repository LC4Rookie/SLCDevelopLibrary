//
//  HomeCollectionViewCell.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/26.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@interface HomeCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *functionImageView;
@end

@implementation HomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.functionImageView];
        [self.contentView addSubview:self.titleLabel];
        
        [self layoutPageSubviews];
    }
    return self;
}

- (void)layoutPageSubviews {
    
    [self.functionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.contentView);
        make.width.height.equalTo(self.contentView).multipliedBy(0.5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.equalTo(self.functionImageView.mas_bottom).offset(5);
        make.height.mas_equalTo(30);
    }];
}

#pragma mark - event response

#pragma mark - private method

#pragma mark - getters and setters
- (UIImageView *)functionImageView {
    
    if (!_functionImageView) {
        _functionImageView = [[UIImageView alloc] init];
        _functionImageView.image = [UIImage imageNamed:@"icon_mainFunction"];
    }
    return _functionImageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    self.titleLabel.text = title;
}
@end
