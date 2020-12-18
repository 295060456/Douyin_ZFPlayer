//
//  UIViewController+TZImagePickerController.h
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "NSObject+SYSAlertController.h"
#import "NSObject+SPAlertController.h"
#import "ECAuthorizationTools.h"//https://github.com/EchoZuo/ECAuthorizationTools/blob/master/README.md
#if __has_include(<TZImagePickerController/TZImagePickerController.h>)
#import <TZImagePickerController/TZImagePickerController.h>
#else
#import "TZImagePickerController.h"
#endif

///分别对应 TZImagePickerController 的五种初始化方法
typedef enum : NSInteger {
    TZImagePickerControllerType_1,//initWithMaxImagesCount/delegate/
    TZImagePickerControllerType_2,//initWithMaxImagesCount/columnNumber/delegate
    TZImagePickerControllerType_3,//initWithMaxImagesCount/columnNumber/delegate/pushPhotoPickerVc
    TZImagePickerControllerType_4,//initWithSelectedAssets/selectedPhotos/index
    TZImagePickerControllerType_5//initCropTypeWithAsset/photo/completion
} TZImagePickerControllerType;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (TZImagePickerController)
<
TZImagePickerControllerDelegate
,UINavigationControllerDelegate
,UIImagePickerControllerDelegate
>
#pragma mark —— BaseVC+TZImagePickerController
@property(nonatomic,strong,nullable)TZImagePickerController *imagePickerVC;
@property(nonatomic,strong)UIImagePickerController *imagePickerVC_Sys;
@property(nonatomic,strong)NSMutableArray *mediaTypesMutArr;
@property(nonatomic,assign)TZImagePickerControllerType tzImagePickerControllerType;
@property(nonatomic,copy)MMDataBlock picBlock;

@property(nonatomic,assign)NSInteger maxImagesCount;
@property(nonatomic,assign)NSInteger columnNumber;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)BOOL isPushPhotoPickerVc;
@property(nonatomic,strong)NSMutableArray *selectedAssets;
@property(nonatomic,strong)NSMutableArray *selectedPhotos;
@property(nonatomic,strong)UIImage *photo;
@property(nonatomic,strong)PHAsset *asset;

///点选的图片
-(void)GettingPicBlock:(MMDataBlock)block;
///访问相册 —— 选择图片
-(void)choosePic:(TZImagePickerControllerType)tzImagePickerControllerType
imagePickerVCBlock:(MKDataBlock _Nullable)imagePickerVCBlock;
///访问摄像头
-(void)camera:(MKDataBlock)doSthBlock;

-(void)pushImagePickerController;


@end

NS_ASSUME_NONNULL_END
