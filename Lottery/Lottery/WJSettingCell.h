//
//  WJSettingCell.h
//  Lottery
//
//  Created by wangjie on 15-2-1.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJSettingItem;

@interface WJSettingCell : UITableViewCell
/**
 *  提供一个item数据模型
 */
@property (nonatomic, strong) WJSettingItem *item;

/**
 *  创建一个cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
