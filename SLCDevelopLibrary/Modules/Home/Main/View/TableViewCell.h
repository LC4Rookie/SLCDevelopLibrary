//
//  TableViewCell.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/26.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *title;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
