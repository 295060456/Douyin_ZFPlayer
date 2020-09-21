//
//  CustomerGPUImagePlayerVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/19.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CustomerGPUImagePlayerVC.h"
#import "MKGPUImageView.h"
#import "GPUImage.h"

@interface CustomerGPUImagePlayerVC ()<GPUImageMovieDelegate>

@property(nonatomic,strong)GPUImageMovie *movie;//负责视频文件的读取 播放
@property(nonatomic,strong)GPUImageFilter *filter;//滤镜
@property(nonatomic,strong)GPUImageToonFilter *toonFilter;
@property(nonatomic,strong)MKGPUImageView *filterView;//负责最终图像的展示 播放视图
@property(nonatomic,strong)GPUImageMovieWriter *writer;//保存

@property(nonatomic,strong)NSURL *AVPlayerURL;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@end

@implementation CustomerGPUImagePlayerVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    CustomerGPUImagePlayerVC *vc = CustomerGPUImagePlayerVC.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
    
    vc.AVPlayerURL = requestParams[@"AVPlayerURL"];
    
    switch (comingStyle) {
        case ComingStyle_PUSH:{
            if (rootVC.navigationController) {
                vc.isPush = YES;
                vc.isPresent = NO;
                [rootVC.navigationController pushViewController:vc
                                                       animated:animated];
            }else{
                vc.isPush = NO;
                vc.isPresent = YES;
                [rootVC presentViewController:vc
                                     animated:animated
                                   completion:^{}];
            }
        }break;
        case ComingStyle_PRESENT:{
            vc.isPush = NO;
            vc.isPresent = YES;
            //iOS_13中modalPresentationStyle的默认改为UIModalPresentationAutomatic,而在之前默认是UIModalPresentationFullScreen
            vc.modalPresentationStyle = presentationStyle;
            [rootVC presentViewController:vc
                                 animated:animated
                               completion:^{}];
        }break;
        default:
            NSLog(@"错误的推进方式");
            break;
    }return vc;
}

-(instancetype)init{
    if (self = [super init]) {

    }return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    NSLog(@"");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self playVideo];
    
    self.gk_navigationBar.hidden = NO;
    if (self.gk_navigationBar.hidden) {
        [self.view bringSubviewToFront:self.gk_navigationBar];
    }
    self.gk_interactivePopDisabled = NO;
    self.gk_fullScreenPopDisabled = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
/**
 播放视频，实时添加滤镜
 */
- (void)playVideo{
    self.filterView.alpha = 1;
    /**
     *  视频处理后输出到 GPUImageView 预览时不支持播放声音，需要自行添加声音播放功能
     *
     *  开始处理并播放...
     */
    [self.movie startProcessing];
}
#pragma mark —— GPUImageMovieDelegate
- (void)didCompletePlayingMovie {
    NSLog(@"播放完成");
}
#pragma mark —— lazyLoad
- (MKGPUImageView *)filterView {
    if (!_filterView) {
        _filterView = MKGPUImageView.new;
        _filterView.frame = CGRectMake(0,
                                       0,
                                       self.view.frame.size.width,
                                       self.view.frame.size.height / 2);
        [self.view addSubview:_filterView];
        [_filterView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(self.view.frame.size.height / 2);
            if (self.gk_navigationBar.hidden) {
                make.top.equalTo(self.view);
            }else{
                make.top.equalTo(self.gk_navigationBar.mas_bottom);
            }
        }];
    }return _filterView;
}

-(GPUImageToonFilter *)toonFilter{
    if (!_toonFilter) {
        _toonFilter = GPUImageToonFilter.new;
        [_toonFilter addTarget:self.filterView];
    }return _toonFilter;
}

-(GPUImageMovie *)movie{
    if (!_movie) {
        _movie = [[GPUImageMovie alloc] initWithURL:[NSURL fileURLWithPath:self.AVPlayerURL.absoluteString]];
        _movie.shouldRepeat = NO;//是否重复播放
        _movie.delegate = self;
        /**
         *  This enables the benchmarking mode, which logs out instantaneous and average frame times to the console
         *
         *  这使当前视频处于基准测试的模式，记录并输出瞬时和平均帧时间到控制台
         *
         *  每隔一段时间打印： Current frame time : 51.256001 ms，直到播放或加滤镜等操作完毕
         */
        _movie.runBenchmark = YES;
        /**
         *  控制GPUImageView预览视频时的速度是否要保持真实的速度。
         *  如果设为NO，则会将视频的所有帧无间隔渲染，导致速度非常快。
         *  设为YES，则会根据视频本身时长计算出每帧的时间间隔，然后每渲染一帧，就sleep一个时间间隔，从而达到正常的播放速度。
         */
        _movie.playAtActualSpeed = YES;
        [_movie addTarget:self.toonFilter];//添加卡通滤镜
    }return _movie;
}




@end
