//
//  LCCalendarViewController.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/19.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import "LCCalendarViewController.h"

#import "FSCalendar.h"

@interface LCCalendarViewController ()<FSCalendarDelegate, FSCalendarDataSource>

@property (nonatomic, strong) FSCalendar *calendar;
@end

@implementation LCCalendarViewController

#pragma mark - life cyclic
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self hideBackButton];
    [self addNavigationItemWithTitles:@[@"取消"] textColor:KWhiteColor isLeft:YES target:self action:@selector(cancelButtonClick:) tags:nil];
    
    [self.view addSubview:self.calendar];
    
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews {
    
    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-KSafeAreaBottomHeight);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
}

#pragma mark FSCalendarDelegate
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    
    if ([self.delegate respondsToSelector:@selector(LCCalendarViewControllerDelegateDidSelectDate:)]) {
        [self.delegate LCCalendarViewControllerDelegateDidSelectDate:date];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - event response
- (void)cancelButtonClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private methods

#pragma mark - getters and setters
- (FSCalendar *)calendar {
    
    if (!_calendar) {
        _calendar = [[FSCalendar alloc] init];
        _calendar.backgroundColor = RGBA(250, 250, 250, 1);
        _calendar.scrollDirection = FSCalendarScrollDirectionVertical;
        //设置分页为NO后才可以改变日期高度
        _calendar.pagingEnabled = NO;
        //占位符样式改为只显示当月
        _calendar.placeholderType = FSCalendarPlaceholderTypeNone;
        //设置地区 显示中文
        _calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
        //年月样式
        _calendar.headerHeight = 30;
        _calendar.appearance.headerDateFormat = @"yyyy年MM月";
        _calendar.appearance.headerTitleColor = KBlackColor;
        _calendar.calendarHeaderView.backgroundColor = KWhiteColor;
        //周样式
        _calendar.weekdayHeight = 25;
        _calendar.calendarWeekdayView.backgroundColor = KWhiteColor;
        _calendar.appearance.weekdayTextColor = KGray2Color;
        //日期高度
        _calendar.rowHeight = 40;
        _calendar.dataSource = self;
        _calendar.delegate = self;
    }
    return _calendar;
}

@end
