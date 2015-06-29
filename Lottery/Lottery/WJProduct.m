//
//  WJProduct.m
//  Lottery
//
//  Created by wangjie on 15-2-2.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJProduct.h"

@implementation WJProduct

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        // [self setValuesForKeysWithDictionary:dic];
        self.title = dic[@"title"];
        self.icon = dic[@"icon"];
    }
    return self;
}

+ (instancetype)productWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

@end
