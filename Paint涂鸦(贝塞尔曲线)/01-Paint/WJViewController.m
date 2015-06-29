//
//  WJViewController.m
//  01-Paint
//
//  Created by wangjie on 15-1-4.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJViewController.h"
#import "WJView.h"
#import "MBProgressHUD+MJ.h"

@interface WJViewController ()
- (IBAction)clear;
- (IBAction)back;
- (IBAction)save;
@property (weak, nonatomic) IBOutlet WJView *paintView;

@end

@implementation WJViewController


- (IBAction)clear {
    [self.paintView clear];
}

- (IBAction)back {
    [self.paintView back];
}

/**
 *  保存图片到相册
 */
- (IBAction)save {

/****************** 前4步可以写成一个截图功能的分类(自己的分类) *******************/
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(self.paintView.frame.size, NO, 0.0);
    
    // 2.将控制器view的layer渲染到上下文
    [self.paintView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 3.取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.结束上下文
    UIGraphicsEndImageContext();
    

    
    // 5.保存图片到相册
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

/**
 *  系统推荐定义的方法名
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [MBProgressHUD showError:@"保存失败"];
    } else {
        [MBProgressHUD showSuccess:@"保存成功"];
    }
    
}

@end
