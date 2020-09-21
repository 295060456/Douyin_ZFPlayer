//
//  BWShareView.m
//  BWShareView
//
//  Created by syt on 2019/12/20.
//  Copyright © 2019 syt. All rights reserved.
//

#import "BWShareView.h"
#import "BWItemModel.h"
#import "BWItemCollectionViewCell.h"

#define kTitleHeight         ([self.shareTitle isEqualToString:@""] ? 0 : 40)
#define RGBColor(r, g, b)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface BWShareView ()
<
UICollectionViewDelegate
,UICollectionViewDataSource
>

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)UILabel *shareTitleLabel;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout2;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UICollectionView *collectionView2;
/**
 取消按钮
 */
@property (nonatomic, strong) UIButton *cancleButton;
/**
 分享标题
 */
@property (nonatomic, strong) NSString *shareTitle;
/**
 按钮名称、图片
 */
@property (nonatomic, strong) NSArray *shareArray;
@property (nonatomic, strong) NSArray *otherArray;

@end

static NSString *const shareCell = @"shareCell";
static NSString *const itemCell = @"itemCell";

@implementation BWShareView

// 有/无标题的单层分享
- (instancetype)initWithFrame:(CGRect)frame
                   shareTitle:(NSString *)shareTitle
                   shareArray:(NSArray *)shareArray{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:.2];
        self.shareTitle = shareTitle;
        self.shareArray = shareArray;
    }return self;
}
// 有/无标题的双层分享
- (instancetype)initWithFrame:(CGRect)frame
                   shareTitle:(NSString *)shareTitle
                   firstArray:(NSArray *)firstArray
                  secondArray:(NSArray *)secondArray{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:.2];
        self.shareTitle = shareTitle;
        self.shareArray = firstArray;
        self.otherArray = secondArray;
    }return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
//    NSLog(@"view = %@", touch.view);
    // 防止误操作点击到标题收起分享页面
    if ([touch.view isKindOfClass:[BWShareView class]]) {
        [self removeChildView];
    }
}
// 显示
- (void)show{
    UIWindow *window = getMainWindow();
    [window addSubview:self];
    [self addSubview:self.bgView];
    @weakify(self)
    [UIView animateWithDuration:.3f
                     animations:^{
        @strongify(self)
        CGRect frame = self.bgView.frame;
        frame.origin.y = [self isDoubleShare] ? [UIScreen mainScreen].bounds.size.height - 230 - kTitleHeight : [UIScreen mainScreen].bounds.size.height - 140 - kTitleHeight;
        self.bgView.frame = frame;
    }];
}

- (void)removeChildView{
    @weakify(self)
    [UIView animateWithDuration:.3f
                     animations:^{
        @strongify(self)
        CGRect frame = self.bgView.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.bgView.frame = frame;
    } completion:^(BOOL finished) {
        @strongify(self)
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    if ([self isDoubleShare]) {
        if (collectionView == self.collectionView) {
            return self.shareArray.count;
        }return self.otherArray.count;
    }return self.shareArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.collectionView) {
        BWItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:shareCell
                                                                                   forIndexPath:indexPath];
        if (self.shareArray.count > 0) {
            [cell updateContent:self.shareArray[indexPath.item]];
        }return cell;
    } else {
        BWItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemCell
                                                                                   forIndexPath:indexPath];
        if (self.otherArray.count > 0) {
            [cell updateContent:self.otherArray[indexPath.item]];
        }return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    BWItemModel *model = [[BWItemModel alloc] init];
    if (collectionView == self.collectionView) {
        model = self.shareArray[indexPath.item];
    } else {
        model = self.otherArray[indexPath.item];
    }
    if (self.shareItemClick) {
        self.shareItemClick(model);
    }
}
#pragma mark - cancleButtonAction
- (void)cancleButtonAction{
    [self removeChildView];
}
#pragma mark - 判断是否为双层分享
- (BOOL)isDoubleShare{
    if (self.otherArray.count) {
        return YES;
    }return NO;
}
#pragma mark - lazy loading
- (UIView *)bgView{
    if (!_bgView) {
        CGFloat bgH = 140.0;
        if ([self isDoubleShare]) {
            bgH = 230.0;
        }
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                           [UIScreen mainScreen].bounds.size.height,
                                                           [UIScreen mainScreen].bounds.size.width,
                                                           bgH + kTitleHeight)];
        _bgView.backgroundColor = UIColor.whiteColor;
        [_bgView addSubview:self.shareTitleLabel];
        [_bgView addSubview:self.collectionView];
        if ([self isDoubleShare]) {
           [_bgView addSubview:self.collectionView2];
        }
        [_bgView addSubview:self.cancleButton];
    }return _bgView;
}

