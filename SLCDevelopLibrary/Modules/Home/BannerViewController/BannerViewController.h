//
//  BannerViewController.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/26.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BannerViewType) {
    /** 正常 */
    BannerViewTypeNormal,
    /** 向上弧线 */
    BannerViewTypeUpArc,
    /** 向下 */
    BannerViewTypeDownArc,
};

NS_ASSUME_NONNULL_BEGIN

@interface BannerViewController : UIViewController

@property (nonatomic, assign) BannerViewType type;
@end

NS_ASSUME_NONNULL_END
