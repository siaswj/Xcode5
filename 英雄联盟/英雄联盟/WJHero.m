//
//  WJHero.m
//  英雄联盟
//
//  Created by wangjie on 14-10-29.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJHero.h"

@implementation WJHero

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    if (self == [super init]) {
//        self.icon = dic[@"icon"];
//        self.name = dic[@"name"];
//        self.intro = dic[@"intro"];
        [self setValuesForKeysWithDictionary:dic];  // KVC
    }
    return self;
}
+ (instancetype)heroWithDic:(NSDictionary *)dic {
    
    return [[self alloc] initWithDic:dic];
}

@end