- (UILabel *)shareTitleLabel{
    if (!_shareTitleLabel) {
        _shareTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                     0,
                                                                     [UIScreen mainScreen].bounds.size.width,
                                                                     kTitleHeight)];
        _shareTitleLabel.text = [NSString stringWithFormat:@"%@", self.shareTitle];
        _shareTitleLabel.backgroundColor = RGBColor(245, 245, 245);
        _shareTitleLabel.textColor = RGBColor(153, 153, 153);
        _shareTitleLabel.textAlignment = NSTextAlignmentCenter;
        _shareTitleLabel.font = [UIFont systemFontOfSize:14];
    }return _shareTitleLabel;
}

- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        // 两种布局
        // 1、单行显示所有的分享类型
        _layout.itemSize = CGSizeMake(80, 80);
        // 2、两行甚至多行显示的分享类型
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumLineSpacing = 5.0;
        _layout.minimumInteritemSpacing = 5.0;
    }return _layout;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,
                                                                             CGRectGetMaxY(self.shareTitleLabel.frame),
                                                                             [UIScreen mainScreen].bounds.size.width,
                                                                             90)
                                             collectionViewLayout:self.layout];
        _collectionView.backgroundColor = RGBColor(245, 245, 245);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[BWItemCollectionViewCell class]
            forCellWithReuseIdentifier:shareCell];
    }return _collectionView;
}

- (UICollectionViewFlowLayout *)layout2{
    if (!_layout2) {
        _layout2 = [[UICollectionViewFlowLayout alloc] init];
        // 两种布局
        // 1、单行显示所有的分享类型
        _layout2.itemSize = CGSizeMake(80, 80);
        // 2、两行甚至多行显示的分享类型
        _layout2.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout2.minimumLineSpacing = 5.0;
        _layout2.minimumInteritemSpacing = 5.0;
    }return _layout2;
}

- (UICollectionView *)collectionView2{
    if (!_collectionView2) {
        CGFloat height = 0.0;
        if ([self isDoubleShare]) {
            height = 90;
        }
        _collectionView2 = [[UICollectionView alloc] initWithFrame:CGRectMake(0,
                                                                              CGRectGetMaxY(self.collectionView.frame),
                                                                              [UIScreen mainScreen].bounds.size.width,
                                                                              height)
                                              collectionViewLayout:self.layout2];
        _collectionView2.backgroundColor = RGBColor(245, 245, 245);
        _collectionView2.delegate = self;
        _collectionView2.dataSource = self;
        [_collectionView2 registerClass:[BWItemCollectionViewCell class] forCellWithReuseIdentifier:itemCell];
    }return _collectionView2;
}

- (UIButton *)cancleButton{
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.frame = CGRectMake(0,
                                         CGRectGetMaxY(self.collectionView2.frame),
                                         [UIScreen mainScreen].bounds.size.width,
                                         50);
        _cancleButton.backgroundColor = UIColor.whiteColor;
        [_cancleButton setTitle:@"取消"
                       forState:UIControlStateNormal];
        [_cancleButton setTitleColor:UIColor.blackColor
                            forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancleButton addTarget:self
                          action:@selector(cancleButtonAction)
                forControlEvents:UIControlEventTouchUpInside];
    }return _cancleButton;
}

- (NSArray *)shareArray{
    if (!_shareArray) {
        _shareArray = NSArray.array;
    }return _shareArray;
}

- (NSArray *)otherArray{
    if (!_otherArray) {
        _otherArray = NSArray.array;
    }return _otherArray;
}



@end
