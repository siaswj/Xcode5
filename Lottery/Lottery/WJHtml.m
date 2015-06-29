//
//  WJHtml.m
//  Lottery
//
//  Created by wangjie on 15-2-3.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJHtml.h"

@implementation WJHtml

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.title = dic[@"title"];
        self.html = dic[@"html"];
        self.ID = dic[@"id"];
    }
    return self;
}

+ (instancetype)htmlWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

@end
