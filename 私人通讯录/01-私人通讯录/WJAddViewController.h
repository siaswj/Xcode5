//
//  WJAddViewController.h
//  01-私人通讯录
//
//  Created by wangjie on 14-12-18.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJAddViewController, WJContact;

@protocol WJAddViewControllerDelegate <NSObject>

@optional
//- (void)addViewController:(WJAddViewController *)addVc didAddWithName:(NSString *)name phone:(NSString *)phone;
- (void)addViewController:(WJAddViewController *)addVc didAddWithContact:(WJContact *)contact;
@end


@interface WJAddViewController : UIViewController

@property (nonatomic, weak) id<WJAddViewControllerDelegate> delegate;

@end
