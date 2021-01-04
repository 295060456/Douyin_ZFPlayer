//
//  UIView+Gesture.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/4.
//

#import <UIKit/UIKit.h>

/*
 *  UIGestureRecognizer 是父类
 
    UITapGestureRecognizer    轻拍手势
    UISwipeGestureRecognizer    轻扫手势
    UILongPressGestureRecognizer    长按手势
    UIPanGestureRecognizer    平移手势
    UIPinchGestureRecognizer    捏合（缩放）手势
    UIRotationGestureRecognizer    旋转手势
    UIScreenEdgePanGestureRecognizer    屏幕边缘平移
 *
 */

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Gesture)<UIGestureRecognizerDelegate>
// config
@property(nonatomic,weak,nullable)id target;
@property(nonatomic,strong)NSString *longPressGRSEL;
@property(nonatomic,strong)NSString *tapGRSEL;
@property(nonatomic,assign)NSUInteger numberOfTapsRequired;//设置轻拍次数【UILongPressGestureRecognizer】【UITapGestureRecognizer】
@property(nonatomic,assign)NSUInteger numberOfTouchesRequired;//设置手指字数【UILongPressGestureRecognizer】【UITapGestureRecognizer】
@property(nonatomic,assign)NSTimeInterval minimumPressDuration;//longPressGR最小长按时间【UILongPressGestureRecognizer】
@property(nonatomic,assign)CGFloat allowableMovement;//【UILongPressGestureRecognizer】
@property(nonatomic,assign)UISwipeGestureRecognizerDirection swipeGRDirection;//swipe手势清扫方向
// UIGestureRecognizer
@property(nonatomic,strong)UILongPressGestureRecognizer *longPressGR;//长按手势
@property(nonatomic,strong)UITapGestureRecognizer *tapGR;//点击手势

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
