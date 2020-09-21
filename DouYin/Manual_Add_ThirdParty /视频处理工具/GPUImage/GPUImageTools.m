//
//  GPUImageTools.m
//  Shooting
//
//  Created by Jobs on 2020/8/24.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "GPUImageTools.h"
#import "YHGPUImageBeautifyFilter.h"

@interface GPUImageTools ()
<GPUImageVideoCameraDelegate>
{
    GPUImageMovieWriter              *movieWriter;
    GPUImageOutput<GPUImageInput>    *filter;
}
//滤镜
@property(nonatomic,strong)GPUImageGaussianBlurFilter *gaussBlurFilter;//高斯
@property(nonatomic,strong)GPUImageDilationFilter *dilationFilter;//灰度
@property(nonatomic,strong)YHGPUImageBeautifyFilter *beautifyFilter;//美颜
@property(nonatomic,strong)GPUImageAlphaBlendFilter *gifFilter;//gif
@property(nonatomic,strong)GPUImageUIElement *uiElement;
@property(nonatomic,strong)UIView *watermarkView;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIImageView *imageV;
@property(nonatomic,strong)GPUImageFilter *videoFilter;
@property(nonatomic,strong)NSArray *arrImage;

@property(nonatomic,strong)NSMutableArray *lastAry;
@property(nonatomic,strong)NSMutableArray *progressViewArray;

@property(nonatomic,copy,nullable)AVFileType outputFileType;
@property(nonatomic,strong)AVAssetTrack *mixVideoTrack;
@property(nonatomic,strong)AVCaptureDevice *captureDevice;
@property(nonatomic,assign)AVCaptureDevicePosition position;
@property(nonatomic,strong)AVMutableCompositionTrack *audioTrack;
@property(nonatomic,strong)AVMutableCompositionTrack *videoTrack;
@property(nonatomic,strong)AVMutableComposition *mixComposition;
@property(nonatomic,strong)AVMutableVideoComposition *videoComp;
@property(nonatomic,strong)AVMutableVideoCompositionInstruction *instruction;
@property(nonatomic,strong)AVMutableVideoCompositionLayerInstruction *layerInstruction;
@property(nonatomic,strong)AVAssetExportSession *exporter;//视频导出工具

@property(nonatomic,strong)AVURLAsset *asset;
@property(nonatomic,strong)AVAssetImageGenerator *gen;
@property(nonatomic,assign)CMTime time;

@property(nonatomic,assign)CGSize movieWriterSize;
@property(nonatomic,strong)NSString *sessionPreset;
@property(nonatomic,strong)NSURL *mergeFileURL;//这个是干嘛的？
@property(nonatomic,assign)BOOL isRecoding;
@property(nonatomic,assign)BOOL isCanReord;

@end

