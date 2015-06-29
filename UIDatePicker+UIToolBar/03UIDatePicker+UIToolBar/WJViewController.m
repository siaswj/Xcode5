//
//  WJViewController.m
//  03UIDatePicker+UIToolBar
//
//  Created by wangjie on 14-12-8.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJViewController.h"

@interface WJViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputField;

@end

@implementation WJViewController

// 只需设置一次，所以在这个方法中设置
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
/***************************** UIDatePicker *********************************/
    // 自定义文本输入框的键盘（点击输入框弹出什么样的键盘,这是文本输入框的一个属性）
    // 创建一个datePicker
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    
    // datePicker的模式
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    // datePicker的语言本地化
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    // 点击文本框后要弹出的键盘：datePicker
    self.inputField.inputView = datePicker;
    
    
    
    
/***************************** UIToolBar ***********************************/
    // 自定义文本框键盘 上面显示的工具控件
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    
    // toolBar工具条的颜色
//    toolBar.backgroundColor = [UIColor redColor];
    toolBar.barTintColor = [UIColor grayColor];
//    toolBar.tintColor = [UIColor greenColor];
    
    // toolBar的frame
    toolBar.frame = CGRectMake(0, 0, 320, 44);
    
    
    // toolBar上面的子控件必须是item，并且以一个数组(items)来存放所有的子控件
    // (1)自定义的item0-－－－“上一个”
    UIBarButtonItem *item0 = [[UIBarButtonItem alloc] initWithTitle:@"上一个" style:UIBarButtonItemStylePlain target:self action:@selector(lastOne)];
    item0.enabled = NO;    //item有这个属性
    // (2)自定义的item1-－－－“下一个”
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"下一个" style:UIBarButtonItemStylePlain target:self action:@selector(nextOne)];
    // (3)系统自带的item2-－－－－“照相机”
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:nil action:nil];
    // (4)添加系统自带的可伸缩的弹簧控件（该控件是透明的，所以用来做分割控件）
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    // (5)自定义的item4-－－－“完成”
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    // 把所有的item添加到items数组中（items : 数组，在工具条上从左到右依次存放数组内的item）
    toolBar.items = @[item0, item1, item2, item3, item4];
    
    
    // 设置toolBar为键盘的辅助视图（accessory : 辅助）
    self.inputField.inputAccessoryView = toolBar;
    
}

- (void)lastOne
{
    NSLog(@"上一个");
}

- (void)nextOne
{
    NSLog(@"下一个");
}

- (void)done
{
    NSLog(@"完成");
    [self.view endEditing:YES];
}

@end
