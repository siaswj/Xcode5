//
//  WJLoginViewController.m
//  Lottery
//
//  Created by wangjie on 15-1-31.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJLoginViewController.h"
#import "WJSettingViewController.h"

@interface WJLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)clickSettingBtn:(id)sender;

@end

@implementation WJLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *normal = [UIImage imageNamed:@"RedButton"];
    UIImage *high = [UIImage imageNamed:@"RedButtonPressed"];
    
    // 拉伸图片有三种方法
    normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.5];
    high = [high stretchableImageWithLeftCapWidth:high.size.width * 0.5 topCapHeight:high.size.height * 0.5];
    
    [self.loginBtn setBackgroundImage:normal forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:high forState:UIControlStateHighlighted];
    
}


/**
 *  点击设置按钮跳到设置控制器
 */
- (IBAction)clickSettingBtn:(id)sender
{
    WJSettingViewController *settingVc = [[WJSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVc animated:YES];
}
@end