@implementation GPUImageTools

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}
#pragma mark ——实况视频
-(void)LIVE{
    self.position = AVCaptureDevicePositionFront;//使用前置还是后置摄像头
    self.videoCamera.enabled = YES;
    [self.videoCamera startCameraCapture];//全局只有一次
}
#pragma mark —— GPUImageVideoCameraDelegate
//实时每一帧的截取 滚动发出
- (void)willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer{
//    NSLog(@"实时每一帧的截取 滚动发出");
}
#pragma mark —— 开始录制
-(void)vedioShoottingOn{
    self.vedioShootType = VedioShootType_on;
    [self initMovieWriter];
    self.videoCamera.audioEncodingTarget = movieWriter;
    [movieWriter startRecording];
}
#pragma mark —— 结束录制
-(void)vedioShoottingEnd{
    self.vedioShootType = VedioShootType_end;
    [movieWriter finishRecording];//已经写了文件
    self.videoCamera.audioEncodingTarget = nil;
    _FileUrlByTime = nil;//只要一暂停录制，就需要置空，因为是时间戳路径，需要懒加载获取到最新
    // 合成：将音频流和视频流 合在一起，在这个动作之前，不是视频。合成结束并且写文件。
    [MBProgressHUD wj_showPlainText:@"视频合成中......" view:getMainWindow()];
    @weakify(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(.5 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        @strongify(self)
        self.videoSize = self.movieWriterSize;
        NSString *d = [NSString stringWithFormat:@"%@%@",[FileFolderHandleTool directoryAtPath:self.recentlyVedioFileUrl],@"/合成视频的缓存"];
        
        if ([FileFolderHandleTool createFolderByUrl:d error:nil]) {
            
            [self.urlArray addObject:[NSURL fileURLWithPath:self.recentlyVedioFileUrl]];
            self.compressedVedioPathStr = [NSString stringWithFormat:@"%@%@%@",[FileFolderHandleTool directoryAtPath:self.recentlyVedioFileUrl],@"/合成视频的缓存/",[FileFolderHandleTool getFullFileName:self.recentlyVedioFileUrl]];//被压缩的视频文件的路径
            //视频合并
            [self mergeAndExportVideos:self.urlArray//原始数据地址
                           withOutPath:self.compressedVedioPathStr];
            //缩略图
            BOOL s = [FileFolderHandleTool writeFileAtPath:self.recentlyVedioFileUrl
                                                   content:[self getImage:self.recentlyVedioFileUrl]
                                                     error:nil];
            if (s) {
                NSLog(@"保存缩略图成功");
            }else{
                NSAssert(0, @"保存缩略图失败");
            }
        }else{
             NSAssert(0, @"创建文件夹失败,终止movieWriter的创建");
        }
    });
}
#pragma mark —— 暂停录制
-(void)vedioShoottingSuspend{
    self.vedioShootType = VedioShootType_suspend;
    if (!movieWriter.isPaused) {
        movieWriter.paused = YES;
    }
}
#pragma mark —— 继续录制
-(void)vedioShoottingContinue{
    self.vedioShootType = VedioShootType_continue;
    if (movieWriter.isPaused) {
        movieWriter.paused = NO;
    }
}
#pragma mark —— 取消录制
-(void)vedioShoottingOff{
    self.vedioShootType = VedioShootType_off;
    [movieWriter finishRecording];
    self.videoCamera.audioEncodingTarget = nil;
    _FileUrlByTime = nil;//只要一暂停录制，就需要置空，因为是时间戳路径，需要懒加载获取到最新
    movieWriter = nil;
}
#pragma mark —— 翻转摄像头
-(void)overturnCamera{
    switch (self.position) {
        case AVCaptureDevicePositionBack: {
            if (self.videoCamera.cameraPosition == AVCaptureDevicePositionBack) {
                [self.videoCamera pauseCameraCapture];
                self.position = AVCaptureDevicePositionFront;
            }
        }
            break;
        case AVCaptureDevicePositionFront: {
            if (self.videoCamera.cameraPosition == AVCaptureDevicePositionFront) {
                [self.videoCamera pauseCameraCapture];
                self.position = AVCaptureDevicePositionBack;
            }
        }
            break;
        default:
            break;
    }
    
    [self.videoCamera rotateCamera];
    [self.videoCamera resumeCameraCapture];
    
    if ([self.videoCamera.inputCamera lockForConfiguration:nil] &&
        [self.videoCamera.inputCamera isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
        [self.videoCamera.inputCamera setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
        [self.videoCamera.inputCamera unlockForConfiguration];
    }
}
#pragma mark —— 开启/关闭 闪光灯
-(void)flashLight:(BOOL)turnOn_Off{
    if (turnOn_Off) {
        if (self.captureDevice.hasTorch) {
            if ([self.captureDevice lockForConfiguration:nil]) {
                self.captureDevice.torchMode = AVCaptureTorchModeOn;
                [self.captureDevice unlockForConfiguration];
            }
        }
    }else{
        if (self.captureDevice.hasTorch) {
            [self.captureDevice lockForConfiguration:nil];
            [self.captureDevice setTorchMode: AVCaptureTorchModeOff];
            [self.captureDevice unlockForConfiguration];
        }
    }
}
#pragma mark —— 缩略图
-(UIImage *)getImage:(NSString *)videoURL{

    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [self.gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    self.thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return self.thumb;
}
#pragma mark —— 获取视频文件的总时长
+(CGFloat)getVedioDuringTimeWithfilePath:(NSString *)filePathStr{
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePathStr];
    AVURLAsset *sourceAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    CMTime duration = sourceAsset.duration;
    CGFloat second = (float)duration.value / (float)duration.timescale;
    return second;
}

+(CGFloat)getVedioDuringTimeWithUrlAsset:(AVURLAsset *)urlAsset{
    CMTime duration = urlAsset.duration;
    CGFloat second = (float)duration.value / (float)duration.timescale;
    return second;
}
#pragma mark —— 视频合并
/// 压缩和合并视频
/// @param videosPathArray 原始数据地址
/// @param outpath 压缩成品的地址
-(void)mergeAndExportVideos:(NSArray *)videosPathArray
                withOutPath:(NSString *)outpath{
    if (videosPathArray.count == 0) {
        [MBProgressHUD wj_showPlainText:@"没有可处理视频文件！"
                                   view:getMainWindow()];
        return;
    }
    //创建音频通道容器
    self.audioTrack.enabled = YES;
    //创建视频通道容器
    self.videoTrack.enabled = YES;

    CMTime totalDuration = kCMTimeZero;
    for (int i = 0; i < videosPathArray.count; i++) {
        NSDictionary* options = @{AVURLAssetPreferPreciseDurationAndTimingKey:@YES};
        AVAsset* asset = [AVURLAsset URLAssetWithURL:videosPathArray[i] options:options];

        NSError *erroraudio = nil;
        //获取AVAsset中的音频 或者视频
        AVAssetTrack *assetAudioTrack = [[asset tracksWithMediaType:AVMediaTypeAudio] firstObject];
        //向通道内加入音频或者视频
        BOOL ba = [self.audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                                      ofTrack:assetAudioTrack
                                       atTime:totalDuration
                                        error:&erroraudio];

        NSLog(@"erroraudio:%@%d",erroraudio,ba);
        NSError *errorVideo = nil;
        AVAssetTrack *assetVideoTrack = [[asset tracksWithMediaType:AVMediaTypeVideo]firstObject];
        BOOL bl = [self.videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                                           ofTrack:assetVideoTrack
                                            atTime:totalDuration
                                             error:&errorVideo];

        NSLog(@"errorVideo:%@%d",errorVideo,bl);
        totalDuration = CMTimeAdd(totalDuration, asset.duration);
    }
    self.mergeFileURL = [NSURL fileURLWithPath:outpath];
    @weakify(self)
    [self.exporter exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            [MBProgressHUD wj_showPlainText:@"处理完毕...."
                                       view:getMainWindow()];
            switch (self.exporter.status) {
                case AVAssetExportSessionStatusFailed:{
                    NSLog(@"Export failed: %@", [[self.exporter error] localizedDescription]);
                } break;
                case AVAssetExportSessionStatusCancelled:{
                    NSLog(@"Export canceled");
                } break;
                case AVAssetExportSessionStatusCompleted:{
                    NSLog(@"转换成功");
                    [self delRaw];//转换视频成功删除原始视频素材
                    [FileFolderHandleTool createAlbumFolder:HDAppDisplayName
                                                       path:self.compressedVedioPathStr];//存系统相册
                    //处理完毕的回调
                    if (self.vedioToolsSessionStatusCompletedBlock) {
                        self.vedioToolsSessionStatusCompletedBlock(self);
                    }
                } break;
                default:
                    break;
            }
        });
    }];
}
///添加滤镜
- (void)addFilter{
    self.gaussBlurFilter.enabled = YES;//高斯
    self.dilationFilter.enabled = YES;//灰度
    self.beautifyFilter.enabled = YES;//美颜
    self.gifFilter.enabled = YES;//gif
    self.watermarkView.alpha = 1;
    __block NSInteger imageIndex = 0;
    __block GPUImageUIElement *weakElement = self.uiElement;
    __block NSInteger timeCount = 0;
    @weakify(self)
    [self.videoFilter setFrameProcessingCompletionBlock:^(GPUImageOutput *output,
                                                          CMTime time) {
        @strongify(self)
        NSInteger tempCount = time.value / (time.timescale/1000);
        if (tempCount - timeCount > 100) {
            imageIndex ++;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageV.image = self.arrImage[imageIndex];
            });
            if (imageIndex == self.arrImage.count -1) {
                imageIndex = 0;
            }
            timeCount = tempCount;
        }
        [weakElement update];
    }];
}
///转换视频成功删除原始视频素材
-(void)delRaw{
    //原始的视频素材，路径 self.urlArray
    //新生成的，被压缩的视频 self.compressedVedioPathStr 这才是最后需要上传到服务器的资源
    NSURL *url = self.urlArray[0];
    BOOL d = [NSString isNullString:url.absoluteString];
    if (!d) {
        [FileFolderHandleTool delFile:@[url.absoluteString]
                           fileSuffix:@"mp4"];//删除文件夹📂路径下的文件
    }
}
///videoCamera的点击事件
-(void)actionVedioToolsClickBlock:(MKDataBlock)actionVedioToolsClickBlock{
    self.actionVedioToolsClickBlock = actionVedioToolsClickBlock;
}
///视频合并处理结束
-(void)vedioToolsSessionStatusCompletedBlock:(MKDataBlock)vedioToolsSessionStatusCompletedBlock{
    self.vedioToolsSessionStatusCompletedBlock = vedioToolsSessionStatusCompletedBlock;
}
#pragma mark —— lazyLoad
-(CGSize)movieWriterSize{
    if ([self.sessionPreset isEqualToString:AVCaptureSessionPreset352x288]){
        return CGSizeMake(288.0, 352.0);
    }else if ([self.sessionPreset isEqualToString:AVCaptureSessionPreset640x480]){
        return CGSizeMake(480.0, 640.0);
    }else if ([self.sessionPreset isEqualToString:AVCaptureSessionPreset1280x720]){
        return CGSizeMake(720.0, 1280.0);
    }else if ([self.sessionPreset isEqualToString:AVCaptureSessionPreset1920x1080]){
        return CGSizeMake(1080.0, 1920.0);
    }else if ([self.sessionPreset isEqualToString:AVCaptureSessionPreset3840x2160]){
        return CGSizeMake(2160.0, 3840);
    }else if ([self.sessionPreset isEqualToString:AVCaptureSessionPresetiFrame960x540]){
        return CGSizeMake(540.0, 960.0);
    }else if ([self.sessionPreset isEqualToString:AVCaptureSessionPresetiFrame1280x720]){
        return CGSizeMake(720.0, 1280.0);
    }
///以下这两款 is unavailable: not available on iOS
//    else if ([self.sessionPreset isEqualToString:AVCaptureSessionPreset960x540]){
//        return CGSizeMake(540.0, 960.0);
//    }else if ([self.sessionPreset isEqualToString:AVCaptureSessionPreset320x240]) {
//        return CGSizeMake(240.0, 320.0);
//    }
    else{
        return CGSizeZero;
    }return CGSizeZero;
}

