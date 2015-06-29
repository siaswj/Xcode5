//
//  UIImage+WJExtension.m
//  QQ
//
//  Created by wangjie on 14-11-29.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "UIImage+WJExtension.h"

@implementation UIImage (WJExtension)

// 传入一张需要拉伸的图片名，返回一张拉伸好的新图片
+ (UIImage *)resizableImage:(NSString *)name
{
    // 1.传入的图片对象
    UIImage *normal = [UIImage imageNamed:name];
    
    // 2.只拉伸中间的那一个“点”
    CGFloat h = normal.size.height * 0.5;
    CGFloat w = normal.size.width * 0.5;
    
    // 3.(3)返回一张拉伸好的新图片
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeTile];
    
    
    
    
    // 注释
    // 平铺图片的中心点，目的是不使图片变形；使图片不变形有两种方式：平铺、裁剪。然后常用的方法有3个
    
    /* (1)
     UIImage *newNormal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(WJEdgeOfContent, WJEdgeOfContent, WJEdgeOfContent, WJEdgeOfContent)];
     */
    
    /* (2)
     UIImage *newNormal = [noemal stretchableImageWithLeftCapWidth:<#(NSInteger)#> topCapHeight:<#(NSInteger)#>];
     */

    
}

@end
