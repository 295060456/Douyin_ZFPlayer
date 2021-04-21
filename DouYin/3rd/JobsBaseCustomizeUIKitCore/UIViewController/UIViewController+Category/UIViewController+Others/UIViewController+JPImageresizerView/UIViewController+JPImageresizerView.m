//
//  UIViewController+JPImageresizerView.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "UIViewController+JPImageresizerView.h"
#import <objc/runtime.h>

@implementation UIViewController (JPImageresizerView)

static char *BaseVC_JPImageresizerView_configure = "BaseVC_JPImageresizerView_configure";
static char *BaseVC_JPImageresizerView_imageresizerView = "BaseVC_JPImageresizerView_imageresizerView";
static char *BaseVC_JPImageresizerView_configureType = "BaseVC_JPImageresizerView_configureType";
static char *BaseVC_JPImageresizerView_JPImageresizerView_data = "BaseVC_JPImageresizerView_JPImageresizerView_data";
static char *BaseVC_JPImageresizerView_JPImageresizerView_img = "BaseVC_JPImageresizerView_JPImageresizerView_img";
static char *BaseVC_JPImageresizerView_JPImageresizerView_url = "BaseVC_JPImageresizerView_JPImageresizerView_url";
static char *BaseVC_JPImageresizerView_JPImageresizerView_avURLAsset = "BaseVC_JPImageresizerView_JPImageresizerView_avURLAsset";
static char *BaseVC_JPImageresizerView_makeBlock = "BaseVC_JPImageresizerView_makeBlock";
static char *BaseVC_JPImageresizerView_fixErrorBlock = "BaseVC_JPImageresizerView_fixErrorBlock";
static char *BaseVC_JPImageresizerView_fixStartBlock = "BaseVC_JPImageresizerView_fixStartBlock";
static char *BaseVC_JPImageresizerView_fixProgressBlock = "BaseVC_JPImageresizerView_fixProgressBlock";
static char *BaseVC_JPImageresizerView_fixCompleteBlock = "BaseVC_JPImageresizerView_fixCompleteBlock";

@dynamic configure;
@dynamic imageresizerView;
@dynamic configureType;
@dynamic JPImageresizerView_data;
@dynamic JPImageresizerView_img;
@dynamic JPImageresizerView_url;
@dynamic JPImageresizerView_avURLAsset;
@dynamic makeBlock;
@dynamic fixErrorBlock;
@dynamic fixStartBlock;
@dynamic fixProgressBlock;
@dynamic fixCompleteBlock;

