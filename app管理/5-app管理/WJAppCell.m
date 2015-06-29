//
//  WJAppCell.m
//  5-app管理
//
//  Created by wangjie on 14-12-3.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJAppCell.h"
#import "WJApp.h"

@interface WJAppCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *introView;

- (IBAction)download;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;

@end

@implementation WJAppCell

- (void)setApp:(WJApp *)app
{
    
    _app = app;
    
    
    // 下面这样用的是cell内部自带的image、label，可以，但是有局限性，要想添加除此之外的如button的控件的时候，cell只能使用custom模式，但是这样系统自带的就相当于没用；而要使用系统自带的模式，则不能添加额外的控件
//    self.imageView.image = [UIImage imageNamed:app.icon];
//    self.textLabel.text = app.name;
//    self.detailTextLabel.text = [NSString stringWithFormat:@"大小：%@ | 下载量：%@", app.size,app.download];
    
    // 所以要使用自定义的模式（需要添加额外的控件）时，就只能用custom模式，所以就要拿到自定义在cell中的控件
    self.iconView.image = [UIImage imageNamed:app.icon];
    self.nameView.text = app.name;
    self.introView.text = [NSString stringWithFormat:@"大小:%@ | 下载量:%@", app.size, app.download];
    
    
    // 覆盖按钮的状态(注意：这里是一个坑！！！！！！！)
    self.downloadBtn.enabled = (self.app.isDownloaded == NO);
    
}

// 下载按钮被点击就调用这个方法。这里使用<代理设计模式>
- (IBAction)download
{
    
    // 1.按钮被点击后，改变按钮的状态
    self.app.downloaded = YES;   // downloaded的set方法－－按钮被点击了
#warning 两种方法：1.拖线拿到按钮来设置状态，2.跟着cell一块传递一个按钮参数。两种方法都试试。。。。。
    self.downloadBtn.enabled = NO;
    
    // 2.通知代理cell上的按钮被点击了
    if ([self.delegate respondsToSelector:@selector(appCellDidClickedDownloadBtn:)]) {
        [self.delegate appCellDidClickedDownloadBtn:self];
    }
}
@end
