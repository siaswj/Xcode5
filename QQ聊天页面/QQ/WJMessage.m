//
//  WJMessage.m
//  QQ
//
//  Created by wangjie on 14-11-12.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJMessage.h"

@implementation WJMessage

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)messageWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

@end
