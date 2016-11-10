//
//  SKAdScrollView.m
//  VKVickey_NCE
//
//  Created by Leou on 2016/10/8.
//  Copyright © 2016年 Leou. All rights reserved.
//
//
//  循环轮播图
//
//  ---->>>>  依赖第三方库：SDWebImage  <<<<----
//
///////////////////////////////////////////////////

#import "SKAdScrollView.h"

#import "UIImageView+WebCache.h"//ImageView 缓存

#define UISCREENWIDTH       self.bounds.size.width//广告的宽度
#define UISCREENHEIGHT      self.bounds.size.height//广告的高度

#define PAGRCONTROL_HIGHT   self.bounds.origin.y //由于_pageControl是添加进父视图的,所以实际位置要参考,滚动视图的y坐标(和滚动视图同级)

/** 轮播滚动的时间间隔 */
static CGFloat const chageImageTime = 3.5f;

@implementation SKAdScrollView {
    
    //循环滚动的三个视图
    UIImageView     *leftImageView;
    UIImageView     *centerImageView;
    UIImageView     *rightImageView;
    //为每一个图片添加一个广告语(可选)
    UILabel         *leftAdLabel;
    UILabel         *centerAdLabel;
    UILabel         *rightAdLabel;
    
    //循环滚动的周期时间
    NSTimer         *moveTime;
    //用于确定滚动式由人导致的还是计时器到了,系统帮我们滚动的,YES,则为系统滚动,NO则为客户滚动(ps.在客户端中客户滚动一个广告后,这个广告的计时器要归0并重新计时)
    BOOL            isTimeUp;
    
    /** UIPageControl */
    UIPageControl   *skPageControl;
}

