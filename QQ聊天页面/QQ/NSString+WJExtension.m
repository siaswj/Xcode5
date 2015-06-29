//
//  NSString+WJExtension.m
//  QQ
//
//  Created by wangjie on 14-11-29.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "NSString+WJExtension.h"

@implementation NSString (WJExtension)

- (CGSize)sizeWithFont:(UIFont *)textFont maxSize:(CGSize)textMaxSize
{
    NSDictionary *attr = @{NSFontAttributeName : textFont};
    
    return [self boundingRectWithSize:textMaxSize
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:attr
                              context:nil].size;
}

@end
