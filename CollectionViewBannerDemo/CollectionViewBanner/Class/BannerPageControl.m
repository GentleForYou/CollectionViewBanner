//
//  BannerPageControl.m
//  CollectionViewBanner
//
//  Created by mac on 2018/6/27.
//  Copyright © 2018年 GentleForYou. All rights reserved.
//

#import "BannerPageControl.h"

#define PageW 14 // 圆点宽
#define PageH 2  // 圆点高
#define CurrentW 75 // 当前圆点宽
#define CurrentH 2  // 当前圆点高
#define PageLine 5 // 圆点间距

@implementation BannerPageControl

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.userInteractionEnabled = NO;
    
    CGFloat allW = (self.subviews.count - 1)*(PageW+PageLine)+CurrentW;
    CGFloat originX = self.frame.size.width/2-allW/2;
    for (int i = 0; i < self.subviews.count; i++) {
        UIView *view = self.subviews[i];
        if (i == self.currentPage) {//当前page
            view.frame = CGRectMake(originX+ i*(PageW+PageLine), view.frame.origin.y, CurrentW, CurrentH);
        } else if (i > self.currentPage) {
                view.frame = CGRectMake(originX+ i * (PageW+PageLine)+(CurrentW-PageW), view.frame.origin.y, PageW, PageH);
        } else {
                view.frame = CGRectMake(originX+ i * (PageW+PageLine), view.frame.origin.y, PageW, PageH);
        }
        
        view.layer.cornerRadius = 1;
        view.layer.masksToBounds = YES;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
