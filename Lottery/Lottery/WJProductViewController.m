//
//  WJProductViewController.m
//  Lottery
//
//  Created by wangjie on 15-2-2.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJProductViewController.h"
#import "WJProduct.h"
#import "WJProductCell.h"

#define WJProductCellID @"product"

@interface WJProductViewController ()
/**
 *  product模型数组
 */
@property (nonatomic ,strong) NSArray *products;
@end


@implementation WJProductViewController

- (NSArray *)products
{
    if (_products == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"product.json" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        NSArray *dicArray =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
//        NSLog(@"%@", dicArray);
        
        NSMutableArray *productArray = [NSMutableArray array];
        for (NSDictionary *dic in dicArray) {
            WJProduct *product = [WJProduct productWithDic:dic];
            [productArray addObject:product];
        }
        
        _products = productArray;
        
    }
    return _products;
}

/**
 UICollectionView must be initialized with a non-nil layout parameter
 UICollectionViewLayout是一个抽象的父类，使用的都是它的子类（布局对象管理布局）
 */
- (id)init
{
    // 布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(80, 80);
    layout.minimumInteritemSpacing = 0.0;  // X方向上的间距
    layout.minimumLineSpacing = 10.0;         // Y方向上的间距
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);   // 四周的内边距
    
    if (self = [super initWithCollectionViewLayout:layout]) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // 注册cell。用的是什么类型的cell，标识是什么。
    // 通过代码注册cell
    // [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:WJProductCellID];
    
    // 通过xib注册cell
    UINib *nib = [UINib nibWithNibName:@"WJProductCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:WJProductCellID];
    
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.去缓存池中找cell，缓存池中如果没有，系统会自动创建一个并返回（cell的创建要先注册，通过注册的cell来创建一个cell对象）
    WJProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WJProductCellID forIndexPath:indexPath];
    
    // 2.设置数据
    cell.product = self.products[indexPath.item];
    
    return cell;
}

#pragma mark - 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJProduct *product = self.products[indexPath.item];
    NSLog(@"----%@----", product.title);
}



@end
