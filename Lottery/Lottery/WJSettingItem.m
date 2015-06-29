//
//  WJSettingItem.m
//  Lottery
//
//  Created by wangjie on 15-2-1.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJSettingItem.h"

@implementation WJSettingItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    // 用self好！！如果是WJSettingItem的子类调用这个方法，那创建的对象的真实类型就是子类的类型
    WJSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}

@end
