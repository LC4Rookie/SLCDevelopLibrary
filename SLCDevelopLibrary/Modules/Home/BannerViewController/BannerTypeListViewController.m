//
//  BannerTypeListViewController.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/26.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import "BannerTypeListViewController.h"
#import "BannerViewController.h"

#import "TableViewCell.h"

@interface BannerTypeListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@end

@implementation BannerTypeListViewController

#pragma mark - life cyclic
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"banner";
    
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
    
    return 3;
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
    
    BannerViewController *viewController = [[BannerViewController alloc] init];
    viewController.type = indexPath.row;
    [self.navigationController pushViewController:viewController animated:YES];
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
                       @"正常banner",
                       @"带向上弧线banner",
                       @"带向下弧线banner",
                       ];
    }
    return _dataArray;
}
@end
