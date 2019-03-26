//
//  BannerViewController.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/26.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import "BannerViewController.h"

#import "LCBannerView.h"

@interface BannerViewController ()

@property (nonatomic, strong) LCBannerView *bannerView;
@property (nonatomic, copy) NSArray *imageArray;
@end

@implementation BannerViewController

#pragma mark - life cyclic
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"banner";
    
    [self.view addSubview:self.bannerView];
    
    [self layoutPageSubviews];
    
    //加载数据
    [self loadData];
}

- (void)layoutPageSubviews {
    
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(140);
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

#pragma mark - event response

#pragma mark - private mothods
- (void)loadData {
    
    self.bannerView.imageUrlArray = self.imageArray;
    switch (self.type) {
        case BannerViewTypeUpArc:{
            self.bannerView.isUp = YES;
            [self.bannerView drawRadian];
            break;
        }
        case BannerViewTypeDownArc:{
            self.bannerView.isUp = NO;
            [self.bannerView drawRadian];
            break;
        }
        default:{
            break;
        }
    }
}

#pragma mark - getters and setters
- (LCBannerView *)bannerView {
    
    if (!_bannerView) {
        _bannerView = [[LCBannerView alloc] init];
    }
    return _bannerView;
}

- (NSArray *)imageArray {
    
    if (!_imageArray) {
        _imageArray = @[
                        @"http://img.zcool.cn/community/01e33259521886a8012193a3f064c6.jpg",
                        @"http://pic.90sjimg.com/back_pic/qk/back_origin_pic/00/03/68/e1212323ad69892eb1817b577774d210.jpg",
                        @"http://pic22.nipic.com/20120621/1628220_155636709122_2.jpg",
                        @"http://photo.16pic.com/00/54/82/16pic_5482369_b.jpg",
                        @"http://pic.97uimg.com/back_pic/20/15/12/10/4ae3277c61c6b1c581c21013a5bd2e33.jpg",
                        @"http://img.zcool.cn/community/014ed155c45ee36ac725580828a38e.jpg@2o.jpg"
                        ];
    }
    return _imageArray;
}

@end
