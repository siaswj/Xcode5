//
//  WJHtml.h
//  Lottery
//
//  Created by wangjie on 15-2-3.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJHtml : NSObject
/**
 *  网页的标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  网页的文件名
 */
@property (nonatomic, copy) NSString *html;
/**
 *  网页的ID（要跳转的id）
 */
@property (nonatomic, copy) NSString *ID;


- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)htmlWithDic:(NSDictionary *)dic;

@end
