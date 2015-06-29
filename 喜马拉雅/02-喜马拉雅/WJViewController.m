//
//  WJViewController.m
//  02-喜马拉雅
//
//  Created by wangjie on 14-10-22.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJViewController.h"

@interface WJViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *longButton;  // 长条按钮

@end

@implementation WJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 设置scrollView的内容的size(所能滚动的范围)
    CGFloat contentH = CGRectGetMaxY(self.longButton.frame);
    self.scrollView.contentSize = CGSizeMake(320, contentH);
    
    // 设置scrollView四周所增加的额外范围
    self.scrollView.contentInset = UIEdgeInsetsMake(74, 0, 60, 0);
    
    // 设置scrollView的位置(按左上角的位置算)
    self.scrollView.contentOffset = CGPointMake(0, -74);
}

@end
