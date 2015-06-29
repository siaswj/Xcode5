//
//  WJTgHeaderView.m
//  tuangou
//
//  Created by wangjie on 14-11-5.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJTgHeaderView.h"

@interface WJTgHeaderView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation WJTgHeaderView

+ (instancetype)headerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"WJTgHeaderView" owner:nil options:nil] lastObject];
}

// 当一个对象从xib中创建初始化完毕的时候就会调用一次
- (void)awakeFromNib {
    
    int imageNumber = 5;
    CGFloat imageW = self.scrollView.frame.size.width;
    CGFloat imageH = self.scrollView.frame.size.height;
    CGFloat imageY = 0;
    
    self.scrollView.contentSize = CGSizeMake(imageW * imageNumber, 0);
    
    for (int i=0; i<imageNumber; i++) {
        
        UIImageView *ad = [[UIImageView alloc] init];
        NSString *adName = [NSString stringWithFormat:@"ad_0%d", i];
        ad.image = [UIImage imageNamed:adName];

        CGFloat imageX = i * imageW;
        ad.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
        [self.scrollView addSubview:ad];
        
        self.scrollView.pagingEnabled = YES;
        
    }
    
}

@end
