//
//  LZBTabBar.m
//  LZBTabBarVC
//
//  Created by zibin on 16/11/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBTabBar.h"
#import "Lottie.h"

#define default_TopLine_Height 0.5

#pragma mark - LZBTabBar

@interface LZBTabBar()

@property(nonatomic,assign)CGFloat itemWidth;
@property(nonatomic,assign)BOOL isAnimation;

@end

@implementation LZBTabBar

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (instancetype)init{
    if (self = [super init]) {
  
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self setupUI];
    [self layoutIfNeeded];
}

- (void)setupUI{
    self.backgroundView.alpha = 1;
    self.topLine.alpha = 1;
    NSInteger index = 0;
    Boolean isOddItems = self.lzbTabBarItemsArr.count % 2;//items为奇数个，那么就最中间的作为突出的大头
    int y = (int)ceil(self.lzbTabBarItemsArr.count / 2.0);//向上取整，求中位数
    self.itemWidth = self.bounds.size.width / self.lzbTabBarItemsArr.count;
    for (LZBTabBarItem *item in self.lzbTabBarItemsArr) {
        CGFloat itemHeight = [item itemHeight];
        if(!itemHeight)
            itemHeight = self.bounds.size.height;
        CGFloat itemW = self.itemWidth;
        CGFloat itemH = itemHeight;
        
        [self addSubview:item];
        
        if (isOddItems && y == index + 1 && self.tabBarStyleType) {
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(itemW, itemH * 4 / 3));
                LZBTabBarItem *item_ = (LZBTabBarItem *)self.lzbTabBarItemsArr[index - 1];
                make.left.equalTo(item_.mas_right);
                make.bottom.equalTo(self);
            }];
        }else{
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(itemW, itemH));
                if (index == 0) {
                    make.left.equalTo(self);
                }else{
                    LZBTabBarItem *item = (LZBTabBarItem *)self.lzbTabBarItemsArr[index - 1];
                    make.left.equalTo(item.mas_right);
                }
                make.bottom.equalTo(self);
            }];
        }
        [item setNeedsDisplay];
        {
            //Lottie 初始化
            if (_lottieJsonNameStrMutArr) {
                LOTAnimationView *animationView = [LOTAnimationView animationNamed:self.lottieJsonNameStrMutArr[index]];
    //            animation.userInteractionEnabled = YES;
    //            animation.loopAnimation//是否循环
    //            animation.animationProgress//动画的进度
    //            animation.animationDuration//动画时长
    //            animation.isAnimationPlaying//动画是否在执行
                animationView.animationSpeed = 3;//放慢动画播放速度?
                animationView.userInteractionEnabled = YES;
                animationView.contentMode = UIViewContentModeScaleAspectFill;
                item.animationView = animationView;
                [item addSubview:animationView];
                [animationView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(item);
                }];

                if (animationView.animationProgress == 0) {
                    [animationView playToProgress:0.5
                                   withCompletion:^(BOOL animationFinished) {
                        NSLog(@"pressButtonAction isSelected animation");
                    }];
                }
            }
        }
        index++;
    }
}
#pragma mark —— API
///点击事件
- (void)tabbarItemDidSelected:(LZBTabBarItem *)item{
    if (self.currentSelectItem != item) {
        if(![self.lzbTabBarItemsArr containsObject:item]) return;
        NSInteger index = [self.lzbTabBarItemsArr indexOfObject:item];
        //关于动画部分
        if (item.animationView) {
            //先全部停止
            for (id v in self.subviews) {//LZBTabBarItem
                if ([v isKindOfClass:LZBTabBarItem.class]) {
                    LZBTabBarItem *item = (LZBTabBarItem *)v;
                    [item.animationView stop];
                }
            }
            //再独开一个
            if (item.animationView.animationProgress == 0) {
                [item.animationView playToProgress:0.5
                                    withCompletion:^(BOOL animationFinished) {
                    NSLog(@"pressButtonAction isSelected animation");
                    
                }];
            }
        }
        
        if([self.delegate respondsToSelector:@selector(lzb_tabBar:shouldSelectItemAtIndex:)]){
            if(![self.delegate lzb_tabBar:self
                  shouldSelectItemAtIndex:index])
                return;
        }
        if([self.delegate respondsToSelector:@selector(lzb_tabBar:didSelectItemAtIndex:)]){
            [self.delegate lzb_tabBar:self
                 didSelectItemAtIndex:index];
        }
        self.currentSelectItem = item;
    }
}

