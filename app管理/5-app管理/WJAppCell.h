//
//  WJAppCell.h
//  5-app管理
//
//  Created by wangjie on 14-12-3.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJApp, WJAppCell;

@protocol WJAppCellDelegate <NSObject>
@optional
- (void)appCellDidClickedDownloadBtn:(WJAppCell *)cell;  // 哪个cell上的btn被点了，就把这个cell传出去
@end

@interface WJAppCell : UITableViewCell

@property (nonatomic, strong) WJApp *app;
@property (nonatomic, weak) id<WJAppCellDelegate> delegate;  //代理

@end
