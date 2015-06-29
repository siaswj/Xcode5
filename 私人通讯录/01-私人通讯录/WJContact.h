//
//  WJContact.h
//  01-私人通讯录
//
//  Created by wangjie on 14-12-18.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJContact : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;

@end
