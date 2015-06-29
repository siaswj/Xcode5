//
//  WJCar.m
//  UITableView
//
//  Created by wangjie on 14-10-28.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJCar.h"

@implementation WJCar

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self == [super init]) {
        self.icon = dic[@"icon"];
        self.name = dic[@"name"];
    }
    return self;
}

+ (instancetype)carWithDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

@end
