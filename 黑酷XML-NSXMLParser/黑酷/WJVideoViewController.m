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

@interface WJVideoViewController () <NSXMLParserDelegate>
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
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        parser.delegate = self;
        [parser parse];   // 这里是同步执行的。意思就是说在调用代理的方法时，会先卡在这里！！
        
        
        // 刷新表格
        [self.tableView reloadData];
        
    }];
    
    
}

#pragma mark - NSXMLParser的代理方法
/**
 *  开始解析整个文档时调用
 */
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"parserDidStartDocument");
}

/**
 *  结束解析整个文档时调用
 */
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"parserDidEndDocument");
}

/**
 *  开始解析元素的开头时调用
 *
 *  @param parser        解析器
 *  @param elementName   解析的元素名
 *  @param attributeDict 元素解析后得到的属性字典
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"didStartElement");
    
    if ([@"videos" isEqualToString:elementName]) return;
    
    WJVideo *video = [[WJVideo alloc] init];
    video = [WJVideo videoWithDic:attributeDict];
    [self.videos addObject:video];
}

/**
 *  解析到一个元素的结尾时调用
 *
 *  @param parser       解析器
 *  @param elementName  解析的元素名
 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"didEndElement");
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
