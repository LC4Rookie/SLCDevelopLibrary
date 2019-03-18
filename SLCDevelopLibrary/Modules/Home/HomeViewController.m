//
//  HomeViewController.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/26.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewController.h"

#import "LCBannerView.h"
#import "LCSortView.h"
#import "LCSortDataModel.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LCBannerView *bannerView;
@property (nonatomic, strong) LCSortView *sortView;
@end

@implementation HomeViewController

#pragma mark - life cyclic
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:{
            return self.bannerView;
        }
        case 1:{
            return self.sortView;
        }
        default:{
            return nil;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:{
            return 140;
        }
        case 1:{
            return 200;
        }
        default:{
            return 0;
        }
    }
}

#pragma mark - event response

#pragma mark - private methods
- (void)loadData {
    
    self.bannerView.imageUrlArray = @[
                                  @"http://img.zcool.cn/community/01e33259521886a8012193a3f064c6.jpg",
                                  @"http://pic.90sjimg.com/back_pic/qk/back_origin_pic/00/03/68/e1212323ad69892eb1817b577774d210.jpg",
                                  @"http://pic22.nipic.com/20120621/1628220_155636709122_2.jpg",
                                  @"http://photo.16pic.com/00/54/82/16pic_5482369_b.jpg",
                                  @"http://pic.97uimg.com/back_pic/20/15/12/10/4ae3277c61c6b1c581c21013a5bd2e33.jpg",
                                  @"http://img.zcool.cn/community/014ed155c45ee36ac725580828a38e.jpg@2o.jpg"
                                  ];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 12; i++) {
        LCSortDataModel *model1 = [[LCSortDataModel alloc] init];
        model1.sortImageData = @"http://img.zcool.cn/community/014ed155c45ee36ac725580828a38e.jpg@2o.jpg";
        model1.sortName = @"测试";
        [array addObject:model1];
    }
    self.sortView.sortDataArray = array;
    [self.tableView reloadData];
}

#pragma mark - getters and setters
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (LCBannerView *)bannerView {
    
    if (!_bannerView) {
        _bannerView = [[LCBannerView alloc] init];
        
    }
    return _bannerView;
}

- (LCSortView *)sortView {
    
    if (!_sortView) {
        _sortView = [[LCSortView alloc] init];
        _sortView.row = 4;
        _sortView.section = 2;
    }
    return _sortView;
}

@end
