//
//  NSString+WJExtension.h
//  QQ
//
//  Created by wangjie on 14-11-29.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WJExtension)

// 计算一个字体的size
- (CGSize)sizeWithFont:(UIFont *)textFont maxSize:(CGSize)textMaxSize;

@end
