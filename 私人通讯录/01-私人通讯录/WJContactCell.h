//
//  WJContactCell.h
//  01-私人通讯录
//
//  Created by wangjie on 14-12-19.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJContact;

@interface WJContactCell : UITableViewCell

@property (nonatomic, strong) WJContact *contact;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
