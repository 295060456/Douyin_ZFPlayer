//
//  JhtBannerView.m
//  JhtBannerScrollView
//
//  GitHub主页: https://github.com/jinht
//  CSDN博客: http://blog.csdn.net/anticipate91
//
//  Created by Jinht on 2017/6/2.
//  Copyright © 2017年 JhtBannerScrollView. All rights reserved.
//

#import "JhtBannerView.h"
#import "AABlock.h"

@interface JhtBannerView ()
<
JhtBannerScrollViewDelegate
,JhtBannerScrollViewDataSource
>

@property(nonatomic,copy)MKDataBlock scrollBlock;
@property(nonatomic,copy)MKDataBlock clickBlock;

@end

@implementation JhtBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 添加banner view（整条view）
        [self addSubview:self.bannerView];
    }return self;
}

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
   
}
#pragma mark - Public Method
-(void)clickScrollViewInsideCardView:(MKDataBlock)clickBlock{
    self.clickBlock = clickBlock;
}

-(void)scrollViewIndex:(MKDataBlock)scrollBlock{
    self.scrollBlock = scrollBlock;
}
#pragma mark - JhtBannerViewDelegate
/** 当前显示cardView的Size */
- (CGSize)sizeForCurrentCardViewInBannerView:(JhtBannerScrollView *)bannerView {
    return CGSizeMake(self.JhtBannerCardViewSize.width,
                      self.JhtBannerCardViewSize.height);
}
/** 滚动到了某一个cardView */
- (void)bannerView:(JhtBannerScrollView *)bannerView
didScrollToCardViewWithIndex:(NSInteger)index {
    NSLog(@"滚动到了第 %ld 页", index);
    if (self.scrollBlock) {
        self.scrollBlock(@(index));
    }
}
/** 点击了第几个cardView
 *  bannerCardView: 点击cardView
 *  index: 点击bannerCardView的index
 */
- (void)bannerView:(JhtBannerScrollView *)bannerView
 didSelectCardView:(UIView *)cardView
 withCardViewIndex:(NSInteger)index {
    if (self.clickBlock) {
        self.clickBlock(@(index));
    }
}
#pragma mark - JhtBannerViewDataSource
/** 显示cardView的个数 */
- (NSInteger)numberOfCardViewInBannerView:(JhtBannerScrollView *)bannerView {
    return self.dataArr.count;
}

-(CGSize)JhtBannerCardViewSize{
    if (CGSizeEqualToSize(CGSizeZero, _JhtBannerCardViewSize)) {
        _JhtBannerCardViewSize = CGSizeMake(SCREEN_WIDTH / self.dataArr.count, self.mj_h);
    }return _JhtBannerCardViewSize;
}

/** 单个cardView */
- (UIView *)bannerView:(JhtBannerScrollView *)bannerView
cardViewForBannerViewAtIndex:(NSInteger)index {
    JhtBannerCardView *cardView = (JhtBannerCardView *)[bannerView dequeueReusableView];
    if (!cardView) {
        cardView = [[JhtBannerCardView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       self.JhtBannerCardViewSize.width,
                                                                       self.JhtBannerCardViewSize.height)];
        
        cardView.tag = index;
    }
    
    //data
    if ([self.dataArr.firstObject isKindOfClass:UIImage.class]) {
        cardView.cardImageView.image = self.dataArr[index];
    }else if ([self.dataArr.firstObject isKindOfClass:NSString.class]){
        NSString *str = self.dataArr[index];
        //单纯的字符串 或者是 网址
        if ([str containsString:@"http"]) {
            [cardView.cardImageView sd_setImageWithURL:[NSURL URLWithString:str]
                                      placeholderImage:[UIImage imageNamed:self.placeholderImageName]];
        }else{
            cardView.cardLab.text = [NSString ensureNonnullString:(NSString *)self.dataArr[index] ReplaceStr:self.placeholderName];
        }
    }
    return cardView;
}
#pragma mark - Getter
- (JhtBannerScrollView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[JhtBannerScrollView alloc] initWithFrame:CGRectMake(0,
                                                                            0,
                                                                            CGRectGetWidth(self.frame),
                                                                            CGRectGetHeight(self.frame))];
        _bannerView.delegate = self;
        _bannerView.dataSource = self;
        _bannerView.autoTime = 3.0;
        _bannerView.minCoverViewAlpha = 0.2;
        _bannerView.leftRightMargin = 25 / 2.0 * WidthScale375;
        _bannerView.topBottomMargin = 15 / 2.0 * WidthScale375;
        _bannerView.orientation = BV_Orientation_Horizontal;
        _bannerView.isOpenAutoScroll = YES;
    }return _bannerView;
}
#pragma mark - Setter
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    [_bannerView reloadData];
    [self bavAddPageControl];
}
#pragma mark Setter Method
/** 添加pageControl */
- (void)bavAddPageControl {
    //置空
    if (_bannerView.pageControl) {
        [_bannerView.pageControl removeFromSuperview];
        _bannerView.pageControl = nil;
    }
    
    if (!_bannerView.pageControl) {
        UIPageControl *pageControl = UIPageControl.new;
        pageControl.center = CGPointMake(self.center.x,
                                         pageControl.center.y);
        pageControl.numberOfPages = _dataArr.count;
        self.bannerView.pageControl = pageControl;
        [self addSubview:self.bannerView.pageControl];
        [self.bannerView.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(100, 8));
            make.bottom.equalTo(self);
        }];
    }
}


@end
