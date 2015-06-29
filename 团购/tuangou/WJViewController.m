//
//  WJViewController.m
//  tuangou
//
//  Created by wangjie on 14-10-30.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJViewController.h"
#import "WJTg.h"
#import "WJTgCell.h"
#import "WJTgFooterView.h"
#import "WJTgHeaderView.h"

@interface WJViewController () <UITableViewDataSource, WJTgFooterViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *tgs;  // 控制器拿到plist中的数据(模型对象式的数据)
@end


@implementation WJViewController

// Do any additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.rowHeight = 80;
    
    // tableView的footerView
    WJTgFooterView *footerView = [WJTgFooterView footerView];
    footerView.delegate = self;
    self.tableView.tableFooterView = footerView;
    
    WJTgHeaderView *headerView = [WJTgHeaderView headerView];
    self.tableView.tableHeaderView = headerView;
    
}

- (void)tgFooterViewDidClickLoadBtn:(WJTgFooterView *)tgFooterView {
    WJTg *tg = [[WJTg alloc] init];
    tg.icon = @"ad_01";
    tg.price = @"100";
    tg.buyCount = @"100";
    tg.title = @"超级小炒饭";
    
    [self.tgs addObject:tg];
    
    [self.tableView reloadData];
    
    
}

// 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

// 懒加载_tgs属性－－>让控制器拥有这些数据（plist中的数据）
- (NSArray *)tgs {
    
    if (_tgs == nil) {
        
        // 从plist文件中加载数据－－>字典数组
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tgs.plist" ofType:nil];
        NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
        
        // 字典数据转模型数据
        NSMutableArray *tgArray = [NSMutableArray array];
        for (NSDictionary *dic in dicArray) {
            WJTg *tg = [WJTg tgWithDic:dic];  // 字典转模型过程封装到模型类中，模型类只提供一个接口
            [tgArray addObject:tg];
        }
        
        // 模型数据数组交给控制器的_tgs，让控制器拥有这些数据
        _tgs = tgArray;
    }
    
    return _tgs;
}


/** 这部分是数据源方法－－数据源方法必须有－－－> 因为控制器是数据源 */
// 一组中有多少cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tgs.count;
}

// 这个方法：把一个模型对象的数据交给一个cell，并返回展示到界面上－－－(C 控制数据 从M到V)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.创建一个cell（现在cell还没有数据）
    WJTgCell *cell = [WJTgCell cellWithTableView:tableView];  // 一个自己定义的cell：WJTgCell类型

    // 2.把模型对象的数据交给这个cell
    cell.tg = self.tgs[indexPath.row];  // 使用到了cell.tg的set方法，所以需要重写该set方法(加载数据：模型对象的数据加载到cell的tg属性中 显示到屏幕上)
    
    // 3.返回这个cell到屏幕上（此时的cell是带有真实数据的cell）
    return cell;
}
@end
