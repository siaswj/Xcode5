//
//  WJVideo.m
//  黑酷
//
//  Created by wangjie on 15-3-2.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJVideo.h"

@implementation WJVideo

+ (instancetype)videoWithDic:(NSDictionary *)dic
{
    WJVideo *video = [[self alloc] init];
    [video setValuesForKeysWithDictionary:dic];
    return video;
}

@end
