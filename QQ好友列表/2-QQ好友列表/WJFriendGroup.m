//
//  WJFriendGroup.m
//  2-QQ好友列表
//
//  Created by wangjie on 14-12-1.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJFriendGroup.h"
#import "WJFriend.h"

@implementation WJFriendGroup

+ (instancetype)groupWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        // 1.先使用kvc注入可以注入的数据
        [self setValuesForKeysWithDictionary:dic];
        
        // 2.特殊处理数组数据数据(此时self.friends中注入的都是字典数据)
        NSMutableArray *friendArray = [NSMutableArray array];
        for (NSDictionary *dic in self.friends) {
            WJFriend *friend = [WJFriend friendWithDic:dic];
            [friendArray addObject:friend];
        }
        self.friends = friendArray;
    }
    return self;
}
@end