#pragma mark - 自由指定广告所占的frame
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self){
        
        /** 默认数据 */
        _skPageControlShowStyle = UIPageControlShowStyleCenter;
        
        /** 初始化控件 */
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
        self.contentSize = CGSizeMake(UISCREENWIDTH * 3, UISCREENHEIGHT);
        self.delegate = self;
        
        leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        leftImageView.userInteractionEnabled = YES;
        leftImageView.tag = 1;
        leftImageView.image = [UIImage imageNamed:@"tab_home_normal"];
        [self addSubview:leftImageView];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [leftImageView addGestureRecognizer:tap1];
        leftAdLabel = [[UILabel alloc] init];
        leftAdLabel.frame = CGRectMake(10, UISCREENHEIGHT - 40, UISCREENWIDTH, 20);
        [leftImageView addSubview:leftAdLabel];
        
        centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(UISCREENWIDTH, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        centerImageView.userInteractionEnabled = YES;
        centerImageView.tag = 2;
        centerImageView.image = [UIImage imageNamed:@"tab_home_normal"];
        [self addSubview:centerImageView];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [centerImageView addGestureRecognizer:tap2];
        centerAdLabel = [[UILabel alloc] init];
        centerAdLabel.frame = CGRectMake(10, UISCREENHEIGHT - 40, UISCREENWIDTH, 20);
        [centerImageView addSubview:centerAdLabel];
        
        rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(UISCREENWIDTH*2, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        rightImageView.userInteractionEnabled = YES;
        rightImageView.tag = 3;
        rightImageView.image = [UIImage imageNamed:@"tab_home_normal"];
        [self addSubview:rightImageView];
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [rightImageView addGestureRecognizer:tap3];
        rightAdLabel = [[UILabel alloc] init];
        rightAdLabel.frame = CGRectMake(10, UISCREENHEIGHT - 40, UISCREENWIDTH, 20);
        [rightImageView addSubview:rightAdLabel];
        
        /** 轮播定时器 */
        moveTime = [NSTimer scheduledTimerWithTimeInterval:chageImageTime target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
        isTimeUp = NO;
    }
    return self;
}

#pragma mark - 点击滚动图片
- (void)tapImageView:(UITapGestureRecognizer *)tap {
    
    UIImageView *currentImageView = (UIImageView *)tap.view;
    if (_adDelegate && [_adDelegate respondsToSelector:@selector(adScrollView:didClickAdView:)]) {
        
        [_adDelegate adScrollView:self didClickAdView:currentImageView];
    }
}

#pragma mark - 设置广告所使用的图片(名字)
/** 轮播图片 */
- (void)setSkImagesUrlArray:(NSArray *)skImagesUrlArray {
    
    _skImagesUrlArray = skImagesUrlArray;
    
    [leftImageView sd_setImageWithURL:[NSURL URLWithString:skImagesUrlArray[(skImagesUrlArray.count - 1)]] placeholderImage:[UIImage imageNamed:@"tab_home_normal"]];
    [centerImageView sd_setImageWithURL:[NSURL URLWithString:skImagesUrlArray[(0 % skImagesUrlArray.count)]] placeholderImage:[UIImage imageNamed:@"tab_home_normal"]];
    [rightImageView sd_setImageWithURL:[NSURL URLWithString:skImagesUrlArray[(1 % skImagesUrlArray.count)]] placeholderImage:[UIImage imageNamed:@"tab_home_normal"]];
    
    /** 设置pageControl */
    [self initPageControl];
}

/** 轮播标题 */
- (void)setSkAdTitleArray:(NSArray *)skAdTitleArray {
    
    _skAdTitleArray = skAdTitleArray;
    
    leftAdLabel.text = skAdTitleArray[(skAdTitleArray.count - 1)];
    centerAdLabel.text = skAdTitleArray[(0 % skAdTitleArray.count)];
    rightAdLabel.text = skAdTitleArray[(1 % skAdTitleArray.count)];
}

#pragma mark - UIPageControl
/** 初始化PageControl */
- (void)initPageControl {
    
    /** 由于PageControl这个空间必须要添加在滚动视图的父视图上(添加在滚动视图上的话会随着图片滚动,而达不到效果) */
    skPageControl = [[UIPageControl alloc]init];
    skPageControl.numberOfPages = _skImagesUrlArray.count;
    skPageControl.currentPage = 0;
    skPageControl.enabled = NO;
    skPageControl.pageIndicatorTintColor = [UIColor whiteColor];
    skPageControl.currentPageIndicatorTintColor = [UIColor brownColor];
    [[self superview] addSubview:skPageControl];
    
    if (_skPageControlShowStyle == UIPageControlShowStyleLeft) {
        
        skPageControl.frame = CGRectMake(10, PAGRCONTROL_HIGHT + UISCREENHEIGHT - 20, 20 * skPageControl.numberOfPages, 20);
        
    }else if (_skPageControlShowStyle == UIPageControlShowStyleRight) {
        
        skPageControl.frame = CGRectMake( UISCREENWIDTH - 20 * skPageControl.numberOfPages, PAGRCONTROL_HIGHT + UISCREENHEIGHT - 20, 20 * skPageControl.numberOfPages, 20);
    }else {
        
        skPageControl.frame = CGRectMake(0, 0, 20*skPageControl.numberOfPages, 20);
        skPageControl.center = CGPointMake(UISCREENWIDTH/2.0, PAGRCONTROL_HIGHT + UISCREENHEIGHT - 10);
    }
}

/** 创建pageControl, 指定其显示样式 */
- (void)setSkPageControlShowStyle:(UIPageControlShowStyle)skPageControlShowStyle {
    
    if (_skPageControlShowStyle == UIPageControlShowStyleLeft) {
        
        skPageControl.frame = CGRectMake(10, PAGRCONTROL_HIGHT + UISCREENHEIGHT - 20, 20 * skPageControl.numberOfPages, 20);
        
    }else if (_skPageControlShowStyle == UIPageControlShowStyleRight) {
        
        skPageControl.frame = CGRectMake( UISCREENWIDTH - 20 * skPageControl.numberOfPages, PAGRCONTROL_HIGHT + UISCREENHEIGHT - 20, 20 * skPageControl.numberOfPages, 20);
    }else {
        
        skPageControl.frame = CGRectMake(0, 0, 20*skPageControl.numberOfPages, 20);
        skPageControl.center = CGPointMake(UISCREENWIDTH/2.0, PAGRCONTROL_HIGHT + UISCREENHEIGHT - 10);
    }
}

#pragma mark - 计时器到时,系统滚动图片
- (void)animalMoveImage {
    
    /** 滚动之后，将三张图片重置，当前展示的图片在中间，以实现轮播效果 */
    //指定取消延迟防范 未执行的一条或者多条的延迟方法.
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollViewDidEndDecelerating:) object:nil];
    [self performSelector:@selector(scrollViewDidEndDecelerating:) withObject:nil afterDelay:0.5f];
    
    [self setContentOffset:CGPointMake(UISCREENWIDTH * 2, 0) animated:YES];
    isTimeUp = YES;
}

