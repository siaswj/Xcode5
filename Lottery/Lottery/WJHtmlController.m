//
//  WJHtmlController.m
//  Lottery
//
//  Created by wangjie on 15-2-3.
//  Copyright (c) 2015年 sias. All rights reserved.
//  这个界面加载的都是html网页

#import "WJHtmlController.h"
#import "WJHtml.h"

@interface WJHtmlController () <UIWebViewDelegate>

@end



@implementation WJHtmlController

/**
 *  在创建控制器view的时候，把普通的view换成UIWebView
 */
- (void)loadView
{
    self.view = [[UIWebView alloc] init];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIWebView *webView = (UIWebView *)self.view;    // ????
    webView.delegate = self;
    
    self.title = self.html.title;
    
    // 加载一个网页请求
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.html.html withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    
    // 栈顶控制器决定自己的导航条上的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UIWebView的代理方法
/**
 *  网页加载完毕后调用这个方法
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *jsCode = [NSString stringWithFormat:@"window.location.href = '#%@';", self.html.ID];
    [webView stringByEvaluatingJavaScriptFromString:jsCode];
}

@end
