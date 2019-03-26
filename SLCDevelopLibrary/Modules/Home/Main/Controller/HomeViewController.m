//
//  HomeViewController.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/26.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import "HomeViewController.h"
#import "BannerTypeListViewController.h"
#import "SortViewController.h"
#import "PickerTypeListViewController.h"
#import "PhotoTypeListViewController.h"

#import "HomeCollectionViewCell.h"

@interface HomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *dataArray;
@end

@implementation HomeViewController

#pragma mark - life cyclic
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    [self.view addSubview:self.collectionView];
    
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews {
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
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

#pragma mark - UICollectionViewDelegateFlowLayout && UICollectionViewDataSource && UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = [self.dataArray objectAtIndex:indexPath.row];
    HomeCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = KWhiteColor;
    cell.title = title;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:{
            BannerTypeListViewController *viewController = [[BannerTypeListViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case 1:{
            SortViewController *viewController = [[SortViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case 2:{
            PickerTypeListViewController *viewController = [[PickerTypeListViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case 3:{
            PhotoTypeListViewController *viewController = [[PhotoTypeListViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        default:{
            break;
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = KScreenWidth / 3 - 1;
    CGSize itemSize = CGSizeMake(width, width);
    return itemSize;
}

#pragma mark - event response

#pragma mark - private methods

#pragma mark - getters and setters
- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.backgroundColor = KGray2Color;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
    }
    return _collectionView;
}

- (NSArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = @[
                       @"LCBannerView",
                       @"LCSortView",
                       @"LCPickerView",
                       @"LCPhotoView"
                       ];
    }
    return _dataArray;
}

@end
