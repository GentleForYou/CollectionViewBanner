//
//  ViewController.m
//  CollectionViewBanner
//
//  Created by 掌上汇通Mac on 2018/6/25.
//  Copyright © 2018年 chushenruhua. All rights reserved.
//

#import "ViewController.h"
#import "CollecBannerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CollecBannerView *bannerView = [[CollecBannerView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 110) line:15.0 showLine: 10.0 cellMidSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-50, 110.0) zoom:0.8];
    bannerView.cellCornerRadius = 4;
    bannerView.urlImgs = @[@"http://pics.sc.chinaz.com/files/pic/pic9/201805/wpic1136.jpg",@"http://pics.sc.chinaz.com/files/pic/pic9/201805/wpic1150.jpg",@"http://pics.sc.chinaz.com/files/pic/pic9/201805/wpic857.jpg",@"http://pics.sc.chinaz.com/files/pic/pic9/201804/wpic660.jpg"];
//    bannerView.localImgs = @[@"bg_01",@"bg_02",@"bg_03",@"bg_04"];
    [self.view addSubview:bannerView];
    
//    UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 20)];
//    bannerView.customPageControl = page;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
