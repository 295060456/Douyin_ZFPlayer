//
//  UIView+Gesture.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/4.
//

#import <UIKit/UIKit.h>
#import "NSString+Extras.h"

/*
 *  UIGestureRecognizer 是父类
 
    UITapGestureRecognizer    轻拍手势【OK】
    UISwipeGestureRecognizer    轻扫手势【OK】
    UILongPressGestureRecognizer    长按手势【OK】
    UIPanGestureRecognizer    平移手势【OK】
    UIPinchGestureRecognizer    捏合（缩放）手势【OK】
    UIRotationGestureRecognizer    旋转手势【OK】
    UIScreenEdgePanGestureRecognizer    屏幕边缘平移【OK】
 *
 */

/*
 * 长按手势是连续的。
 当在指定的时间段（minimumPressDuration）
 按下允许的手指的数量（numberOfTouchesRequired）
 并且触摸不超过允许的移动范围（allowableMovement）时，
 手势开始（UIGestureRecognizerStateBegan）。
 手指移动时，手势识别器转换到“更改”状态，
 并且当任何手指抬起时手势识别器结束（UIGestureRecognizerStateEnded）。
 *
 */

NS_ASSUME_NONNULL_BEGIN

#warning —— 本类不实现UIGestureRecognizerDelegate的原因说明:覆盖了UISCrollView 里面对应的方法

@interface UIView (Gesture)
// config
@property(nonatomic,weak,nullable)id target;
@property(nonatomic,strong)NSString *longPressGRSEL;//长按手势触发方法
@property(nonatomic,strong)NSString *tapGRSEL;//轻拍手势触发方法
@property(nonatomic,strong)NSString *swipeGRSEL;//轻扫手势触发方法
@property(nonatomic,strong)NSString *panGRSEL;//平移手势触发方法
@property(nonatomic,strong)NSString *pinchGRSEL;//捏合（缩放）手势触发方法
@property(nonatomic,strong)NSString *rotationGRSEL;//旋转手势触发方法
@property(nonatomic,strong)NSString *screenEdgePanGRSEL;//屏幕边缘平移触发方法
@property(nonatomic,assign)NSUInteger numberOfTapsRequired;//设置轻拍次数【UILongPressGestureRecognizer】【UITapGestureRecognizer】
@property(nonatomic,assign)NSUInteger numberOfTouchesRequired;//设置手指字数【UILongPressGestureRecognizer】【UITapGestureRecognizer】
@property(nonatomic,assign)NSTimeInterval minimumPressDuration;//longPressGR最小长按时间【UILongPressGestureRecognizer】
@property(nonatomic,assign)CGFloat allowableMovement;//【UILongPressGestureRecognizer】
@property(nonatomic,assign)UISwipeGestureRecognizerDirection swipeGRDirection;//swipe手势清扫方向
@property(nonatomic,assign)UIScrollTypeMask allowedScrollTypesMask API_AVAILABLE(ios(13.4));
@property(nonatomic,assign)CGFloat scale;//捏合范围
@property(nonatomic,assign)CGFloat rotate;//旋转角度
// UIGestureRecognizer
@property(nonatomic,strong)UILongPressGestureRecognizer *longPressGR;//长按手势
@property(nonatomic,strong)UITapGestureRecognizer *tapGR;//点击手势
@property(nonatomic,strong)UISwipeGestureRecognizer *swipeGR;//轻扫手势
@property(nonatomic,strong)UIPanGestureRecognizer *panGR;//平移手势
@property(nonatomic,strong)UIPinchGestureRecognizer *pinchGR;//捏合（缩放）手势
@property(nonatomic,strong)UIRotationGestureRecognizer *rotationGR;//旋转手势
@property(nonatomic,strong)UIScreenEdgePanGestureRecognizer *screenEdgePanGR;//屏幕边缘平移

-(void)Dealloc;

@end

NS_ASSUME_NONNULL_END

/*
 
 使用示例：某View A上加载控件userHeaderIMGV，这时候_userHeaderIMGV.target = self;这个self就是View A
 
-(void)skipToUserDetail{
    NSLog(@"");
}
#pragma mark —— lazyLoad
-(UIImageView *)userHeaderIMGV{
    if (!_userHeaderIMGV) {
        _userHeaderIMGV = UIImageView.new;
        
        {// A
            _userHeaderIMGV.userInteractionEnabled = YES;
            _userHeaderIMGV.target = self;
            _userHeaderIMGV.tapGRSEL = NSStringFromSelector(@selector(skipToUserDetail));
            _userHeaderIMGV.numberOfTouchesRequired = 1;
            _userHeaderIMGV.numberOfTapsRequired = 1;
            _userHeaderIMGV.tapGR.enabled = YES;
        }
        
        [self.contentView addSubview:_userHeaderIMGV];
        [_userHeaderIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(29, 29));
            make.top.equalTo(self.contentView).offset(7);
            make.left.equalTo(self.contentView).offset(16);
        }];
        [UIView cornerCutToCircleWithView:_userHeaderIMGV
                          andCornerRadius:29 / 2];
    }return _userHeaderIMGV;
}
*/
