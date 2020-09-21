//
//  WGradientProgress.h
//  WGradientProgressDemo
//
//  Created by zilin_weng on 15/7/19.
//  Copyright (c) 2015年 Weng-Zilin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WGradientProgressType_colorNormal = 0,//单一色
    WGradientProgressType_colorRoll//色彩在不断的翻滚
} WGradientProgressType;

@interface WGradientProgress : UIView

@property(nonatomic,assign)CGFloat progress;
@property(nonatomic,assign)CGFloat increment;//只能允许 0 ~ 1 范围内 每一单位
@property(nonatomic,assign)BOOL isShowRoad;//是否显示即将运动的轨迹
@property(nonatomic,assign)BOOL isShowFence;//是否显示栅栏
@property(nonatomic,assign)CGFloat fenceLayer_x;//栅栏位置
@property(nonatomic,assign)CGFloat fenceLayer_width;
@property(nonatomic,assign)NSTimeInterval color_timeInterval;//色彩翻滚的频率
@property(nonatomic,assign)NSTimeInterval length_timeInterval;//长度变化的频率
@property(nonatomic,assign)NSTimeInterval length_timeSecIntervalSinceDate;//长度变化的时间延迟
@property(nonatomic,assign)WGradientProgressType progressType;
@property(nonatomic,strong)UIColor *progressColor;

@property(nonatomic,strong)UIColor *fenceLayerColor;//栅栏颜色

-(void)showOnParent;// 启动色彩翻滚
-(void)hide;
///旋转 以适应不同方向的直线型进度条
-(void)setTransformRadians:(CGFloat)transformRadians;
-(void)actionWGradientProgressBlock:(TwoDataBlock)WGradientProgressBlock;

-(void)start;
-(void)pause;
-(void)resume;
-(void)reset;

@end
