//
//  WJHelpViewController.m
//  Lottery
//
//  Created by wangjie on 15-2-3.
//  Copyright (c) 2015年 sias. All rights reserved.
//  help界面

#import "WJHelpViewController.h"
#import "WJSettingGroup.h"
#import "WJSettingItemArrow.h"
#import "WJHtmlController.h"
#import "WJNavigationController.h"
#import "WJHtml.h"

@interface WJHelpViewController ()
@property (nonatomic, strong) NSArray *htmls;
@end


@implementation WJHelpViewController

- (NSArray *)htmls
{
    if (_htmls == nil) {
        
        // 加载help.json文件中的数据（一个字典数组）
        NSString *path = [[NSBundle mainBundle] pathForResource:@"help.json" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSArray *dicArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        // 字典转模型
        NSMutableArray *htmlArray = [NSMutableArray array];
        for (NSDictionary *dic in dicArray) {
            WJHtml *html = [WJHtml htmlWithDic:dic];
            [htmlArray addObject:html];
        }
        
        // 把模型数组赋值给控制器的成员变量
        _htmls = htmlArray;
    }
    
    return _htmls;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加数据
    NSMutableArray *itemCellArray = [NSMutableArray array];
    for (WJHtml *html in self.htmls) {
        WJSettingItem *itemCell = [WJSettingItemArrow itemWithTitle:html.title destVcClass:nil];
        [itemCellArray addObject:itemCell];
    }
    
    WJSettingGroup *group = [[WJSettingGroup alloc] init];
    group.items = itemCellArray;
    
    [self.data addObject:group];
    
}



/**
 *  子类WJHelpViewController 重写 父类WJSettingBasedViewController 的这个方法，覆盖父类的切换方式（父类用push，子类改用modal）
 *  点击帮助页面上的cell，调用这个方法
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJHtmlController *htmlVc = [[WJHtmlController alloc] init];
    
    htmlVc.html = self.htmls[indexPath.row];
    
    WJNavigationController *navHtml = [[WJNavigationController alloc] initWithRootViewController:htmlVc];           // 给html控制器包装一个导航栏
    
    
    [self presentViewController:navHtml animated:YES completion:nil];
}

@end
