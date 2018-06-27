//
//  BannerLayout.m
//  CollectionViewBanner
//
//  Created by 掌上汇通Mac on 2018/6/26.
//  Copyright © 2018年 chushenruhua. All rights reserved.
//

#import "BannerLayout.h"

#define BannerOffsetWidth (self.itemSize.width+self.line)//每次移动偏移量
#define ZoomFactor ABS(1-self.zoom) //缩放比例系数

@interface BannerLayout()

@property (nonatomic, assign) CGFloat line;
@property (nonatomic, assign) CGFloat zoom;
@end

@implementation BannerLayout

- (instancetype)initLine:(CGFloat)line itemSize:(CGSize)itemSize zoom:(CGFloat)zoom
{
    if (self = [super init]) {
        
        self.line = line;
        self.zoom = zoom;
        self.itemSize = itemSize;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = line;
    }
    return self;
}
//允许更新位置
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UICollectionViewLayoutAttributes* attributes = (UICollectionViewLayoutAttributes *)obj;
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        CGFloat normalizedDistance = ABS(distance/BannerOffsetWidth);
        CGFloat zoom = 1 - ZoomFactor*normalizedDistance;
        attributes.transform3D = CATransform3DMakeScale(1.0, zoom, 1.0);
        attributes.zIndex = 1;
    }];
    return array;
}

@end
