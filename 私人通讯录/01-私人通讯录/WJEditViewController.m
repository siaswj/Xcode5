//
//  WJEditViewController.m
//  01-私人通讯录
//
//  Created by wangjie on 14-12-19.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJEditViewController.h"
#import "WJContact.h"

@interface WJEditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *keepBtn;
- (IBAction)keep;
- (IBAction)edit:(UIBarButtonItem *)sender;

@end

@implementation WJEditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置数据
    self.nameField.text = self.contact.name;
    self.phoneField.text = self.contact.phone;
    
    
    // 拿到通知中心，这个 控制器 监听到 self.accountTextField 的UITextFieldTextDidChangeNotification 通知时，调用 textChanged 方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.phoneField];
    
}

// 通知中心有add就要有remove
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 如果两个文本框的文字都有了的话，就改变登录按钮的属性
- (void)textChanged
{
    self.keepBtn.enabled = self.nameField.text.length && self.phoneField.text.length;
}


// 在“联系人控制器”的“prepareForSegue: sender:”调用时，目标控制器的view还没有创建，所以重写setContact方法没有效果，可以在viewDidLoad方法中设置数据
//- (void)setContact:(WJContact *)contact
//{
//    _contact = contact;
//    
//    self.nameField.text = contact.name;
//    self.phoneField.text = contact.phone;
//}


// 点击“保存”按钮
- (IBAction)keep {
    
    // 1.关闭当前的控制器界面
    [self.navigationController popViewControllerAnimated:YES];
    
    // 2.通知代理
    if ([self.delegate respondsToSelector:@selector(editViewController:keepNewContact:)]) {
        // 2.1.刷新数据
        self.contact.name = self.nameField.text;
        self.contact.phone = self.phoneField.text;
        
        // 2.2.通知代理
        [self.delegate editViewController:self keepNewContact:self.contact];
    }
    
}

// 点击“编辑”按钮
- (IBAction)edit:(UIBarButtonItem *)sender {
    
    if (self.keepBtn.hidden) {  // 隐藏
        self.nameField.enabled = YES;
        self.phoneField.enabled = YES;
        self.keepBtn.hidden = NO;
        [self.phoneField becomeFirstResponder];
        sender.title = @"取消";
    } else {
        self.nameField.enabled = NO;
        self.phoneField.enabled = NO;
        self.keepBtn.hidden = YES;
//        [self.phoneField resignFirstResponder];
        [self.view endEditing:YES];
        sender.title = @"编辑";
        self.nameField.text = self.contact.name;
        self.phoneField.text = self.contact.phone;
    }
    
}

@end
