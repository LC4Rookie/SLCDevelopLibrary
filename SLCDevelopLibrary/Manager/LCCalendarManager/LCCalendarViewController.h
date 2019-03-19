//
//  LCCalendarViewController.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/19.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LCCalendarViewControllerDelegate <NSObject>

@optional
- (void)LCCalendarViewControllerDelegateDidSelectDate:(NSDate *)date;

@end

@interface LCCalendarViewController : UIViewController

@property (nonatomic, weak) id<LCCalendarViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
