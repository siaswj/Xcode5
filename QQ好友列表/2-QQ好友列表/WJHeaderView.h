//
//  WJHeaderView.h
//  2-QQ好友列表
//
//  Created by wangjie on 14-12-3.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJFriendGroup, WJHeaderView;

@protocol WJHeaderViewDelegate <NSObject>
@optional
- (void)headerViewDidClickedNameView:(WJHeaderView *)headerView;
@end

@interface WJHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) WJFriendGroup *group;  // 给headerView设置数据时，对外提供的接口
@property (nonatomic, weak) id<WJHeaderViewDelegate> delegate;  // headerView的协议

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
