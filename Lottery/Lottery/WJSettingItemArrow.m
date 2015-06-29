//
//  WJSettingItemArrow.m
//  Lottery
//
//  Created by wangjie on 15-2-1.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJSettingItemArrow.h"

@implementation WJSettingItemArrow

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(__unsafe_unretained Class)destVcClass
{
    // 用self好！！如果是WJSettingItem的子类调用这个方法，那创建的对象的真实类型就是子类的类型
    WJSettingItemArrow *item = [self itemWithIcon:icon title:title];
    item.destVcClass = destVcClass;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass
{
    return [self itemWithIcon:nil title:title destVcClass:destVcClass];
}

@end
