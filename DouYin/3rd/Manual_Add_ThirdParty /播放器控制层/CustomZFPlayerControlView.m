//
//  ZFPlayerControlView.m
//  Shooting
//
//  Created by Jobs on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CustomZFPlayerControlView.h"

@interface CustomZFPlayerControlView ()

@property(nonatomic,copy)TwoDataBlock customZFPlayerControlViewBlock;
@property(nonatomic,assign)BOOL isOK;
@property(nonatomic,strong)UILabel *tipsLab;

@end

@implementation CustomZFPlayerControlView

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        self.tipsLab.alpha = 1;
        self.isOK = YES;
    }
}

-(void)actionCustomZFPlayerControlViewBlock:(TwoDataBlock _Nullable)customZFPlayerControlViewBlock{
    self.customZFPlayerControlViewBlock = customZFPlayerControlViewBlock;
}

-(void)gestureSingleTapped:(ZFPlayerGestureControl *)gestureControl{
    if (self.customZFPlayerControlViewBlock) {
        self.customZFPlayerControlViewBlock(NSStringFromSelector(_cmd),@1);
    }
}

-(void)gestureDoubleTapped:(ZFPlayerGestureControl *)gestureControl{
    
}
//走一次
-(void)gestureBeganPan:(ZFPlayerGestureControl *)gestureControl
          panDirection:(ZFPanDirection)direction
           panLocation:(ZFPanLocation)location{
    
//    //UITableViewCell自动滚动到顶部
//    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
//                     atScrollPosition:UITableViewScrollPositionTop
//                             animated:YES];

}
//走多次
-(void)gestureChangedPan:(ZFPlayerGestureControl *)gestureControl
            panDirection:(ZFPanDirection)direction
             panLocation:(ZFPanLocation)location
            withVelocity:(CGPoint)velocity{

}
//走一次
-(void)gestureEndedPan:(ZFPlayerGestureControl *)gestureControl
          panDirection:(ZFPanDirection)direction
           panLocation:(ZFPanLocation)location{
    if (self.customZFPlayerControlViewBlock) {
        NSLog(@"%@",NSStringFromSelector(_cmd));
        self.customZFPlayerControlViewBlock(NSStringFromSelector(_cmd),@(gestureControl.panMovingDirection));
    }
}

-(void)gesturePinched:(ZFPlayerGestureControl *)gestureControl
                scale:(float)scale{
    
}
#pragma mark —— lazyLoad
-(UILabel *)tipsLab{
    if (!_tipsLab) {
        _tipsLab = UILabel.new;
        _tipsLab.text = @"自定义控制层子视图";
        _tipsLab.textColor = kRedColor;
        [_tipsLab sizeToFit];
        [self addSubview:_tipsLab];
        [_tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(50);
            make.top.equalTo(self).offset(10);
            make.height.mas_equalTo(150);
        }];
        [UIView cornerCutToCircleWithView:_tipsLab
                          andCornerRadius:3];
        [UIView colourToLayerOfView:_tipsLab
                         withColour:kWhiteColor
                     andBorderWidth:1];
    }return _tipsLab;
}

@end