-(void)setTabBarStyleType:(LZBTabBarStyleType)tabBarStyleType{
    if (tabBarStyleType == LZBTabBarStyleType_middleItemUp) {
        if (self.lzbTabBarItemsArr.count % 2) {
            _tabBarStyleType = tabBarStyleType;
        }else{
            _tabBarStyleType = LZBTabBarStyleType_sysNormal;
        }
    }else{
        _tabBarStyleType = tabBarStyleType;
    }
}

- (void)setLzbTabBarItemsArr:(NSArray<LZBTabBarItem *> *)lzbTabBarItemsArr{
    _lzbTabBarItemsArr = lzbTabBarItemsArr;
    if(_lzbTabBarItemsArr.count == 0) return;
    //移除所有子控件
    for (LZBTabBarItem *item in _lzbTabBarItemsArr){
        [item removeFromSuperview];
    }
    for (int i = 0; i < _lzbTabBarItemsArr.count; i++) {
        [self addSubview:_lzbTabBarItemsArr[i]];
        LZBTabBarItem *item = _lzbTabBarItemsArr[i];
        item.tagger = i;
        if (i == 0) {
            item.selected = YES;//默认第一个为点击选中状态
        }
        @weakify(self)
        //点击事件回调
        [item gestureRecognizerLZBTabBarItemBlock:^(id data,
                                                    id data2) {
            @strongify(self)
            if ([data isKindOfClass:LZBTabBarItem.class]) {
                LZBTabBarItem *item = (LZBTabBarItem *)data;
                if ([data2 isKindOfClass:UITapGestureRecognizer.class]) {//点按手势
                    [self tabbarItemDidSelected:self->_lzbTabBarItemsArr[item.tagger]];
                }else if ([data2 isKindOfClass:UILongPressGestureRecognizer.class]){//长按手势
                    NSLog(@"长按手势执行什么？");
                }else{}
            }
        }];
    }
}

- (void)setCurrentSelectItem:(LZBTabBarItem *)currentSelectItem{
    [self setCurrentSelectItem:currentSelectItem
                     animation:self.isAnimation];
}

- (void)setCurrentSelectItem:(LZBTabBarItem *)currentSelectItem
                   animation:(BOOL)animation{
    if(_currentSelectItem == currentSelectItem) return;
    _currentSelectItem.selected = NO;
    _currentSelectItem = currentSelectItem;
    _currentSelectItem.selected = YES;
    self.isAnimation = animation;
    if(self.isAnimation)
    [self addScaleAnimationWithSuperLayer:_currentSelectItem.layer];
}

- (void)addScaleAnimationWithSuperLayer:(CALayer *)layer{
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    keyAnimation.values = @[@0.8,
                            @1.1,
                            @1.0];
    keyAnimation.duration = 0.25;
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:keyAnimation
                 forKey:@"keyAnimation"];
}

#pragma mark —— LazyLoad
-(UIView *)backgroundView{
  if(!_backgroundView){
      _backgroundView = UIView.new;
      [self addSubview:_backgroundView];
      [_backgroundView addSubview:self.topLine];
      _backgroundView.frame = self.bounds;
  }return _backgroundView;
}

-(UIView *)topLine{
  if(!_topLine){
      _topLine = UIView.new;
      _topLine.backgroundColor = kClearColor;//分割线的颜色
      _topLine.frame = CGRectMake(0,
                                  0,
                                  self.bounds.size.width,
                                  default_TopLine_Height);
  }return _topLine;
}

@end