#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong)JPImageresizerConfigure *configure;
-(JPImageresizerConfigure *)configure{
    JPImageresizerConfigure *Configure = objc_getAssociatedObject(self, BaseVC_JPImageresizerView_configure);
    if (!Configure) {
        switch (self.configureType) {
            case JPImageresizerConfigureType_1:{//默认配置裁剪图片/GIF（UIImage）
                Configure = [JPImageresizerConfigure defaultConfigureWithImage:self.JPImageresizerView_img
                                                                          make:^(JPImageresizerConfigure *configure) {
                    if (self.makeBlock) {
                        self.makeBlock(@1);
                    }
                }];
            } break;
            case JPImageresizerConfigureType_2:{//默认配置裁剪图片/GIF（NSData）
                Configure = [JPImageresizerConfigure defaultConfigureWithImageData:self.JPImageresizerView_data
                                                                              make:^(JPImageresizerConfigure *configure) {
                    if (self.makeBlock) {
                        self.makeBlock(@1);
                    }
                }];
            } break;
            case JPImageresizerConfigureType_3:{//默认配置裁剪视频（NSURL）
                Configure = [JPImageresizerConfigure defaultConfigureWithVideoURL:self.JPImageresizerView_url
                                                                             make:^(JPImageresizerConfigure *configure) {
                    if (self.makeBlock) {
                        self.makeBlock(@1);
                    }
                }
                                                                    fixErrorBlock:^(NSURL *cacheURL, JPImageresizerErrorReason reason) {
                    if (self.fixErrorBlock) {
                        self.fixErrorBlock(@1);
                    }
                }
                                                                    fixStartBlock:^{
                    if (self.fixStartBlock) {
                        self.fixStartBlock(@1);
                    }
                }
                                                                 fixProgressBlock:^(float progress) {
                    if (self.fixProgressBlock) {
                        self.fixProgressBlock(@1);
                    }
                }
                                                                 fixCompleteBlock:^(NSURL *cacheURL) {
                    if (self.fixCompleteBlock) {
                        self.fixCompleteBlock(@1);
                    }
                }];
            } break;
            case JPImageresizerConfigureType_4:{//默认配置裁剪视频（AVURLAsset）
                Configure = [JPImageresizerConfigure defaultConfigureWithVideoAsset:self.JPImageresizerView_avURLAsset
                                                                               make:^(JPImageresizerConfigure *configure) {
                    if (self.makeBlock) {
                        self.makeBlock(@1);
                    }
                }
                                                                      fixErrorBlock:^(NSURL *cacheURL, JPImageresizerErrorReason reason) {
                    if (self.fixErrorBlock) {
                        self.fixErrorBlock(@1);
                    }
                }
                                                                      fixStartBlock:^{
                    if (self.fixStartBlock) {
                        self.fixStartBlock(@1);
                    }
                }
                                                                   fixProgressBlock:^(float progress) {
                    if (self.fixProgressBlock) {
                        self.fixProgressBlock(@1);
                    }
                }
                                                                   fixCompleteBlock:^(NSURL *cacheURL) {
                    if (self.fixCompleteBlock) {
                        self.fixCompleteBlock(@1);
                    }
                }];
            } break;
            case JPImageresizerConfigureType_5:{//浅色毛玻璃配置裁剪图片/GIF（UIImage）
                Configure = [JPImageresizerConfigure lightBlurMaskTypeConfigureWithImage:self.JPImageresizerView_img
                                                                                    make:^(JPImageresizerConfigure *configure) {
                    if (self.makeBlock) {
                        self.makeBlock(@1);
                    }
                }];
            } break;
            case JPImageresizerConfigureType_6:{//浅色毛玻璃配置裁剪图片/GIF（NSData）
                Configure = [JPImageresizerConfigure lightBlurMaskTypeConfigureWithImageData:self.JPImageresizerView_data
                                                                                        make:^(JPImageresizerConfigure *configure) {
                    if (self.makeBlock) {
                        self.makeBlock(@1);
                    }
                }];
            } break;
            case JPImageresizerConfigureType_7:{//浅色毛玻璃配置裁剪视频（NSURL）
                Configure = [JPImageresizerConfigure lightBlurMaskTypeConfigureWithVideoURL:self.JPImageresizerView_url
                                                                                       make:^(JPImageresizerConfigure *configure) {
                    if (self.makeBlock) {
                        self.makeBlock(@1);
                    }
                }
                                                                              fixErrorBlock:^(NSURL *cacheURL, JPImageresizerErrorReason reason) {
                    if (self.fixErrorBlock) {
                        self.fixErrorBlock(@1);
                    }
                }
                                                                              fixStartBlock:^{
                    if (self.fixStartBlock) {
                        self.fixStartBlock(@1);
                    }
                }
                                                                           fixProgressBlock:^(float progress) {
                    if (self.fixProgressBlock) {
                        self.fixProgressBlock(@1);
                    }
                }
                                                                           fixCompleteBlock:^(NSURL *cacheURL) {
                    if (self.fixCompleteBlock) {
                        self.fixCompleteBlock(@1);
                    }
                }];
            } break;
            case JPImageresizerConfigureType_8:{//浅色毛玻璃配置裁剪视频（AVURLAsset）
                Configure = [JPImageresizerConfigure lightBlurMaskTypeConfigureWithVideoAsset:self.JPImageresizerView_avURLAsset
                                                                                         make:^(JPImageresizerConfigure *configure) {
                    if (self.makeBlock) {
                        self.makeBlock(@1);
                    }
                }
                                                                                fixErrorBlock:^(NSURL *cacheURL, JPImageresizerErrorReason reason) {
                    if (self.fixErrorBlock) {
                        self.fixErrorBlock(@1);
                    }
                }
                                                                                fixStartBlock:^{
                    if (self.fixStartBlock) {
                        self.fixStartBlock(@1);
                    }
                }
                                                                             fixProgressBlock:^(float progress) {
                    if (self.fixProgressBlock) {
                        self.fixProgressBlock(@1);
                    }
                }
                                                                             fixCompleteBlock:^(NSURL *cacheURL) {
                    if (self.fixCompleteBlock) {
                        self.fixCompleteBlock(@1);
                    }
                }];
            } break;
            case JPImageresizerConfigureType_9:{//深色毛玻璃配置裁剪图片/GIF（UIImage）
                Configure = [JPImageresizerConfigure darkBlurMaskTypeConfigureWithImage:self.JPImageresizerView_img
                                                                                   make:^(JPImageresizerConfigure *configure) {
                    if (self.makeBlock) {
                        self.makeBlock(@1);
                    }
                }];
            } break;
            case JPImageresizerConfigureType_10:{//深色毛玻璃配置裁剪图片/GIF（NSData）
                Configure = [JPImageresizerConfigure darkBlurMaskTypeConfigureWithImageData:self.JPImageresizerView_data
                                                                                       make:^(JPImageresizerConfigure *configure) {
                    if (self.makeBlock) {
                        self.makeBlock(@1);
                    }
                }];
            } break;
            case JPImageresizerConfigureType_11:{//深色毛玻璃配置裁剪视频（NSURL）
                Configure = [JPImageresizerConfigure darkBlurMaskTypeConfigureWithVideoURL:self.JPImageresizerView_url
                                                                                      make:^(JPImageresizerConfigure *configure) {
                    if (self.makeBlock) {
                        self.makeBlock(@1);
                    }
                }
                                                                             fixErrorBlock:^(NSURL *cacheURL, JPImageresizerErrorReason reason) {
                    if (self.fixErrorBlock) {
                        self.fixErrorBlock(@1);
                    }
                }
                                                                             fixStartBlock:^{
                    if (self.fixStartBlock) {
                        self.fixStartBlock(@1);
                    }
                }
                                                                          fixProgressBlock:^(float progress) {
                    if (self.fixProgressBlock) {
                        self.fixProgressBlock(@1);
                    }
                }
                                                                          fixCompleteBlock:^(NSURL *cacheURL) {
                    if (self.fixCompleteBlock) {
                        self.fixCompleteBlock(@1);
                    }
                }];
            } break;
            case JPImageresizerConfigureType_12:{//深色毛玻璃配置裁剪视频（AVURLAsset）
                Configure = [JPImageresizerConfigure darkBlurMaskTypeConfigureWithVideoAsset:self.JPImageresizerView_avURLAsset
                                                                                        make:^(JPImageresizerConfigure *configure) {
                    if (self.makeBlock) {
                        self.makeBlock(@1);
                    }
                }
                                                                               fixErrorBlock:^(NSURL *cacheURL, JPImageresizerErrorReason reason) {
                    if (self.fixErrorBlock) {
                        self.fixErrorBlock(@1);
                    }
                }
                                                                               fixStartBlock:^{
                    if (self.fixStartBlock) {
                        self.fixStartBlock(@1);
                    }
                }
                                                                            fixProgressBlock:^(float progress) {
                    if (self.fixProgressBlock) {
                        self.fixProgressBlock(@1);
                    }
                }
                                                                            fixCompleteBlock:^(NSURL *cacheURL) {
                    if (self.fixCompleteBlock) {
                        self.fixCompleteBlock(@1);
                    }
                }];
            } break;
            default:
                NSAssert(Configure,@"alertController 创建出现错误");
                break;
        }
    }return Configure;
}

