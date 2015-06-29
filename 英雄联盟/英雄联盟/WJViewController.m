//
//  WJViewController.m
//  英雄联盟
//
//  Created by wangjie on 14-10-29.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJViewController.h"
#import "WJHero.h"

@interface WJViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSArray *heros;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 使用代码设置数据源
    self.tableView.dataSource = self;
    
    // 设置cell
    self.tableView.rowHeight = 60;
    
    // 控制器做 UITableViewDelegate 的代理
    self.tableView.delegate = self;
    
}

// 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

//从plist中加载数据(懒加载)
- (NSArray *)heros {
    
    if (_heros == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"heros.plist" ofType:nil];
        
        NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *heroArray = [NSMutableArray array];
        for (NSDictionary *dic in dicArray) {
            WJHero *hero = [WJHero heroWithDic:dic];
            [heroArray addObject:hero];
        }
        
        _heros = heroArray;
    }
    
    return _heros;
}



/******************* 数据源方法 ******************/

// 这个tableView中有几组
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}


// 返回一个cell并展示在界面上。屏幕上每显示一个cell就调用一次这个方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.设置cell的ID
    static NSString *ID = @"hero";  // static:只初始化一次（只分配一块存储空间）
    
    // 2.1.在缓存池中找 ID 类型的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 2.2.缓存池中没有，就创建一个
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 3.设置这个cell的数据（先取出数据模型，再设置）
    WJHero *hero = self.heros[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:hero.icon];
    cell.textLabel.text = hero.name;
    cell.detailTextLabel.text = hero.intro;
    
    // 4.返回这个cell
    return cell;
}

// 一组中有多少cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.heros.count;
}



/********************* UITableView代理方法 **********************/

// 监听cell的被点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 取出对应位置的模型数据
    WJHero *hero = self.heros[indexPath.row];
    
    // 创建一个对话框alert，他的代理是self控制器
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"数据展示" message:@"aaaaa" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    // 设置alert展示的风格
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    // 设置alert的标题
    [alert textFieldAtIndex:0].text = hero.name;
    
    // 把这个alert展示到手机屏幕上
    [alert show];
    
    // 给alert.tag绑定一个值，在这个方法跟下面的方法中间搭一座“桥梁”，便于联系
    alert.tag = indexPath.row;
}



/********************* UIAlertView代理方法 **********************/

// 点击了alertView对话框上的按钮，就会调用这个方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

//    NSLog(@"aaaaaaaa");
    
    if (buttonIndex == 0) return;  // 点击“取消”
    
    // 点击“确定”
    NSString *tempName = [alertView textFieldAtIndex:0].text;
    
    // 修改cell的 模型 数据
    int row = alertView.tag;
    WJHero *hero = self.heros[row];
    hero.name = tempName;
    
    // 局部刷新（只刷新所修改的cell的数据）－－展示到手机界面上
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // 全部刷新数据
    [self.tableView reloadData];
    /** 
     告诉tableView重新加载模型数据
     reloadData : tableView会向数据源重新请求数据
     重新调用数据源的相应方法取得数据
     重新调用数据源的tableView:numberOfRowsInSection:获得行数
     重新调用数据源的tableView:cellForRowAtIndexPath:得知每一行显示怎样的cell
     */
}

// 取消选中的cell
// - (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath

@end
