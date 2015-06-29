//
//  UIImage+WJExtension.h
//  QQ
//
//  Created by wangjie on 14-11-29.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 当一个方法可能在整个项目中经常、或多次使用的时候，就把这个方法设置成一个工具方法（封装到一个工具类中），到时候谁需要使用这个方法，谁就包含该工具类的头文件就可以了。分类可以做工具类
 */

@interface UIImage (WJExtension)

+ (UIImage *)resizableImage:(NSString *)name;

@end
