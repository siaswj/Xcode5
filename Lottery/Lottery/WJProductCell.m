//
//  WJProductCell.m
//  Lottery
//
//  Created by wangjie on 15-2-2.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJProductCell.h"
#import "WJProduct.h"

@interface WJProductCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;

@end



@implementation WJProductCell

/**
 *  从xib中加载完毕后，设置图标的四角为圆角
 */
- (void)awakeFromNib
{
    // 设置图标为圆角
    self.iconView.layer.cornerRadius = 8;
    self.iconView.clipsToBounds = YES;
}

- (void)setProduct:(WJProduct *)product
{
    _product = product;
    
    // self.iconView.image = [UIImage imageNamed:product.icon];   // @2x捣的鬼？？
    self.iconView.image = [UIImage imageNamed:@"open"];     // 先用一张代替一下
    self.titleView.text = product.title;
}


@end
