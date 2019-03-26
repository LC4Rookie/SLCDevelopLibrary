//
//  LCSegementCollectionViewCell.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/25.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCSegementCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *selectColor;
@property (nonatomic, assign) BOOL isSelected;
@end

NS_ASSUME_NONNULL_END
