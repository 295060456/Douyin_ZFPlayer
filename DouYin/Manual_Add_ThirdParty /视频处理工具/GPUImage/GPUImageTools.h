//
//  GPUImageTools.h
//  Shooting
//
//  Created by Jobs on 2020/8/24.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPUImage.h"
#import "MKGPUImageView.h"

typedef enum : NSUInteger {
    VedioShootType_un = 0,//未定义的
    VedioShootType_on,//开始录制
    VedioShootType_suspend,//暂停录制
    VedioShootType_continue,//继续录制
    VedioShootType_off,//取消录制
    VedioShootType_end//结束录制
} VedioShootType;//视频录制的状态

typedef NS_ENUM(NSInteger, TypeFilter) {
    filterNone,
    filterGaussBlur,
    filterDilation,
    filterBeautify,
    filterGif,
};

NS_ASSUME_NONNULL_BEGIN

//不要用单例，让这个工具类有一个完整的生命周期，里面的属性得以释放
@interface GPUImageTools : NSObject

@property(nonatomic,assign)CGSize videoSize;
@property(nonatomic,assign)TypeFilter typeFilter;
@property(nonatomic,assign)VedioShootType vedioShootType;
@property(nonatomic,strong)MKGPUImageView *GPUImageView;//实际上点击的是它，所以点击事件在 myGPUImageView 的回调里面
@property(nonatomic,strong)GPUImageVideoCamera *videoCamera;
@property(nonatomic,strong)UIImage *thumb;
@property(nonatomic,strong)__block NSString *compressedVedioPathStr;//新生成的,被压缩的视频,这才是最后需要上传到服务器的资源
@property(nonatomic,strong)NSString *recentlyVedioFileUrl;//最近的一段视频资源地址
@property(nonatomic,strong)NSString *FileUrlByTime;//时间戳地址
@property(nonatomic,strong)NSMutableArray *urlArray;//原始的视频素材,路径
@property(nonatomic,copy)MKDataBlock actionVedioToolsClickBlock;
@property(nonatomic,copy)MKDataBlock vedioToolsSessionStatusCompletedBlock;

///GPUImageView的点击事件
-(void)actionVedioToolsClickBlock:(MKDataBlock)actionVedioToolsClickBlock;
///视频合并处理结束
-(void)vedioToolsSessionStatusCompletedBlock:(MKDataBlock)vedioToolsSessionStatusCompletedBlock;

#pragma mark ——实况视频
-(void)LIVE;
#pragma mark —— 开始录制
-(void)vedioShoottingOn;
#pragma mark —— 结束录制
-(void)vedioShoottingEnd;
#pragma mark —— 暂停录制
-(void)vedioShoottingSuspend;
#pragma mark —— 继续录制
-(void)vedioShoottingContinue;
#pragma mark —— 取消录制
-(void)vedioShoottingOff;
#pragma mark —— 翻转摄像头
-(void)overturnCamera;
#pragma mark —— 开启/关闭 闪光灯
-(void)flashLight:(BOOL)turnOn_Off;
#pragma mark —— 获取视频文件的总时长
+(CGFloat)getVedioDuringTimeWithfilePath:(NSString *)filePathStr;
+(CGFloat)getVedioDuringTimeWithUrlAsset:(AVURLAsset *)urlAsset;
#pragma mark —— 视频合并
-(void)mergeAndExportVideos:(NSArray *)videosPathArray
                withOutPath:(NSString *)outpath;
#pragma mark —— 缩略图
-(UIImage *)getImage:(NSString *)videoURL;

@end

NS_ASSUME_NONNULL_END