-(CGSize)videoSize{
//    return self.videoTrack.naturalSize;
    if (CGSizeEqualToSize(_videoSize,CGSizeZero)) {
        NSLog(@"外层未设置videoSize，走的是默认的Size");
        _videoSize = CGSizeMake(720.0, 1280.0);
    }return _videoSize;
}

-(NSString *)sessionPreset{
    if ([NSString isNullString:_sessionPreset]) {
        _sessionPreset = AVCaptureSessionPreset1280x720;//默认值
    }return _sessionPreset;
}

-(GPUImageVideoCamera *)videoCamera{
    if (!_videoCamera) {
        _videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:self.sessionPreset
                                                                    cameraPosition:self.position];//使用前置还是后置摄像头
        _videoCamera.delegate = self;

        if ([_videoCamera.inputCamera lockForConfiguration:nil]) {
            //自动对焦
            if ([_videoCamera.inputCamera isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
                [_videoCamera.inputCamera setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
            }
            //自动曝光
            if ([_videoCamera.inputCamera isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
                [_videoCamera.inputCamera setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
            }
            //自动白平衡
            if ([_videoCamera.inputCamera isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance]) {
                [_videoCamera.inputCamera setWhiteBalanceMode:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance];
            }
            [_videoCamera.inputCamera unlockForConfiguration];
        }
        
        _videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
        [_videoCamera addAudioInputsAndOutputs];
        _videoCamera.horizontallyMirrorFrontFacingCamera = YES;
        _videoCamera.horizontallyMirrorRearFacingCamera = NO;
        [_videoCamera addTarget:self.GPUImageView];
        
    }return _videoCamera;
}

-(MKGPUImageView *)GPUImageView{
    if (!_GPUImageView) {
        _GPUImageView = [[MKGPUImageView alloc] initWithFrame:getMainWindow().bounds];
        _GPUImageView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;//kGPUImageFillModePreserveAspectRatioAndFill;
        @weakify(self)
//         点击事件回调
        [_GPUImageView actionMKGPUImageViewBlock:^(id data) {
            @strongify(self)
            if (self.actionVedioToolsClickBlock) {
                self.actionVedioToolsClickBlock(self->_GPUImageView);
            }
        }];
        [self.videoCamera addTarget:_GPUImageView];
        [self addFilter];//添加滤镜
    }return _GPUImageView;
}

-(NSString *)recentlyVedioFileUrl{
    if (!_recentlyVedioFileUrl) {
        _recentlyVedioFileUrl = self.FileUrlByTime;
    }return _recentlyVedioFileUrl;
}
/// 以当前时间戳生成缓存路径 Library/Caches
-(NSString *)FileUrlByTime{//每时每刻都在变的，因为是时间戳路径
    if (!_FileUrlByTime) {
        // 在临时文件夹储存视频文件
        
        /*** 文件夹 用FileFolderHandleTool调
         
         沙盒的主目录：homeDir，
         沙盒中Documents：documentsDir，
         沙盒中Library：libraryDir，
         沙盒中Libarary/Preferences的目录：preferencesDir
         沙盒中Library/Caches的目录：cachesDir，
         沙盒中tmp的目录：tmpDir
         
         */
        _FileUrlByTime = [FileFolderHandleTool createCacheFolderPath:@"vedio" fileEx:@".mp4"];//Library/Caches/vedio/时间戳.MP4
    }return _FileUrlByTime;
}

- (void)initMovieWriter{
    if ([FileFolderHandleTool createFileByUrl:self.recentlyVedioFileUrl error:nil]) {
        movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:[NSURL fileURLWithPath:self.recentlyVedioFileUrl]
                                                               size:self.movieWriterSize];
        movieWriter.encodingLiveVideo = YES;
        movieWriter.shouldPassthroughAudio = YES;
        [self.videoCamera addTarget:movieWriter];
    }else{
        movieWriter = nil;
        NSAssert(movieWriter, @"创建文件夹失败,终止movieWriter的创建");
    }
}

- (void)setTypeFilter:(TypeFilter)typeFilter{
    _typeFilter = typeFilter;
    [self.videoCamera removeAllTargets];
    switch (typeFilter) {
        case filterNone:{
            if (movieWriter) {
                [self.videoCamera addTarget:movieWriter];
            }
            [self.videoCamera addTarget:self.GPUImageView];
        }break;
        case filterDilation:{
            [self.videoCamera addTarget:self.dilationFilter];
            if (movieWriter) {
                [self.dilationFilter addTarget:movieWriter];
            }
            [self.dilationFilter addTarget:self.GPUImageView];
        }break;
        case filterGif:{
            [self.videoCamera addTarget:self.videoFilter];
            //由于GPUImageAlphaBlendFilter 不能直接以videoCamera为输入源中间以videoFilter桥接一下
            [self.videoFilter addTarget:self.gifFilter];
            if (movieWriter) {
                [self.gifFilter addTarget:movieWriter];
            }
            [self.gifFilter addTarget:self.GPUImageView];
        }break;
        case filterBeautify:{
            [self.videoCamera addTarget:self.beautifyFilter];
            if (movieWriter) {
                [self.beautifyFilter addTarget:movieWriter];
            }
            [self.beautifyFilter addTarget:self.GPUImageView];
        }break;
        case filterGaussBlur:{
            [self.videoCamera addTarget:self.gaussBlurFilter];
            if (movieWriter) {
                [self.gaussBlurFilter addTarget:movieWriter];
            }
            [self.gaussBlurFilter addTarget:self.GPUImageView];
        }break;
        default:
            break;
    }
}

-(NSMutableArray<NSURL *> *)urlArray{
    if (!_urlArray) {
        _urlArray = NSMutableArray.array;
    }return _urlArray;
}

-(AVMutableCompositionTrack *)audioTrack{
    if (!_audioTrack) {
        _audioTrack = [self.mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    }return _audioTrack;
}

-(AVAssetTrack *)mixVideoTrack{
    if (!_mixVideoTrack) {
        _mixVideoTrack = [[self.mixComposition tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    }return _mixVideoTrack;
}

-(AVMutableCompositionTrack *)videoTrack{
    if (!_videoTrack) {
        _videoTrack = [self.mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    }return _videoTrack;
}

-(AVMutableComposition *)mixComposition{
    if (!_mixComposition) {
        //音频视频合成体
        _mixComposition = AVMutableComposition.new;
    }return _mixComposition;
}

-(AVMutableVideoCompositionLayerInstruction *)layerInstruction{
    if (!_layerInstruction) {
        _layerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:self.mixVideoTrack];
    }return _layerInstruction;
}

-(AVAssetExportSession *)exporter{
    if (!_exporter) {
        _exporter = [[AVAssetExportSession alloc] initWithAsset:self.mixComposition
                                                     presetName:AVAssetExportPresetMediumQuality];
        _exporter.videoComposition = self.videoComp;
        /*
         exporter.progress
         导出进度
         This property is not key-value observable.
         不支持kvo 监听
         只能用定时器监听了  NStimer
         */
        
        _exporter.outputURL = self.mergeFileURL;
        _exporter.outputFileType = self.outputFileType;//视频分辨率设置
        _exporter.shouldOptimizeForNetworkUse = YES;
    }return _exporter;
}
///视频分辨率设置
-(AVFileType)outputFileType{
    if ([NSString isNullString:_outputFileType]) {
        _outputFileType = AVFileTypeMPEG4;//默认MP4格式
    }return _outputFileType;
}

-(AVMutableVideoCompositionInstruction *)instruction{
    if (!_instruction) {
        _instruction = AVMutableVideoCompositionInstruction.videoCompositionInstruction;
        _instruction.timeRange = CMTimeRangeMake(kCMTimeZero, self.mixComposition.duration);
        _instruction.layerInstructions = [NSArray arrayWithObject:self.layerInstruction];
    }return _instruction;
}

-(AVMutableVideoComposition *)videoComp{
    if (!_videoComp) {
        _videoComp = AVMutableVideoComposition.videoComposition;
        _videoComp.renderSize = self.videoSize;
        _videoComp.frameDuration = CMTimeMake(1, 30);
        _videoComp.instructions = [NSArray arrayWithObject: self.instruction];
    }return _videoComp;
}

-(AVAssetImageGenerator *)gen{
    if (!_gen) {
        _gen = [[AVAssetImageGenerator alloc] initWithAsset:self.asset];
        _gen.appliesPreferredTrackTransform = YES;
    }return _gen;
}

-(AVURLAsset *)asset{
    if (!_asset) {
        _asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:self.recentlyVedioFileUrl] options:nil];
    }return _asset;
}

-(AVCaptureDevice *)captureDevice{
    if (!_captureDevice) {
        _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }return _captureDevice;
}

//滤镜
-(GPUImageGaussianBlurFilter *)gaussBlurFilter{
    if (!_gaussBlurFilter) {
        _gaussBlurFilter = GPUImageGaussianBlurFilter.new;
        _gaussBlurFilter.texelSpacingMultiplier = 4;
        _gaussBlurFilter.blurRadiusInPixels = 5;
    }return _gaussBlurFilter;
}

-(GPUImageDilationFilter *)dilationFilter{
    if (!_dilationFilter) {
        _dilationFilter = [[GPUImageDilationFilter alloc] initWithRadius:3];
    }return _dilationFilter;
}

-(YHGPUImageBeautifyFilter *)beautifyFilter{
    if (!_beautifyFilter) {
        _beautifyFilter = YHGPUImageBeautifyFilter.new;
    }return _beautifyFilter;
}

-(GPUImageAlphaBlendFilter *)gifFilter{
    if (!_gifFilter) {
        _gifFilter = GPUImageAlphaBlendFilter.new;
        _gifFilter.mix = 0.8;
    }return _gifFilter;
}

-(GPUImageUIElement *)uiElement{
    if (!_uiElement) {
        _uiElement = [[GPUImageUIElement alloc] initWithView:self.watermarkView];
        [_uiElement addTarget:self.gifFilter];
    }return _uiElement;
}

-(UIView *)watermarkView{
    if (!_watermarkView) {
        _watermarkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 380)];
        [_watermarkView addSubview:self.imageV];
        [_watermarkView addSubview:self.label];
    }return _watermarkView;
}

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        _label.text = @"Record";
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    }return _label;
}

-(UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(80, 0, 100, 80)];
        _imageV.image = self.arrImage[0];
    }return _imageV;
}

-(NSArray *)arrImage{
    if (!_arrImage) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"视频水印.gif" ofType:nil];
        NSData *imageData = [NSData dataWithContentsOfFile:path];
        _arrImage = [NSObject changeGifToImage:imageData];
    }return _arrImage;
}

-(GPUImageFilter *)videoFilter{
    if (!_videoFilter) {
        _videoFilter = GPUImageFilter.new;
        [_videoFilter addTarget:self.gifFilter];
    }return _videoFilter;
}


@end
