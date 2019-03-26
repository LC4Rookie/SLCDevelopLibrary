//
//  SortViewController.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/26.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import "SortViewController.h"

#import "LCSortView.h"
#import "LCSortDataModel.h"

@interface SortViewController ()<LCSortViewDelegate>

@property (nonatomic, strong) LCSortView *sortView;
@property (nonatomic, copy) NSArray *dataArray;
@end

@implementation SortViewController

#pragma mark - life cyclic
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"sortView";
    
    [self.view addSubview:self.sortView];
    
    [self layoutPageSubviews];
    
    //加载数据
    [self loadData];
}

- (void)layoutPageSubviews {
    
    [self.sortView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(200);
    }];
    [self.view layoutIfNeeded];
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

#pragma mark - LCSortViewDelegate
- (void)sortView:(LCSortView *)view didSelectItemAtIndex:(NSInteger)index {
    
    [MBProgressHUD showAlertHud:[NSString stringWithFormat:@"点击了位置%ld",index] ToView:self.view];
}

#pragma mark - event response

#pragma mark - private mothods
- (void)loadData {
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        LCSortDataModel *model1 = [[LCSortDataModel alloc] init];
        model1.sortImageData = @"http://img.zcool.cn/community/014ed155c45ee36ac725580828a38e.jpg@2o.jpg";
        model1.sortName = [NSString stringWithFormat:@"%@%d",@"功能",i];
        [array addObject:model1];
    }
    self.sortView.sortDataArray = array;
}

#pragma mark - getters and setters
- (LCSortView *)sortView {
    
    if (!_sortView) {
        _sortView = [[LCSortView alloc] init];
        _sortView.row = 4;
        _sortView.section = 2;
        _sortView.showPageControl = YES;
        _sortView.delegate = self;
    }
    return _sortView;
}

@end
