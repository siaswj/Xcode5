//
//  WJFlag.m
//  02pickerView选择国旗
//
//  Created by wangjie on 14-12-7.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJFlag.h"

@implementation WJFlag

+ (instancetype)flagWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
