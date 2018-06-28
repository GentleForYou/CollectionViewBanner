//
//  BannerCollectionViewCell.m
//  CollectionViewBanner
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 GentleForYou. All rights reserved.
//

#import "BannerCollectionViewCell.h"

@implementation BannerCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [self addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
