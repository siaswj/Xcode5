//
//  WJCarGroup.m
//  UITableView
//
//  Created by wangjie on 14-10-28.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJCarGroup.h"
#import "WJCar.h"

@implementation WJCarGroup

- (instancetype)initWithDict:(NSDictionary *)dic {
    
    if (self == [super init]) {
        self.title = dic[@"title"];
        
        NSArray *dicArray = dic[@"cars"];
        NSMutableArray *carArray = [NSMutableArray array];
        for (NSDictionary *dic in dicArray) {
            WJCar *car = [WJCar carWithDic:dic];  //单个车的字典转模型
            [carArray addObject:car];
        }
        self.cars = carArray;
    }
    return self;
}

+ (instancetype)groupWithDict:(NSDictionary *)dic {
    return [[self alloc] initWithDict:dic];
}

@end
