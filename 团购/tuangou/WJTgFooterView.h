//
//  WJTgFooterView.h
//  tuangou
//
//  Created by wangjie on 14-11-3.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJTgFooterView;

@protocol WJTgFooterViewDelegate <NSObject>
@optional
- (void)tgFooterViewDidClickLoadBtn:(WJTgFooterView *)tgFooterView;
@end


@interface WJTgFooterView : UIView

+ (instancetype)footerView;

@property (nonatomic, weak) id<WJTgFooterViewDelegate> delegate;

@end
