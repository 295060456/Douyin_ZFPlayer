//
//  BaseVC+TZImagePickerControllerDelegate.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/11.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC+TZImagePickerControllerDelegate.h"

@implementation BaseVC (TZImagePickerControllerDelegate)

static char *BaseVC_TZImagePickerControllerDelegate_selectedPhotos = "BaseVC_TZImagePickerControllerDelegate_selectedPhotos";
static char *BaseVC_TZImagePickerControllerDelegate_selectedAssets = "BaseVC_TZImagePickerControllerDelegate_selectedAssets";

@dynamic selectedPhotos;
@dynamic selectedAssets;

// The picker should dismiss itself; when it dismissed these callback will be called.
// You can also set autoDismiss to NO, then the picker don't dismiss itself.
// If isOriginalPhoto is YES, user picked the original photo.
// You can get original photo with asset, by the method [[TZImageManager manager] getOriginalPhotoWithAsset:completion:].
// The UIImage Object in photos default width is 828px, you can set it by photoWidth property.
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 你也可以设置autoDismiss属性为NO，选择器就不会自己dismis了
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker
       didFinishPickingPhotos:(NSArray<UIImage *> *)photos
                 sourceAssets:(NSArray *)assets
        isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    NSLog(@"");
}

- (void)imagePickerController:(TZImagePickerController *)picker
       didFinishPickingPhotos:(NSArray<UIImage *> *)photos
                 sourceAssets:(NSArray *)assets
        isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
                        infos:(NSArray<NSDictionary *> *)infos{
    NSLog(@"");
}

- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker{
    NSLog(@"");
}

// If user picking a video and allowPickingMultipleVideo is NO, this callback will be called.
// If allowPickingMultipleVideo is YES, will call imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
// 如果用户选择了一个视频且allowPickingMultipleVideo是NO，下面的代理方法会被执行
// 如果allowPickingMultipleVideo是YES，将会调用imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
- (void)imagePickerController:(TZImagePickerController *)picker
        didFinishPickingVideo:(UIImage *)coverImage
                 sourceAssets:(PHAsset *)asset{
    self.selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    self.selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    [[TZImageManager manager] getVideoOutputPathWithAsset:asset
                                               presetName:AVAssetExportPresetLowQuality
                                                  success:^(NSString *outputPath) {
        // NSData *data = [NSData dataWithContentsOfFile:outputPath];
        NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
        // Export completed, send video here, send by outputPath or NSData
        // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
        if (self.picBlock) {
            self.picBlock(@3,
                          coverImage,
                          asset,
                          outputPath);
        }
    } failure:^(NSString *errorMessage, NSError *error) {
        NSLog(@"视频导出失败:%@,error:%@",errorMessage, error);
    }];
}

// If user picking a gif image and allowPickingMultipleVideo is NO, this callback will be called.
// If allowPickingMultipleVideo is YES, will call imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
// 如果用户选择了一个gif图片且allowPickingMultipleVideo是NO，下面的代理方法会被执行
// 如果allowPickingMultipleVideo是YES，将会调用imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
- (void)imagePickerController:(TZImagePickerController *)picker
     didFinishPickingGifImage:(UIImage *)animatedImage
                 sourceAssets:(PHAsset *)asset{
    NSLog(@"");
}

// Decide album show or not't
// 决定相册显示与否 albumName:相册名字 result:相册原始数据
- (BOOL)isAlbumCanSelect:(NSString *)albumName
                  result:(PHFetchResult *)result{
    return YES;
}

// Decide asset show or not't
// 决定照片显示与否
- (BOOL)isAssetCanSelect:(PHAsset *)asset{
    return YES;
}

#pragma mark —— @property(nonatomic,strong)NSMutableArray *selectedPhotos;
-(NSMutableArray *)selectedPhotos{
    NSMutableArray *SelectedPhotos = objc_getAssociatedObject(self, BaseVC_TZImagePickerControllerDelegate_selectedPhotos);
    if (!SelectedPhotos) {
        SelectedPhotos = NSMutableArray.array;
        objc_setAssociatedObject(self,
                                 BaseVC_TZImagePickerControllerDelegate_selectedPhotos,
                                 SelectedPhotos,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return SelectedPhotos;
}

-(void)setSelectedPhotos:(NSMutableArray *)selectedPhotos{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerControllerDelegate_selectedPhotos,
                             selectedPhotos,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark —— @property(nonatomic,strong)NSMutableArray *selectedAssets;
-(NSMutableArray *)selectedAssets{
    NSMutableArray *SelectedAssets = objc_getAssociatedObject(self, BaseVC_TZImagePickerControllerDelegate_selectedAssets);
    if (!SelectedAssets) {
        SelectedAssets = NSMutableArray.array;
        objc_setAssociatedObject(self,
                                 BaseVC_TZImagePickerControllerDelegate_selectedAssets,
                                 SelectedAssets,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return SelectedAssets;
}

-(void)setSelectedAssets:(NSMutableArray *)selectedAssets{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerControllerDelegate_selectedAssets,
                             selectedAssets,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
