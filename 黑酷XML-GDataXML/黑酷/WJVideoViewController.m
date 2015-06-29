//
//  WJVideoViewController.m
//  黑酷
//
//  Created by wangjie on 15-3-2.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJVideoViewController.h"
#import "MBProgressHUD+MJ.h"
#import "WJVideo.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import "GDataXMLNode.h"

@interface WJVideoViewController ()
@property (nonatomic, strong) NSMutableArray *videos;
@end


@implementation WJVideoViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (NSMutableArray *)videos
{
    if (_videos == nil) {
        self.videos = [[NSMutableArray alloc] init];
    }
    return _videos;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = 70;
    
    // 加载服务器的视频信息
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/video?type=XML"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError || data == nil) {
            [MBProgressHUD showError:@"网络繁忙，请稍后再试"];
            return;
        }
        
        // 解析XML数据
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
        GDataXMLElement *root = [doc rootElement];
        
        NSArray *elements = [root elementsForName:@"video"];
        
        for (GDataXMLElement *element in elements) {
        
            WJVideo *video = [[WJVideo alloc] init];
            
            video.id = [element attributeForName:@"id"].stringValue.intValue;
            video.length = [element attributeForName:@"length"].stringValue.intValue;
            video.image = [element attributeForName:@"image"].stringValue;
            video.name = [element attributeForName:@"name"].stringValue;
            video.url = [element attributeForName:@"url"].stringValue;
            
            [self.videos addObject:video];
        }
        
        // 刷新表格
        [self.tableView reloadData];
        
    }];
    
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"video";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    WJVideo *video = self.videos[indexPath.row];
    cell.textLabel.text = video.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"时长 : %d", video.length];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/MJServer/%@", video.image]];
    [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"minion"]];
    
    return cell;
    
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJVideo *video = self.videos[indexPath.row];
    
    // 创建系统自带的视频播放控制器
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/MJServer/%@", video.url]];
    MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self presentViewController:player animated:YES completion:nil];
    
}


@end
