//
//  WJContact.m
//  01-私人通讯录
//
//  Created by wangjie on 14-12-18.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJContact.h"

@implementation WJContact
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.phone forKey:@"phone"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
    }
    return self;
}
@end
