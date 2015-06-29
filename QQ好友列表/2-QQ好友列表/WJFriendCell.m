//
//  WJFriendCell.m
//  2-QQ好友列表
//
//  Created by wangjie on 14-12-3.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJFriendCell.h"
#import "WJFriend.h"

@implementation WJFriendCell

// 创建一个cell（此时cell仍无数据）
+ (instancetype)cellWithtableView:(UITableView *)tableView
{
    static NSString *ID = @"friend";
    
    WJFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WJFriendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

// 重写setFriendData:方法，利用对外提供的friendData属性给cell传递数据（传递模型）
- (void)setFriendData:(WJFriend *)friendData
{
    _friendData = friendData;
    
    // 设置cell的图片、主标题、子标题
    self.imageView.image = [UIImage imageNamed:friendData.icon];
    self.textLabel.text = friendData.name;
    self.detailTextLabel.text = friendData.intro;
    
    // 区分该模型对象是否是会员（会员用红色，非会员用黑色）
    // vip的get方法isVip
    self.textLabel.textColor = friendData.isVip ? [UIColor redColor] : [UIColor blackColor];
}

@end