#pragma mark - 图片停止时,调用该函数使得滚动视图复用
/** 滚动之后，将三张图片重置，当前展示的图片在中间，以实现轮播效果 */
static NSUInteger currentImageIndex = 0;//当前展示图片索引：向右为正，即默认当前为0 右侧（下一个）为1
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    /** 执行该方法之后 立即取消延迟方法 */
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollViewDidEndDecelerating:) object:nil];
    
    if (!_skImagesUrlArray || _skImagesUrlArray.count <= 0) {
        
        return;
    }
    
    if (self.contentOffset.x == 0) {
        
        /** 表示向左滑动 轮播图向左滚动 */
        if (currentImageIndex == 0) {
            
            currentImageIndex = _skImagesUrlArray.count - 1;
            skPageControl.currentPage = _skImagesUrlArray.count - 1;
            
        }else {
            
            currentImageIndex = (currentImageIndex - 1) % _skImagesUrlArray.count;
            skPageControl.currentPage = (skPageControl.currentPage - 1) % _skImagesUrlArray.count;
            
        }
    }else if (self.contentOffset.x == UISCREENWIDTH * 2) {
        
        /** 表示向右滑动 轮播图向右滚动 */
        if (_skImagesUrlArray && _skImagesUrlArray.count > 0) {
            
            currentImageIndex = (currentImageIndex + 1) % _skImagesUrlArray.count;
            skPageControl.currentPage = (skPageControl.currentPage + 1) % _skImagesUrlArray.count;
        }
    }else{
        
        return;
    }
    
    /** currentImageIndex 是当前展示图片的索引 */
    if (currentImageIndex == 0) {
        
        [leftImageView sd_setImageWithURL:[NSURL URLWithString:_skImagesUrlArray[_skImagesUrlArray.count - 1]] placeholderImage:[UIImage imageNamed:@"tab_home_normal"]];
    }else {
        
        [leftImageView sd_setImageWithURL:[NSURL URLWithString:_skImagesUrlArray[(currentImageIndex - 1) % _skImagesUrlArray.count]] placeholderImage:[UIImage imageNamed:@"tab_home_normal"]];
    }
    [centerImageView sd_setImageWithURL:[NSURL URLWithString:_skImagesUrlArray[currentImageIndex % _skImagesUrlArray.count]] placeholderImage:[UIImage imageNamed:@"tab_home_normal"]];
    [rightImageView sd_setImageWithURL:[NSURL URLWithString:_skImagesUrlArray[(currentImageIndex + 1) % _skImagesUrlArray.count]] placeholderImage:[UIImage imageNamed:@"tab_home_normal"]];
    
    /** 轮播图标题 */
    if (_skAdTitleArray && _skAdTitleArray.count > 0) {
        
        leftAdLabel.text = _skAdTitleArray[(currentImageIndex - 1) % _skAdTitleArray.count];
        centerAdLabel.text = _skAdTitleArray[currentImageIndex % _skAdTitleArray.count];
        rightAdLabel.text = _skAdTitleArray[(currentImageIndex + 1) % _skAdTitleArray.count];
    }
    
    self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
    
    //手动控制图片滚动应该取消那个三秒的计时器
    if (!isTimeUp) {
        
        [moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:chageImageTime]];
    }
    isTimeUp = NO;
}

@end
