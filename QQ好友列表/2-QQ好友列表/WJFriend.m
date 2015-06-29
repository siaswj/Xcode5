//
//  WJFriend.m
//  2-QQ好友列表
//
//  Created by wangjie on 14-12-1.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJFriend.h"

@implementation WJFriend

+ (instancetype)friendWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dic];  // 可以直接使用kvc
    }
    return self;
}
@end
