//
//  WJApp.m
//  5-app管理
//
//  Created by wangjie on 14-12-3.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJApp.h"

@implementation WJApp

+ (instancetype)appWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];  //kvc
    }
    return self;
}

@end
