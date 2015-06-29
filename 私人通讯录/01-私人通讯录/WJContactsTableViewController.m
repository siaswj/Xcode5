//
//  WJContactsTableViewController.m
//  01-私人通讯录
//
//  Created by wangjie on 14-12-14.
//  Copyright (c) 2014年 sias. All rights reserved.
//



/**
 * 笔记：NSCoding数据存储
 * [NSKeyedArchiver archiveRootObject:self.contacts toFile:WJContactsFilePath];
 * [NSKeyedUnarchiver unarchiveObjectWithFile:WJContactsFilePath];
 * 这两个方法用于存读遵守<NSCoding>协议的对象
 */





#import "WJContactsTableViewController.h"
#import "WJAddViewController.h"
#import "WJEditViewController.h"
#import "WJContact.h"
#import "WJContactCell.h"

#define WJContactsFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"contacts.data"]

@interface WJContactsTableViewController () <UIActionSheetDelegate, WJAddViewControllerDelegate, WJEditViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *contacts;
- (IBAction)logOut:(id)sender;

@end



@implementation WJContactsTableViewController

// 延时加载
- (NSMutableArray *)contacts
{
    
    if(_contacts == nil) {
        // 1.从本地存储的数据文件中读取数据
        _contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:WJContactsFilePath];
        
        if (_contacts == nil) {   // 文件不存在
            // 2.如果数组为空
            _contacts = [NSMutableArray array];
        }
    }
    return _contacts;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  // cell之间不显示分割线
}



#pragma mark - tableView的代理方法
/**
 *  只要实现了这个方法，就自动实现了滑动删除cell的功能
 *  点击删除按钮就会调用这个方法
 *  提交了一个编辑操作就会调用（操作：删除\添加）
 *  @param editingStyle 编辑的行为
 *  @param indexPath    操作的行号
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {  // 删除操作
        // 1.删除数据
        [self.contacts removeObjectAtIndex:indexPath.row];
        
        // 2.刷新表格
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        
//        [self.tableView reloadData];   性能不是太高
        
//        [self.tableView reloadRowsAtIndexPaths:<#(NSArray *)#> withRowAnimation:<#(UITableViewRowAnimation)#>];  // 局部刷新cell，使用前提：cell的总数不变
        

        // 3.归档
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:WJContactsFilePath];
    }
}



#pragma mark - Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    WJContactCell *cell = [WJContactCell cellWithTableView:tableView];
    
    // 2.设置cell的数据
    cell.contact = self.contacts[indexPath.row];

    return cell;
}



// 点击“注销”后调用这个方法
- (IBAction)logOut:(id)sender {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"确定要注销" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
    
}



#pragma mark - UIActionSheet的代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 如果被点击的按钮索引是 0 ，就删掉当前栈顶的控制器（就会显示登录界面的控制器）
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

// 在界面真正跳转之前，设置“联系人控制器”做“添加联系人控制器”的代理
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    
    if ([vc isKindOfClass:[WJAddViewController class]]) {
        // 取得目标控制器
        WJAddViewController *addVc = vc;
        
        // “联系人控制器”做“添加联系人控制器”的代理
        addVc.delegate = self;
        
    } else if ([vc isKindOfClass:[WJEditViewController class]]){
        WJEditViewController *editVc = vc;
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];  // 获得被选中的行号
        editVc.contact = self.contacts[path.row];
        
        // “联系人控制器”做“查看联系人控制器”的代理
        editVc.delegate = self;
    }
    
}



#pragma mark - WJAddViewControllerDelegate的代理方法
//- (void)addViewController:(WJAddViewController *)addVc didAddWithName:(NSString *)name phone:(NSString *)phone
//{
////    NSLog(@"%@ - %@", name, phone);
//}
- (void)addViewController:(WJAddViewController *)addVc didAddWithContact:(WJContact *)contact
{
//    NSLog(@"%@ - %@ ", contact.name, contact.phone);
    
    // 1.添加模型数据
    [self.contacts addObject:contact];
    
    // 2.刷新表格
    [self.tableView reloadData];
    
    // 3.归档（存储）数组数据
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:WJContactsFilePath];
}



#pragma mark - WJEditViewControllerDelegate的代理方法
- (void)editViewController:(WJEditViewController *)editVc keepNewContact:(WJContact *)contact
{
    // 直接刷新表格就可以，因为被传进来的contact模型就是contacts数组中的哪个对象（就是说两个控制器前后操作的都是同一个模型对象）
    [self.tableView reloadData];
    
    // 2.归档（存储）数组数据
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:WJContactsFilePath];
}

@end
