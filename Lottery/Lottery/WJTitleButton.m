//
//  WJTitleButton.m
//  Lottery
//
//  Created by wangjie on 15-1-31.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJTitleButton.h"

@interface WJTitleButton ()
/**
 *  这是一个桥梁，联系initWithCoder\awakeFromNib和titleRectForContentRect，目的是为了在titleRectForContentRect中拿到在initWithCoder\awakeFromNib中设置的按钮的文字的大小
 *  下面这种情况：awakeFromNib和initWithCoder的作用效果一样.
 */
@property (nonatomic, strong) UIFont *titleFont;
@end


@implementation WJTitleButton

/**
 *  当一个对象从xib或storyboard中创建完毕后，就会调用这个方法
 */
//- (void)awakeFromNib
//{
//    // self.titleFont只是一个桥梁
//    self.titleFont = [UIFont systemFontOfSize:16];
//    // 这里才是设置按钮上文字的大小是14
//    self.titleLabel.font = self.titleFont;
//    
//    self.imageView.contentMode = UIViewContentModeCenter;
//}


/**** 不管view是通过代码创建的还是通过文件创建的，这三个方法都可以满足。标配 *****/
/**
 *  只要解析文件，就会调用这个方法
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}
/**
 *  通过代码创建，就会调用这个方法
 */
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    // self.titleFont只是一个桥梁
    self.titleFont = [UIFont systemFontOfSize:16];
    // 这里才是设置按钮上文字的大小是14
    self.titleLabel.font = self.titleFont;
    
    self.imageView.contentMode = UIViewContentModeCenter;
}
/**** 不管view是通过代码创建的还是通过文件创建的，这三个方法都可以满足。标配 *****/




/**
 *  需要自己调用这个方法，返回按钮内部title的frame
 *  @param contentRect 按钮的rect
 *  @return 返回文字的frame
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleH = contentRect.size.height;
    
    NSDictionary *attr = @{NSFontAttributeName : self.titleFont};
    // 拿到按钮文字的大小来计算文字的rect
    CGFloat titleW = [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:attr
                                                     context:nil].size.width;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

/**
 *  需要自己调用这个方法，返回按钮内部imageView的frame
 *  @param contentRect 按钮的rect
 *  @return 返回imageView的rect
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageW = 20;
    CGFloat imageX = contentRect.size.width - imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end
