//
//  WJTg.m
//  tuangou
//
//  Created by wangjie on 14-10-30.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJTg.h"

@implementation WJTg

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)tgWithDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

@end
