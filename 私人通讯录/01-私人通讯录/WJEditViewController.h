//
//  WJEditViewController.h
//  01-私人通讯录
//
//  Created by wangjie on 14-12-19.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJContact, WJEditViewController;

@protocol WJEditViewControllerDelegate <NSObject>

@optional
- (void)editViewController:(WJEditViewController *)editVc keepNewContact:(WJContact *)contact;

@end

@interface WJEditViewController : UIViewController

@property (nonatomic, strong) WJContact *contact;
@property (nonatomic, weak) id<WJEditViewControllerDelegate> delegate;

@end
