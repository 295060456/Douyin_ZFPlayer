//
//  movieCountDown.h
//  Timer
//
//  Created by Jobs on 2020/9/2.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieCountDown : NSObject

@property(nonatomic,weak)UIView *effectView;
@property(nonatomic,strong)UIColor *countDownTextColor;
@property(nonatomic,strong)UIColor *aphViewBackgroundColor;
//倒计时结束回调
-(void)actionMovieCountDownFinishBlock:(MKDataBlock)movieCountDownFinishBlock;
-(void)倒计时放大特效;

@end

NS_ASSUME_NONNULL_END
