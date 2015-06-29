//
//  WJViewController.m
//  5-app管理
//
//  Created by wangjie on 14-12-3.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJViewController.h"
#import "WJApp.h"
#import "WJAppCell.h"

@interface WJViewController () <WJAppCellDelegate>

@property (nonatomic, strong) NSArray *apps;

@end

@implementation WJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (NSArray *)apps
{
    if (_apps == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"apps_full.plist" ofType:nil];
        NSDictionary *dicArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *appArray = [NSMutableArray array];
        for (NSDictionary *dic in dicArray) {
            WJApp *app = [WJApp appWithDic:dic];
            [appArray addObject:app];
        }
        _apps = appArray;
        
    }
    return _apps;
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.apps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 1.从storyboard中创建cell
//    NSString *ID = (indexPath.row%2) ? @"app" : @"app2";  为什么这样不能用static？？
    static NSString *ID = @"app";
    WJAppCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 2.给创建好的cell赋值（传递模型数据）
    cell.app = self.apps[indexPath.row];
    
    // 3.设置cell的代理为控制器
    cell.delegate = self;
    
    // 4.返回这个cell
    return cell;
}

#pragma mark - APPCell的代理方法
// 在这个方法里设置按钮被点击后需要做的事情
- (void)appCellDidClickedDownloadBtn:(WJAppCell *)cell
{
    // 0.取出传进来的cell中的app模型数据
    WJApp *app = cell.app;
    
    // 1.设置要显示的label的一些属性
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"已成功下载%@", app.name];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];
    label.frame = CGRectMake(0, 0, 150, 25);
    label.center = CGPointMake(160, 240);
    label.clipsToBounds = YES;     // 超过边界的是否进行切边
    label.layer.cornerRadius = 5;     // label四周的圆角程度
    label.alpha = 0.0;    // 透明度0.0
#warning 弹出的label跟着tableView一块滚动，我觉得应该是下面这句代码的问题......
    // 把弹出的lable添加到window上就可以了（2015-1-24解决）
    [self.view.window addSubview:label];
    
    // 2.执行动画
    [UIView animateWithDuration:0.5 animations:^{
        label.alpha = 0.5;    // 透明度0.5
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:2.0 options:UIViewAnimationOptionCurveLinear animations:^{
            label.alpha = 0.0;     // 透明度0.0
        } completion:^(BOOL finished) {
            [label removeFromSuperview];   // 移除label控件
        }];
    }];
    
}

@end
