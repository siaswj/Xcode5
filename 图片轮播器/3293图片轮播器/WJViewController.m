//
//  WJViewController.m
//  3293图片轮播器
//
//  Created by wangjie on 14-10-23.
//  Copyright (c) 2014年 sias. All rights reserved.
//


/** 
 1.有一些小细节需要注意：详细看视频
 2.scrollView的基本使用
 3.scrollView的代理(的方法)的基本使用
 */

#import "WJViewController.h"


@interface WJViewController () <UIScrollViewDelegate>   // 设置控制器遵守UIScrollView的协议，因为控制器想要做UIScrollView的代理
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;    // 一个scrollView
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;   // 分页
@property (nonatomic, strong) NSTimer *timer;    // 定时器
@end


@implementation WJViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    
    int imageNumbers = 5;   // 图片总个数
    CGFloat imageW = self.scrollView.frame.size.width;
    CGFloat imageH = self.scrollView.frame.size.height;
    CGFloat imageY = 0;
    
    // 设置contentSize
    self.scrollView.contentSize = CGSizeMake(imageNumbers * imageW, 0); //这里填0,130都可以？
    
    //
    for (int i=0; i<imageNumbers; i++) {
        UIImageView *image = [[UIImageView alloc] init];
        
        NSString *imageName = [NSString stringWithFormat:@"img_0%d", i+1];
        image.image = [UIImage imageNamed:imageName];
        

        CGFloat imageX =i * imageW;
        
        // 设置image的frame
        image.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
        // 把image添加到scrollView上
        [self.scrollView addSubview:image];
    }
    
    // 隐藏scrollView的水平滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    // 设置scrollView可以分页
    self.scrollView.pagingEnabled = YES;
    
    // 设置分页后的总页数
    self.pageControl.numberOfPages = imageNumbers;
    
    // 添加定时器
    [self addTimer];
}

- (void)addTimer {
    
    // 两秒后给控制器传一个方法，并且重复做这个操作
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    // 使控制器可以“同时”处理多个事件(牵扯到多线程问题)
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)nextPage {
    
//    if (self.pageControl.currentPage == 4) {
//        self.pageControl.currentPage = 0;
//    } else {
//        self.pageControl.currentPage++;
//    }
    /** 
     这种方法有点小问题：使小红点在两个页面上来回跳转，原因是这里是 断点式 的是小红点在俩个页面中跳转，而调用scrollViewDidScroll:方法的时
     候，是动画式的让小红点在两个页面中跳转，这样就会导致当前页面current先变为 1(断点式) 再变为 0...0 再变为 1(动画式)，所以采用下面的这种
     方式
     */
    
    int page = 0;   // 判断的对象是currentPage
    if (self.pageControl.currentPage == 4) {
        page = 0;
    } else {
        page = self.pageControl.currentPage + 1;
    }
    
    CGFloat offsetX = page * self.scrollView.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.scrollView setContentOffset:offset animated:YES];
    
}

#pragma mark - 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    self.pageControl.currentPage = page;
//    NSLog(@"正在滚动");
}

@end
