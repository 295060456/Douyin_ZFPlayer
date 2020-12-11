//
//  UIViewController+JPImageresizerView.h
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import <UIKit/UIKit.h>
#import "JPImageresizerView.h"

typedef enum : NSInteger {
    JPImageresizerConfigureType_1 = 0,//默认配置裁剪图片/GIF（UIImage）
    JPImageresizerConfigureType_2,//默认配置裁剪图片/GIF（NSData）
    JPImageresizerConfigureType_3,//默认配置裁剪视频（NSURL）
    JPImageresizerConfigureType_4,//默认配置裁剪视频（AVURLAsset）
    JPImageresizerConfigureType_5,//浅色毛玻璃配置裁剪图片/GIF（UIImage）
    JPImageresizerConfigureType_6,//浅色毛玻璃配置裁剪图片/GIF（NSData）
    JPImageresizerConfigureType_7,//浅色毛玻璃配置裁剪视频（NSURL）
    JPImageresizerConfigureType_8,//浅色毛玻璃配置裁剪视频（AVURLAsset）
    JPImageresizerConfigureType_9,//深色毛玻璃配置裁剪图片/GIF（UIImage）
    JPImageresizerConfigureType_10,//深色毛玻璃配置裁剪图片/GIF（NSData）
    JPImageresizerConfigureType_11,//深色毛玻璃配置裁剪视频（NSURL）
    JPImageresizerConfigureType_12//深色毛玻璃配置裁剪视频（AVURLAsset）
} JPImageresizerConfigureType;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (JPImageresizerView)

#pragma mark —— BaseVC+JPImageresizerView
@property(nonatomic,strong)JPImageresizerConfigure *configure;
@property(nonatomic,strong)JPImageresizerView *imageresizerView;
@property(nonatomic,assign)JPImageresizerConfigureType configureType;
///一些资源文件
@property(nonatomic,strong)NSData *JPImageresizerView_data;
@property(nonatomic,strong)UIImage *JPImageresizerView_img;
@property(nonatomic,strong)NSURL *JPImageresizerView_url;
@property(nonatomic,strong)AVURLAsset *JPImageresizerView_avURLAsset;
///Block回调
@property(nonatomic,copy)MKDataBlock makeBlock;
@property(nonatomic,copy)MKDataBlock fixErrorBlock;
@property(nonatomic,copy)MKDataBlock fixStartBlock;
@property(nonatomic,copy)MKDataBlock fixProgressBlock;
@property(nonatomic,copy)MKDataBlock fixCompleteBlock;

@end

NS_ASSUME_NONNULL_END

//-(void)tailor:(UIImage *)img{
//    self.configureType = JPImageresizerConfigureType_1;
//    self.JPImageresizerView_img = img;
//    //图片裁剪 方式方法_2
//    NSLog(@"图片裁剪中...");
//    @weakify(self)
//    [self.imageresizerView cropPictureWithCompressScale:0.5// 压缩比例，大于等于1按原图尺寸裁剪，小于等于0则返回nil（例：compressScale = 0.5，1000 x 500 --> 500 x 250）
//                                               cacheURL:[FileFolderHandleTool cacheURL:@"png"]
//                                             errorBlock:^(NSURL *cacheURL,
//                                                          JPImageresizerErrorReason reason) {
////                    @strongify(self)
//        switch (reason) {
//            case JPIEReason_NilObject:
//                NSLog(@"资源为空");
//                break;
//            case JPIEReason_CacheURLAlreadyExists:
//                NSLog(@"缓存路径已存在其他文件");
//                break;
//            case JPIEReason_NoSupportedFileType:
//                NSLog(@" 不支持的文件格式");
//                break;
//             case JPIEReason_VideoAlreadyDamage:
//                NSLog(@"视频文件已损坏");
//                break;
//            case JPIEReason_VideoExportFailed:
//                NSLog(@"视频导出失败");
//                break;
//            case JPIEReason_VideoExportCancelled:
//                NSLog(@"视频导出取消");
//                break;
//    }
//
//    }
//                                         completeBlock :^(UIImage *finalImage,
//                                                           NSURL *cacheURL,
//                                                           BOOL isCacheSuccess) {
//        @strongify(self)
//        NSLog(@"图片裁剪完成");
//        // 裁剪完成，finalImage为裁剪后的图片
//        if (!finalImage && !cacheURL) {
//            NSLog(@"裁剪失败");
//            return;
//        }
//        //本地
//        [self.headerBtn setImage:finalImage
//                        forState:UIControlStateNormal];
//        //网络上传
//        [self netWorking_MKUserInfoUploadImagePOST:finalImage];
//    }];
//}
