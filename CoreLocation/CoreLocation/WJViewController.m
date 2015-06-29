//
//  WJViewController.m
//  CoreLocation
//
//  Created by wangjie on 15-2-10.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface WJViewController () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *mag;
@end


@implementation WJViewController

- (CLLocationManager *)mag
{
    // 如果位置服务不可用，返回空
    if (![CLLocationManager locationServicesEnabled]) return nil;
    
    if (_mag == nil) {
        self.mag = [[CLLocationManager alloc] init];
        
        self.mag.delegate = self;
    }
    return _mag;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.mag startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
/**
 *  定位成功后就会调用这个方法，且调用频率很高
 *  @param locations 位置信息
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"didUpdateLocations--------");
    
    [manager stopUpdatingLocation];
}



@end