-(void)setConfigure:(JPImageresizerConfigure *)configure{
    objc_setAssociatedObject(self,
                             BaseVC_JPImageresizerView_configure,
                             configure,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)JPImageresizerView *imageresizerView;
-(JPImageresizerView *)imageresizerView{
    JPImageresizerView *ImageresizerView = objc_getAssociatedObject(self, BaseVC_JPImageresizerView_imageresizerView);
    if (!ImageresizerView) {
//        @weakify(self)
        ImageresizerView = [JPImageresizerView imageresizerViewWithConfigure:self.configure
                                                                       imageresizerIsCanRecovery:^(BOOL isCanRecovery) {
//            @strongify(self)
        } imageresizerIsPrepareToScale:^(BOOL isPrepareToScale) {
//            @strongify(self)
        }];
    }return ImageresizerView;
}

-(void)setImageresizerView:(JPImageresizerView *)imageresizerView{
    objc_setAssociatedObject(self,
                             BaseVC_JPImageresizerView_imageresizerView,
                             imageresizerView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)JPImageresizerConfigureType *configureType;
-(JPImageresizerConfigureType)configureType{
    JPImageresizerConfigureType configureType = [objc_getAssociatedObject(self, BaseVC_JPImageresizerView_configureType) integerValue];
    return configureType;
}

-(void)setConfigureType:(JPImageresizerConfigureType)configureType{
    objc_setAssociatedObject(self,
                             BaseVC_JPImageresizerView_configureType,
                             [NSNumber numberWithInteger:configureType],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSData *JPImageresizerView_data;
-(NSData *)JPImageresizerView_data{
    NSData *data = objc_getAssociatedObject(self, BaseVC_JPImageresizerView_JPImageresizerView_data);
    return data;
}

-(void)setJPImageresizerView_data:(NSData *)JPImageresizerView_data{
    objc_setAssociatedObject(self,
                             BaseVC_JPImageresizerView_JPImageresizerView_data,
                             JPImageresizerView_data,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark ——@property(nonatomic,strong)UIImage *JPImageresizerView_img; BaseVC_JPImageresizerView_JPImageresizerView_img
-(UIImage *)JPImageresizerView_img{
    UIImage *img = objc_getAssociatedObject(self, BaseVC_JPImageresizerView_JPImageresizerView_img);
    return img;
}

-(void)setJPImageresizerView_img:(UIImage *)JPImageresizerView_img{
    objc_setAssociatedObject(self,
                             BaseVC_JPImageresizerView_JPImageresizerView_img,
                             JPImageresizerView_img,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSURL *JPImageresizerView_url; BaseVC_JPImageresizerView_JPImageresizerView_url
-(NSURL *)JPImageresizerView_url{
    NSURL *url = objc_getAssociatedObject(self, BaseVC_JPImageresizerView_JPImageresizerView_url);
    return url;
}

-(void)setJPImageresizerView_url:(NSURL *)JPImageresizerView_url{
    objc_setAssociatedObject(self,
                             BaseVC_JPImageresizerView_JPImageresizerView_url,
                             JPImageresizerView_url,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)AVURLAsset *JPImageresizerView_avURLAsset; BaseVC_JPImageresizerView_JPImageresizerView_avURLAsset
-(AVURLAsset *)JPImageresizerView_avURLAsset{
    AVURLAsset *urlAsset = objc_getAssociatedObject(self, BaseVC_JPImageresizerView_JPImageresizerView_avURLAsset);
    return urlAsset;
}

-(void)setJPImageresizerView_avURLAsset:(AVURLAsset *)JPImageresizerView_avURLAsset{
    objc_setAssociatedObject(self,
                             BaseVC_JPImageresizerView_JPImageresizerView_avURLAsset,
                             JPImageresizerView_avURLAsset,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,copy)MKDataBlock makeBlock;
-(MKDataBlock)makeBlock{
    return objc_getAssociatedObject(self, BaseVC_JPImageresizerView_makeBlock);
}

-(void)setMakeBlock:(MKDataBlock)makeBlock{
    objc_setAssociatedObject(self,
                             BaseVC_JPImageresizerView_makeBlock,
                             makeBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,copy)MKDataBlock fixErrorBlock;
-(MKDataBlock)fixErrorBlock{
    return objc_getAssociatedObject(self, BaseVC_JPImageresizerView_fixErrorBlock);
}

-(void)setFixErrorBlock:(MKDataBlock)fixErrorBlock{
    objc_setAssociatedObject(self,
                             BaseVC_JPImageresizerView_fixErrorBlock,
                             fixErrorBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,copy)MKDataBlock fixStartBlock;
-(MKDataBlock)fixStartBlock{
    return objc_getAssociatedObject(self, BaseVC_JPImageresizerView_fixStartBlock);
}

-(void)setFixStartBlock:(MKDataBlock)fixStartBlock{
    objc_setAssociatedObject(self,
                             BaseVC_JPImageresizerView_fixStartBlock,
                             fixStartBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,copy)MKDataBlock fixProgressBlock;
-(MKDataBlock)fixProgressBlock{
    return objc_getAssociatedObject(self, BaseVC_JPImageresizerView_fixProgressBlock);
}

-(void)setFixProgressBlock:(MKDataBlock)fixProgressBlock{
    objc_setAssociatedObject(self,
                             BaseVC_JPImageresizerView_fixProgressBlock,
                             fixProgressBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,copy)MKDataBlock fixCompleteBlock;
-(MKDataBlock)fixCompleteBlock{
    return objc_getAssociatedObject(self, BaseVC_JPImageresizerView_fixCompleteBlock);
}

-(void)setFixCompleteBlock:(MKDataBlock)fixCompleteBlock{
    objc_setAssociatedObject(self,
                             BaseVC_JPImageresizerView_fixCompleteBlock,
                             fixCompleteBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end
