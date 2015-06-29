//
//  WJFriendCell.h
//  2-QQ好友列表
//
//  Created by wangjie on 14-12-3.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJFriend;

@interface WJFriendCell : UITableViewCell

@property (nonatomic, strong) WJFriend *friendData;

+ (instancetype)cellWithtableView:(UITableView *)tableView;

@end
