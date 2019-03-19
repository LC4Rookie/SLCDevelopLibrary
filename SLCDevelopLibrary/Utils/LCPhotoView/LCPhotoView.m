//
//  LCPhotoView.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/19.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import "LCPhotoView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "LCPhotoDataModel.h"
#import "LCCheckPhotoView.h"
#import "LCPhotoInfoCollectionViewCell.h"

typedef NS_ENUM(NSInteger, LCPhotoViewSelectType) {
    /** 拍照 */
    LCPhotoViewSelectTypeTakePhoto,
    /** 从相册获取 */
    LCPhotoViewSelectTypeReadImageFromLibrary,
    /** 查看图片 */
    LCPhotoViewSelectTypeCheckPhoto,
    /** 删除 */
    LCPhotoViewSelectTypeDelete,
};

NSString *const LCPhotoViewDidChangeForData = @"LCPhotoViewDidChangeForData";

@interface LCPhotoView ()<UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UICollectionView *photoCollectionView;
/** item数量 */
@property (nonatomic, assign) NSInteger itemNumber;
/** 点击位置 */
@property (assign, nonatomic) NSInteger selectIndex;
@end

@implementation LCPhotoView

#pragma mark - life cyclic
-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.photoCollectionView];
        
        [self layoutPageSubviews];
    }
    return self;
}

- (void)layoutPageSubviews {
    
    [self.photoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).width.insets(UIEdgeInsetsMake(0, 5, 0, 5));
    }];
}

#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.itemNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id imageData = nil;
    if ([self.model.photoArray count] > indexPath.row) {
        imageData = [self.model.photoArray objectAtIndex:indexPath.row];
    }else {
        imageData = self.model.operationImageName;
    }
    LCPhotoInfoCollectionViewCell *cell = [self.photoCollectionView dequeueReusableCellWithReuseIdentifier:@"LCPhotoInfoCollectionViewCell" forIndexPath:indexPath];
    [cell setImageData:imageData placeholderImageName:self.model.placeholderImageName];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectIndex = indexPath.row;
    if (self.model.isOnlyAllowCheck) {
        //只允许查看时 有代理接收返回点击事件 没有查看点击的图片
        if ([self.delegate respondsToSelector:@selector(LCPhotoView:photoContainerView:didSelectAtIndex:)]) {
            [self.delegate LCPhotoView:self photoContainerView:collectionView didSelectAtIndex:indexPath.row];
        }else {
            [self checkPhoto];
        }
        return;
    }
    NSArray *actionTitlesArray = [NSArray array];
    NSArray *actionTitlesTypeArray = [NSArray array];
    if ([self.model.photoArray count] > indexPath.row) {
        //点击位置为拍摄或相册选择的图片
        if (self.model.isAllowReadImageFromLibrary) {
            actionTitlesArray = @[@"重新拍照", @"从手机相册选择", @"查看图片", @"删除"];
            actionTitlesTypeArray = @[@(LCPhotoViewSelectTypeTakePhoto), @(LCPhotoViewSelectTypeReadImageFromLibrary), @(LCPhotoViewSelectTypeCheckPhoto), @(LCPhotoViewSelectTypeDelete)];
        }else {
            actionTitlesArray = @[@"重新拍照", @"查看图片", @"删除"];
            actionTitlesTypeArray = @[@(LCPhotoViewSelectTypeTakePhoto), @(LCPhotoViewSelectTypeCheckPhoto), @(LCPhotoViewSelectTypeDelete)];
        }
    }else {
        //点击位置为拍摄按钮
        if (self.model.isAllowReadImageFromLibrary == YES) {
            actionTitlesArray = @[@"拍照", @"从手机相册选择"];
            actionTitlesTypeArray = @[@(LCPhotoViewSelectTypeTakePhoto), @(LCPhotoViewSelectTypeReadImageFromLibrary)];
        }else{
            //拍照
            [self readImageFromCamera];
            return;
        }
    }
    
    [LCAlertView showAlertViewWithType:UIAlertControllerStyleActionSheet title:@"提示" message:nil actionTitles:actionTitlesArray actionHandler:^(NSUInteger index) {
        
        if ([actionTitlesTypeArray count] <= index) {
            //点击的下标超出事件标题类型数组数量 直接return
            return ;
        }
        LCPhotoViewSelectType type = [[actionTitlesTypeArray objectAtIndex:index] integerValue];
        switch (type) {
            case LCPhotoViewSelectTypeTakePhoto:{
                //拍照
                [self readImageFromCamera];
                break;
            }
            case LCPhotoViewSelectTypeReadImageFromLibrary:{
                //图库选择
                [self readImageFromLibrary];
                break;
            }
            case LCPhotoViewSelectTypeCheckPhoto:{
                //查看大图
                [self checkPhoto];
                break;
            }
            case LCPhotoViewSelectTypeDelete:{
                //删除
                [self deletePhoto];
                break;
            }
            default:{
                break;
            }
        }
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.model.photoItemWidth, self.model.photoItemWidth);
}

