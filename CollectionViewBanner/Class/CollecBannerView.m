//
//  CollecBannerView.m
//  CollectionViewBanner
//
//  Created by 掌上汇通Mac on 2018/6/25.
//  Copyright © 2018年 chushenruhua. All rights reserved.
//

#import "CollecBannerView.h"
#import "BannerCollectionViewCell.h"
#import "BannerLayout.h"
#import "BannerPageControl.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define BannerOffsetWidth (_cellMidSize.width+_line) //每次移动偏移量
#define BannerOffsetleft  (_line+_showLine)   //左侧偏移的差值
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface CollecBannerView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIPageControl *pageControl;

@property (nonatomic, assign) NSInteger selectedIndex;//当前index

@property (nonatomic,weak) NSTimer *timer;
@property (nonatomic, copy) NSArray *dataImgs;
@property (nonatomic, assign) CGFloat line;//间隙,默认为0
@property (nonatomic, assign) CGFloat showLine;//小cell露出间隙,默认为0
@property (nonatomic, assign) CGFloat zoom;//小cell露出间隙,默认为0
@property (nonatomic, assign) CGSize cellMidSize;
@property (nonatomic, assign) CGSize collectionSize;
@end

@implementation CollecBannerView

#pragma mark 控件初始化
- (instancetype)initWithFrame:(CGRect)frame line:(CGFloat)line showLine:(CGFloat)showLine cellMidSize:(CGSize)cellMidSize zoom:(CGFloat)zoom
{//带间隙banner
    if (self = [super initWithFrame:frame]) {
        self.hidesForSinglePage = YES;
        self.autoScroll = YES;
        self.zoom = zoom;
        self.autoScrollTimeInterval = 2.0f;
        self.line = line;
        self.showLine = showLine;
        self.cellMidSize = cellMidSize;
        self.collectionSize = frame.size;
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame cellMidSize:(CGSize)cellMidSize
{//普通banner
    return [self initWithFrame:frame line:0.0 showLine:0.0 cellMidSize:cellMidSize zoom:1];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _selectedIndex = 0;
        BannerLayout *layout = [[BannerLayout alloc] initLine:_line itemSize:_cellMidSize zoom:self.zoom];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, _collectionSize.width, _collectionSize.height) collectionViewLayout:layout];
        _collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[BannerCollectionViewCell class] forCellWithReuseIdentifier:@"BannerCollectionViewCell"];
    }
    return _collectionView;
}
- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[BannerPageControl alloc] initWithFrame:CGRectMake(0, _collectionSize.height+15, _collectionSize.width, 15)];
        _pageControl.currentPageIndicatorTintColor = UIColorFromRGB(0x333333);
        _pageControl.pageIndicatorTintColor = UIColorFromRGB(0x999999);
    }
    return _pageControl;
}

