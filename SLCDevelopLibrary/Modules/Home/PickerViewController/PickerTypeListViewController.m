//
//  PickerTypeListViewController.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/26.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import "PickerTypeListViewController.h"

#import "TableViewCell.h"
#import "LCPickerView.h"

@interface PickerTypeListViewController ()<UITableViewDelegate, UITableViewDataSource, LCPickerViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, copy) NSArray *pickerDataArray;
@end

@implementation PickerTypeListViewController

#pragma mark - life cyclic
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"PickerView";
    
    [self.view addSubview:self.tableView];
    
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews {
 
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = [self.dataArray objectAtIndex:indexPath.row];
    TableViewCell *cell = [TableViewCell cellWithTableView:tableView];
    cell.title = title;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        LCPickerView *pickerView = [[LCPickerView alloc] initWithPickerViewType:LCPickerViewTypeData];
        pickerView.delegate = self;
        pickerView.title = @"我是标题";
        pickerView.cancelTitle = @"关闭";
        pickerView.cancelTextColor = KRedColor;
        pickerView.confirmTextColor = KBlackColor;
        pickerView.dataArray = self.pickerDataArray;
        [pickerView showPickerView];
    }else {
        LCPickerView *pickerView = [[LCPickerView alloc] initWithPickerViewType:LCPickerViewTypeDate];
        pickerView.delegate = self;
        pickerView.title = @"我是标题";
        pickerView.cancelTitle = @"";
        pickerView.maxDate = [NSDate new];
        [pickerView showPickerView];
    }
}

#pragma mark - LCPickerViewDelegate
- (void)pickerView:(LCPickerView *)pickerView didSelectRow:(NSInteger)row {
    
    NSString *title = [self.pickerDataArray objectAtIndex:row];
    [MBProgressHUD showAlertHud:[NSString stringWithFormat:@"选择了%@",title] ToView:self.view];
}

- (void)pickerView:(LCPickerView *)pickerView didChangeDate:(NSDate *)date {
    
    NSString *time = [date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    [MBProgressHUD showAlertHud:[NSString stringWithFormat:@"选择了%@",time] ToView:self.view];
}

#pragma mark - event response

#pragma mark - private mothods

#pragma mark - getters and setters
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = @[
                       @"选择数据",
                       @"选择日期",
                       ];
    }
    return _dataArray;
}

- (NSArray *)pickerDataArray {
    
    if (!_pickerDataArray) {
        _pickerDataArray = @[
                       @"测试1",
                       @"测试2",
                       @"测试3",
                       @"测试4",
                       @"测试5",
                       ];
    }
    return _pickerDataArray;
}

@end
