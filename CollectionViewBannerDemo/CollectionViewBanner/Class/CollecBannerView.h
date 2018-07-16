//
//  CollecBannerView.h
//  CollectionViewBanner
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 GentleForYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollecBannerView : UIView

//普通banner,无缩放,无间隙
- (instancetype)initWithFrame:(CGRect)frame cellMidSize:(CGSize)cellMidSize;
/*带间隙banner
 line :         cell之间间隙
 showLine :     左侧cell露出的宽度
 zoom:          缩放比例 普通cell尺寸/中间Cell尺寸 (0.0 - 1.0)
 cellMidSize:   中间Cell尺寸
 */
- (instancetype)initWithFrame:(CGRect)frame line:(CGFloat)line showLine:(CGFloat)showLine cellMidSize:(CGSize)cellMidSize zoom:(CGFloat)zoom;


// 本地图片数组,数组内可存图片名称或者图片, 建议传图片名称 如;@[@"XX",@"XX"]
@property (nonatomic, copy) NSArray *localImgs;
// 图片url数组
@property (nonatomic, copy) NSArray *urlImgs;
//点击cell事件
@property (nonatomic, copy) void(^clickBlock)(NSInteger currentIndex);

//占位图
@property (nonatomic,strong) UIImage *placeHolderImage;
// 是否在只有一张图时隐藏pagecontrol，默认为YES
@property(nonatomic) BOOL hidesForSinglePage;
// 是否在只有一张图时停止滚动,目前仅限于无缝轮播(卡片式图单张太难看) 默认为YES
@property(nonatomic) BOOL scrollEnabledForSinglePage;
//cell圆角
@property(nonatomic) CGFloat cellCornerRadius;
//自动滚动间隔时间,默认2s
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
// 是否自动滚动,默认YES
@property (nonatomic,assign) BOOL autoScroll;
//当前page小圆点颜色
@property (nonatomic, strong) UIColor *currentPageColor;
//其他page小圆点颜色
@property (nonatomic, strong) UIColor *normalPageColor;
//设置pageControl的frame
@property (nonatomic, assign) CGRect pageControlFrame;
//是否隐藏pageControl 默认为NO
@property (nonatomic, assign) BOOL hidePageControl;

//自定义pageControl, pageControl的frame需要自己设置
@property (strong, nonatomic) UIPageControl *customPageControl;


@end