#pragma mark UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataImgs.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BannerCollectionViewCell" forIndexPath:indexPath];
    if (_urlImgs.count > 0) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_dataImgs[indexPath.row]] placeholderImage:_placeHolderImage];
    } else if (_localImgs.count > 0) {
        if ([_dataImgs[indexPath.row] isKindOfClass:[NSString class]]) {
            cell.imageView.image = [UIImage imageNamed:_dataImgs[indexPath.row]];
        } else if ([_dataImgs[indexPath.row] isKindOfClass:[UIImage class]]) {
            cell.imageView.image = _dataImgs[indexPath.row];
        } 
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
#pragma mark 数据赋值
- (void)setUrlImgs:(NSArray *)urlImgs
{
    if (urlImgs.count > 0) {
        NSMutableArray *arr = [urlImgs mutableCopy];
        if (_urlImgs.count == 1) {
            [arr addObject:urlImgs[0]];
            [arr addObject:urlImgs[0]];
            [arr insertObject:urlImgs[urlImgs.count-1] atIndex:0];
            [arr insertObject:urlImgs[urlImgs.count-1] atIndex:0];
        } else {
            [arr addObject:urlImgs[0]];
            [arr addObject:urlImgs[1]];
            [arr insertObject:urlImgs[urlImgs.count-1] atIndex:0];
            [arr insertObject:urlImgs[urlImgs.count-2] atIndex:0];
        }
        _urlImgs = [arr copy];
        _dataImgs = [arr copy];
        [_collectionView reloadData];
        _collectionView.contentOffset = CGPointMake(BannerOffsetWidth*2-BannerOffsetleft, 0);
        _selectedIndex = 0;
        _pageControl.numberOfPages = urlImgs.count;
        _pageControl.currentPage = _selectedIndex;
        if (urlImgs.count == 1 && _hidesForSinglePage) {
            _pageControl.hidden = YES;
        }
    }
}
- (void)setLocalImgs:(NSArray *)localImgs
{
    if (localImgs.count > 0) {
        
         NSMutableArray *arr = [localImgs mutableCopy];
        if (localImgs.count == 1) {
            [arr addObject:localImgs[0]];
            [arr addObject:localImgs[0]];
            [arr insertObject:localImgs[localImgs.count-1] atIndex:0];
            [arr insertObject:localImgs[localImgs.count-1] atIndex:0];
        } else {
            [arr addObject:localImgs[0]];
            [arr addObject:localImgs[1]];
            [arr insertObject:localImgs[localImgs.count-1] atIndex:0];
            [arr insertObject:localImgs[localImgs.count-2] atIndex:0];
        }
        _localImgs = [arr copy];
        if (_urlImgs.count == 0) {
            _dataImgs = [arr copy];
        }
        [_collectionView reloadData];
        _collectionView.contentOffset = CGPointMake(BannerOffsetWidth*2-BannerOffsetleft, 0);
        _selectedIndex = 0;
        _pageControl.numberOfPages = localImgs.count;
        _pageControl.currentPage = _selectedIndex;
        if (localImgs.count == 1 && _hidesForSinglePage) {
            _pageControl.hidden = YES;
        }
    }
}

- (void)setCurrentPageColor:(UIColor *)currentPageColor
{
    _currentPageColor = currentPageColor;
    _pageControl.currentPageIndicatorTintColor = _currentPageColor;
}
- (void)setNormalPageColor:(UIColor *)normalPageColor
{
    _normalPageColor = normalPageColor;
    _pageControl.pageIndicatorTintColor = _normalPageColor;
    
}
- (void)setHidesForSinglePage:(BOOL)hidesForSinglePage
{
    _hidesForSinglePage = hidesForSinglePage;
}
- (void)setCustomPageControl:(UIPageControl *)customPageControl
{
    _customPageControl = customPageControl;
    if (_pageControl) {
        [_pageControl removeFromSuperview];
    }
    self.pageControl = customPageControl;
    _pageControl.numberOfPages = _dataImgs.count;
    _pageControl.currentPage = _selectedIndex;
    [self addSubview:self.pageControl];
}
- (void)setPageControlFrame:(CGRect)pageControlFrame
{
    _pageControlFrame = pageControlFrame;
    _pageControl.frame = pageControlFrame;
}
#pragma mark 定时器以及自动滚动相关设置
-(void)createTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)automaticScroll
{
    if (_dataImgs.count > 0 && _collectionView.scrollEnabled && _timer) {
        if ([self scrollViewBorderJudge]) {//定时器控制滚动
            NSInteger index = (NSInteger)((_collectionView.contentOffset.x+_line+_showLine)/BannerOffsetWidth);
            [_collectionView setContentOffset:CGPointMake(BannerOffsetWidth*(index+1)-BannerOffsetleft, 0.0) animated:YES];
            _selectedIndex = index-1;
            _pageControl.currentPage = _selectedIndex;
        }
    }
}
- (void)invalidateTimer {
    if(_timer){
        [_timer invalidate];
        _timer = nil;
    }
}

-(void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;

    [self invalidateTimer];
    if (_autoScroll) {
        [self createTimer];
    }
}
- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval {
    _autoScrollTimeInterval = autoScrollTimeInterval;
    [self setAutoScroll:self.autoScroll];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self scrollViewBorderJudge];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self scrollViewBorderJudge]) {
        [self handCellSeleceLocation];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.autoScroll) {
        [self invalidateTimer];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {//不减速
        if ([self scrollViewBorderJudge]) {
            [self handCellSeleceLocation];
        }
    }
    if (self.autoScroll) {
        [self createTimer];
    }
}
#pragma mark 边界以及cell位置处理
//处理边界条件 返回YES代表未触发边界条件,且满足_dataImgs.count > 0
- (BOOL)scrollViewBorderJudge
{
    if (_dataImgs.count > 0) {
        if (_collectionView.contentOffset.x <= BannerOffsetWidth*1-BannerOffsetleft) {//左侧边界(正数第二个)->倒数第三个
            _collectionView.contentOffset = CGPointMake(BannerOffsetWidth*(_dataImgs.count-3)-BannerOffsetleft, 0);
            _selectedIndex = _dataImgs.count-5;
            _pageControl.currentPage = _selectedIndex;
            return NO;
        } else if (_collectionView.contentOffset.x >= BannerOffsetWidth*(_dataImgs.count-2)-BannerOffsetleft) {//右侧边界(倒数第二个)->正数第三个
            _collectionView.contentOffset = CGPointMake(BannerOffsetWidth*2-BannerOffsetleft, 0);
            _selectedIndex = 0;
            _pageControl.currentPage = _selectedIndex;
            return NO;
        }
        return YES;
    }
    return NO;
}
//滚动停止确保cell在中间
- (void)handCellSeleceLocation
{
    
    CGFloat OffsetIndex = (_collectionView.contentOffset.x+_line+_showLine)/BannerOffsetWidth;
    NSInteger index = (NSInteger)((_collectionView.contentOffset.x+_line+_showLine)/BannerOffsetWidth);
    if ((NSInteger)(OffsetIndex*100)%100 <= 50) {
           [_collectionView setContentOffset:CGPointMake(BannerOffsetWidth*index-BannerOffsetleft, 0.0) animated:YES];
           _selectedIndex = index-2;
    } else {
        [_collectionView setContentOffset:CGPointMake(BannerOffsetWidth*(index+1)-BannerOffsetleft, 0.0) animated:YES];
        _selectedIndex = index-1;
    }
    _pageControl.currentPage = _selectedIndex;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
