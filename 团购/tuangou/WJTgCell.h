//
//  WJTgCell.h
//  tuangou
//
//  Created by wangjie on 14-10-30.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJTg;   // 这里只是声明WJTg是一个类，并没有说tg中有什么成员变量，所以不能对tg中的成员变量进行访问

@interface WJTgCell : UITableViewCell

@property (nonatomic, strong) WJTg *tg;  // View(cell)对外的（唯一）接口属性，用于和模型数据对象 建立联系，方便展示数据

+ (instancetype)cellWithTableView:(UITableView *)tableView;  // 上面的属性 对应的接口方法

@end
