# 有间隙卡片缩放/无缝CollectionViewBanner无限轮播图



***
> ###为什么重复造轮子?
> 因为大多数banner都是无缝滚动,有卡片缩放效果的又没有
> PageControl,且PageControl样式不支持自定义,所以根据自己项目
> 需求和UI需求,造了一个轮子,希望分享出来能对大家有帮助,好用的话
> 点个星
 
![gif介绍](http://p9a0rgbgy.bkt.clouddn.com/45.gif)

![间距介绍](http://p9a0rgbgy.bkt.clouddn.com/55.png)

***

> ###使用姿势
 
 
```
platform :ios, "9.0"

target '你的工程名' do

pod 'CollectionViewBanner', '~> 1.0'

end
```

> ###urls图片轮播

```
	/*带间隙banner
	 line :         cell之间间隙
	 showLine :     左侧cell露出的宽度
	 zoom:          缩放比例 普通cell尺寸/中间Cell尺寸 (0.0 - 1.0)
	 cellMidSize:   中间Cell尺寸
	 */
    CollecBannerView *bannerView = [[CollecBannerView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 110) line:15.0 showLine: 10.0 cellMidSize:CGSizeMake(kScreenWidth-50, 110.0) zoom:0.8];
    bannerView.cellCornerRadius = 4;
    bannerView.placeHolderImage = [UIImage imageNamed:@"bg_01"];
    bannerView.urlImgs = @[@"http://pics.sc.chinaz.com/files/pic/pic9/201805/wpic1136.jpg",@"http://pics.sc.chinaz.com/files/pic/pic9/201805/wpic1150.jpg",@"http://pics.sc.chinaz.com/files/pic/pic9/201805/wpic857.jpg",@"http://pics.sc.chinaz.com/files/pic/pic9/201804/wpic660.jpg"];
    [bannerView setClickBlock:^(NSInteger currentIndex) {
        NSLog(@"网络第%ld张图", currentIndex);
    }];
    [self.view addSubview:bannerView];
```


> ###本地图片轮播

```
    CollecBannerView *bannerView1 = [[CollecBannerView alloc] initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 200) cellMidSize:CGSizeMake(kScreenWidth, 200)];
    bannerView1.localImgs = @[@"1",@"2",@"3",@"4"];
    bannerView1.pageControlFrame = CGRectMake(0, 200-15, kScreenWidth, 15);
    [bannerView1 setClickBlock:^(NSInteger currentIndex) {
        NSLog(@"本地第%ld张图", currentIndex);
    }];
    [self.view addSubview:bannerView1];
```

> #####其他属性详细说明

* @property (strong, nonatomic) UIPageControl *customPageControl;

```
如果对pageControl不满意,可以自定义pageControl,然后用customPageControl属性传进去
UIPageControl *pageControl  = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 200-15, kScreenWidth, 15)];
bannerView.customPageControl = pageControl;
```

* @property (nonatomic, assign) CGRect pageControlFrame;

```
觉得pageControl位置不满意,可以自己设置Frame
bannerView.pageControlFrame = CGRectMake(0, 200-15, kScreenWidth, 15);
```

 * 其他更多属性去CollecBannerView.h中看;
 
 * 有用的话,希望大家点个星再走;
 * 有bug或者其他问题,也希望能issues或者发邮箱
 * 详细原理有时间再补博客
