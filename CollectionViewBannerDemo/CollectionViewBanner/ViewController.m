//
//  ViewController.m
//  CollectionViewBanner
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 GentleForYou. All rights reserved.
//

#import "ViewController.h"
#import "CollecBannerView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //urls图片轮播
    CollecBannerView *bannerView = [[CollecBannerView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 110) line:15.0 showLine: 10.0 cellMidSize:CGSizeMake(kScreenWidth-50, 110.0) zoom:0.8];
    bannerView.cellCornerRadius = 4;
    bannerView.placeHolderImage = [UIImage imageNamed:@"bg_01"];
    bannerView.urlImgs = @[@"http://pics.sc.chinaz.com/files/pic/pic9/201805/wpic1136.jpg",@"http://pics.sc.chinaz.com/files/pic/pic9/201805/wpic1150.jpg",@"http://pics.sc.chinaz.com/files/pic/pic9/201805/wpic857.jpg",@"http://pics.sc.chinaz.com/files/pic/pic9/201804/wpic660.jpg"];
    [bannerView setClickBlock:^(NSInteger currentIndex) {
        NSLog(@"网络第%ld张图", currentIndex);
    }];
    [self.view addSubview:bannerView];
    
    //本地图片轮播
    CollecBannerView *bannerView1 = [[CollecBannerView alloc] initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 200) cellMidSize:CGSizeMake(kScreenWidth, 200)];
    bannerView1.localImgs = @[@"1",@"2",@"3",@"4"];
    bannerView1.pageControlFrame = CGRectMake(0, 200-15, kScreenWidth, 15);
    [bannerView1 setClickBlock:^(NSInteger currentIndex) {
        NSLog(@"本地第%ld张图", currentIndex);
    }];
    [self.view addSubview:bannerView1];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
