//
//  WJTgFooterView.m
//  tuangou
//
//  Created by wangjie on 14-11-3.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJTgFooterView.h"

@interface WJTgFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *loadBtn;
@property (weak, nonatomic) IBOutlet UIView *loadDidView;

- (IBAction)loadBtnClicked;

@end

@implementation WJTgFooterView

+ (instancetype)footerView {
    
    // 初始化、加载Xib
    return [[[NSBundle mainBundle] loadNibNamed:@"WJTgFooterView" owner:nil options:nil] lastObject];
}

- (IBAction)loadBtnClicked {
    
    self.loadBtn.hidden = YES;
    self.loadDidView.hidden = NO;
    
    // GCD；0.5s后执行block内的代码
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 1.先判断代理有没有该方法
        if ([self.delegate respondsToSelector:@selector(tgFooterViewDidClickLoadBtn:)]) {
            [self.delegate tgFooterViewDidClickLoadBtn:self];
        }
        
        // 2.
        self.loadBtn.hidden = NO;
        self.loadDidView.hidden = YES;
        
    });
}
@end