//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    //iOS 11打开系统相册列表向上偏移 打开前设置contentInsetAdjustmentBehavior，完成选择后改回
    if (@available(iOS 11, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [kAppDelegate.getCurrentUIVC dismissViewControllerAnimated:YES completion:nil];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // 判断获取类型：图片
    UIImage *image = nil;
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        // 判断，图片是否允许修改
        if ([picker allowsEditing]){
            //获取用户编辑之后的图像
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        }else {
            // 照片的元数据参数
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
    }
    UIImage *compressImage = [UIImage compressImage:image targetWidth:320];
    NSData *imageData = UIImageJPEGRepresentation(compressImage, 0.5);
    //selectIndex从0起 且考虑达到maxShowPhotoCount数量
    if (self.selectIndex < self.model.photoArray.count) {
        [self.model.photoArray replaceObjectAtIndex:self.selectIndex withObject:imageData];
    }else {
        if (self.model.photoArray.count < self.model.maxShowPhotoCount) {
            [self.model.photoArray addObject:imageData];
        }
    }
    [self updatePhotoView];
    [self handleCallback];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    //iOS 11打开系统相册列表向上偏移 打开前设置contentInsetAdjustmentBehavior，完成选择后改回
    if (@available(iOS 11, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [kAppDelegate.getCurrentUIVC dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - event response

/** 拍照 */
- (void)readImageFromCamera {
    
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        [kAppDelegate.getCurrentUIVC presentViewController:imagePicker animated:YES completion:nil];
    } else {
        //弹出窗口响应点击事件
        [LCAlertView showAlertViewWithType:UIAlertControllerStyleAlert title:@"警告" message:@"未检测到摄像头" actionTitles:@[@"确定"] actionHandler:^(NSUInteger index) {
            
        }];
    }
}

/** 相册读取 */
- (void)readImageFromLibrary {
    
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        //iOS 11打开系统相册列表向上偏移 打开前设置contentInsetAdjustmentBehavior，完成选择后改回
        if (@available(iOS 11, *)) {
            UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        }
        [kAppDelegate.getCurrentUIVC presentViewController:imagePicker animated:YES completion:nil];
    } else {
        //弹出窗口响应点击事件
        [LCAlertView showAlertViewWithType:UIAlertControllerStyleAlert title:@"警告" message:@"查看图库权限未开启" actionTitles:@[@"确定"] actionHandler:^(NSUInteger index) {
            
        }];
    }
}

/** 查看图片 */
- (void)checkPhoto {
    
    LCCheckPhotoView *checkPhotoView = [[LCCheckPhotoView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    checkPhotoView.autoresizingMask = (1 << 6) - 1;
    id imageData = [self.model.photoArray objectAtIndex:self.selectIndex];
    [checkPhotoView setImageData:imageData placeholderImageName:self.model.placeholderImageName];
    [kAppDelegate.getCurrentUIVC.navigationController.view addSubview:checkPhotoView];
}

/** 删除图片 */
- (void)deletePhoto {
    
    [self.model.photoArray removeObjectAtIndex:self.selectIndex];
    [self updatePhotoView];
    [self handleCallback];
}

/** 更新页面 */
- (void)updatePhotoView {
    
    //只能查看不需要+1（拍照按钮）
    if (self.model.isOnlyAllowCheck) {
        self.itemNumber = self.model.photoArray.count;
    }else {
        //photoArray的count超出最大显示按最大显示 否则加1显示
        self.itemNumber = (self.model.photoArray.count >= self.model.maxShowPhotoCount) ? self.model.maxShowPhotoCount : self.model.photoArray.count + 1;
    }
    [self.photoCollectionView reloadData];
}

/** 事件回调 */
- (void)handleCallback {
    
    //delegate或者responder Chain
    NSDictionary *userInfo = @{@"photoArray":[self.model.photoArray mutableCopy]};
    [self routerEventWithName:LCPhotoViewDidChangeForData userInfo:userInfo];
    if ([self.delegate respondsToSelector: @selector(LCPhotoView:photosArrayDidChange:)]) {
        [self.delegate LCPhotoView:self photosArrayDidChange:[self.model.photoArray mutableCopy]];
    }
}

#pragma mark - getters and setters

- (UICollectionView *)photoCollectionView {
    
    if (!_photoCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _photoCollectionView.backgroundColor = [UIColor whiteColor];
        _photoCollectionView.scrollEnabled = NO;
        _photoCollectionView.delegate = self;
        _photoCollectionView.dataSource = self;
        _photoCollectionView.showsVerticalScrollIndicator = NO;
        _photoCollectionView.showsHorizontalScrollIndicator = NO;
        //注册 item
        [_photoCollectionView registerClass:[LCPhotoInfoCollectionViewCell class] forCellWithReuseIdentifier:@"LCPhotoInfoCollectionViewCell"];
    }
    return _photoCollectionView;
}

- (void)setModel:(LCPhotoDataModel *)model {
    
    _model = model;
    [self updatePhotoView];
}

@end
