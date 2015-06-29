//
//  WJAddViewController.m
//  01-私人通讯录
//
//  Created by wangjie on 14-12-18.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJAddViewController.h"
#import "WJContact.h"

@interface WJAddViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;    // 姓名
@property (weak, nonatomic) IBOutlet UITextField *phoneField;    // 电话
@property (weak, nonatomic) IBOutlet UIButton *addBtn;    // 添加按钮
- (IBAction)add;

@end

@implementation WJAddViewController

// 当控制器的view加载完毕后，就会调用这个方法
- (void)viewDidAppear:(BOOL)animated
{
    [self.nameField becomeFirstResponder];  // 姓名文本框叫出键盘（成为第一响应者）
//    [self.nameField endEditing:YES];        // 退出键盘，停止编辑
//    [self.nameField resignFirstResponder];  // 姓名文本框不当第一响应者
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.phoneField];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textChanged
{
    self.addBtn.enabled = self.nameField.text.length && self.phoneField.text.length;
}


// 点击“添加”按钮(要做两件事：1.关闭添加控制器； 2.给上一个控制器传递数据)
- (IBAction)add {
    
    // 1.关闭“添加”控制器
    [self.navigationController popViewControllerAnimated:YES];
    
    // 2.给上一个控制器传递数据（通过代理，代理也可以传递数据，解耦）
    // 通知代理(即联系人控制器)"添加"按钮被点击了，顺便把要添加的数据传出去给代理(name,phone -> 联系人控制器)，让代理去实现这个方法，继而拥有数据
//    if ([self.delegate respondsToSelector:@selector(addViewController:didAddWithName:phone:)]) {
//        [self.delegate addViewController:self didAddWithName:self.nameField.text phone:self.phoneField.text];
//    }
    if ([self.delegate respondsToSelector:@selector(addViewController:didAddWithContact:)]) {
        WJContact *contact = [[WJContact alloc] init];
        contact.name = self.nameField.text;  // 注：没有考虑封装模型
        contact.phone = self.phoneField.text;
        
        [self.delegate addViewController:self didAddWithContact:contact];
    }
    
}
@end
