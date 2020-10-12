//
//  BaseVC+TZImagePickerController.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC+TZImagePickerController.h"
#import "BaseVC+TZImagePickerControllerDelegate.h"
#import "BaseVC+TZLocationManager.h"
#import "NSObject+SYSAlertController.h"
#import "NSObject+SPAlertController.h"
#import "ECAuthorizationTools.h"//https://github.com/EchoZuo/ECAuthorizationTools/blob/master/README.md
#import <objc/runtime.h>

@implementation BaseVC (TZImagePickerController)

static char *BaseVC_TZImagePickerController_imagePickerVC = "BaseVC_TZImagePickerController_imagePickerVC";
static char *BaseVC_TZImagePickerController_imagePickerVC_Sys = "BaseVC_TZImagePickerController_imagePickerVC_Sys";
static char *BaseVC_TZImagePickerController_mediaTypesMutArr = "BaseVC_TZImagePickerController_mediaTypesMutArr";

static char *BaseVC_TZImagePickerController_tzImagePickerControllerType = "BaseVC_TZImagePickerController_tzImagePickerControllerType";
static char *BaseVC_TZImagePickerController_picBlock = "BaseVC_TZImagePickerController_picBlock";
static char *BaseVC_TZImagePickerController_maxImagesCount = "BaseVC_TZImagePickerController_maxImagesCount";
static char *BaseVC_TZImagePickerController_columnNumber = "BaseVC_TZImagePickerController_columnNumber";
static char *BaseVC_TZImagePickerController_index = "BaseVC_TZImagePickerController_index";
static char *BaseVC_TZImagePickerController_isPushPhotoPickerVc = "BaseVC_TZImagePickerController_isPushPhotoPickerVc";
static char *BaseVC_TZImagePickerController_selectedAssets = "BaseVC_TZImagePickerController_selectedAssets";
static char *BaseVC_TZImagePickerController_selectedPhotos = "BaseVC_TZImagePickerController_selectedPhotos";
static char *BaseVC_TZImagePickerController_photo = "BaseVC_TZImagePickerController_photo";
static char *BaseVC_TZImagePickerController_asset = "BaseVC_TZImagePickerController_asset";

@dynamic imagePickerVC;
@dynamic imagePickerVC_Sys;
@dynamic tzImagePickerControllerType;
@dynamic picBlock;
@dynamic maxImagesCount;
@dynamic columnNumber;
@dynamic index;
@dynamic isPushPhotoPickerVc;
@dynamic selectedAssets;
@dynamic selectedPhotos;
@dynamic photo;
@dynamic asset;
@dynamic mediaTypesMutArr;

///点选的图片
-(void)GettingPicBlock:(MMDataBlock)block{
    self.picBlock = block;
}
///访问相册 —— 选择图片
-(void)choosePic:(TZImagePickerControllerType)tzImagePickerControllerType
imagePickerVCBlock:(MKDataBlock _Nullable)imagePickerVCBlock{
    self.tzImagePickerControllerType = tzImagePickerControllerType;
    @weakify(self)
    [ECAuthorizationTools checkAndRequestAccessForType:ECPrivacyType_Photos
                                          accessStatus:^id(ECAuthorizationStatus status,
                                                           ECPrivacyType type) {
        @strongify(self)
        // status 即为权限状态，
        //状态类型参考：ECAuthorizationStatus
        NSLog(@"%lu",(unsigned long)status);
        if (status == ECAuthorizationStatus_Authorized) {
            self.imagePickerVC.allowPickingOriginalPhoto = YES;
            self.imagePickerVC.allowPickingGif = YES;
            self.imagePickerVC.sortAscendingByModificationDate = YES;
            self.imagePickerVC.showSelectBtn = NO;
            self.imagePickerVC.allowCrop = YES;
            self.imagePickerVC.needCircleCrop = YES;
            //图片裁剪 方式方法_1
//            NSInteger left = 30;
//            NSInteger widthHeight = self.view.mj_w - 2 * left;
//            NSInteger top = (self.view.mj_h - widthHeight) / 2;
//            self.imagePickerVC.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
//            self.imagePickerVC.scaleAspectFillCrop = YES;

            if (imagePickerVCBlock) {
                imagePickerVCBlock(self.imagePickerVC);
            }
            
            [self presentViewController:self.imagePickerVC
                                     animated:YES
                                   completion:nil];
            return self.imagePickerVC;
        }else{
            NSLog(@"相册不可用:%lu",(unsigned long)status);
            [NSObject showSYSAlertViewTitle:@"获取相册权限"
                                    message:nil
                            isSeparateStyle:YES
                                btnTitleArr:@[@"去获取"]
                             alertBtnAction:@[@"pushToSysConfig"]
                                   targetVC:self
                               alertVCBlock:^(id data) {
                //DIY
            }];
            return nil;
        }
    }];
}
///访问摄像头_鉴权
-(void)camera:(MKDataBlock)doSthBlock{
    //先鉴权
    @weakify(self)
    [ECAuthorizationTools checkAndRequestAccessForType:ECPrivacyType_Camera
                                          accessStatus:^id(ECAuthorizationStatus status,
                                                         ECPrivacyType type) {
        @strongify(self)
        // status 即为权限状态，
        //状态类型参考：ECAuthorizationStatus
        NSLog(@"%lu",(unsigned long)status);
        if (status == ECAuthorizationStatus_Authorized) {
            //允许访问摄像头后需要做的操作
            [self pushImagePickerController];
            if (doSthBlock) {
                doSthBlock(@1);
            }
        }else{
            NSLog(@"摄像头不可用:%lu",(unsigned long)status);
            [NSObject showSYSAlertViewTitle:@"获取摄像头权限"
                                    message:nil
                            isSeparateStyle:YES
                                btnTitleArr:@[@"去获取"]
                          alertBtnAction:@[@"pushToSysConfig"]
                                   targetVC:self
                               alertVCBlock:^(id data) {
                //DIY
            }];
        }return nil;
    }];
}
// 调用相机
- (void)pushImagePickerController {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVC_Sys.sourceType = sourceType;
//        [self.mediaTypesMutArr addObject:(NSString *)kUTTypeMovie];
        [self.mediaTypesMutArr addObject:(NSString *)kUTTypeImage];
        if (self.mediaTypesMutArr.count) {
            self.imagePickerVC_Sys.mediaTypes = self.mediaTypesMutArr;
        }
        [self presentViewController:self.imagePickerVC_Sys
                           animated:YES
                         completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}
#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong)UIImagePickerController *imagePickerVC_Sys;
-(UIImagePickerController *)imagePickerVC_Sys{
    UIImagePickerController *ImagePickerVC_Sys = objc_getAssociatedObject(self, BaseVC_TZImagePickerController_imagePickerVC_Sys);
    if (!ImagePickerVC_Sys) {
        ImagePickerVC_Sys = UIImagePickerController.new;
        ImagePickerVC_Sys.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        ImagePickerVC_Sys.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        ImagePickerVC_Sys.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[TZImagePickerController.class]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[UIImagePickerController.class]];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:TZImagePickerController.class, nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:UIImagePickerController.class, nil];
#pragma clang diagnostic pop
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
        objc_setAssociatedObject(self,
                                 BaseVC_TZImagePickerController_imagePickerVC_Sys,
                                 ImagePickerVC_Sys,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return ImagePickerVC_Sys;
}
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info{
    UIImage *photo = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (!photo) {
        [WHToast showErrorWithMessage:@"异常操作，导致拍照失败"
                             duration:2
                        finishHandler:^{
          
        }];
        return;
    }else{
        if (self.picBlock) {
            self.picBlock(@1,photo);
        }
    }
    [self dismissViewControllerAnimated:self.imagePickerVC_Sys completion:^{}];
}

-(void)setImagePickerVC_Sys:(UIImagePickerController *)imagePickerVC_Sys{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_imagePickerVC_Sys,
                             imagePickerVC_Sys,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSMutableArray *mediaTypesMutArr;
-(NSMutableArray *)mediaTypesMutArr{
    NSMutableArray *MediaTypesMutArr = objc_getAssociatedObject(self, BaseVC_TZImagePickerController_mediaTypesMutArr);
    if (!MediaTypesMutArr) {
        MediaTypesMutArr = NSMutableArray.array;
        objc_setAssociatedObject(self,
                                 BaseVC_TZImagePickerController_mediaTypesMutArr,
                                 MediaTypesMutArr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return MediaTypesMutArr;
}

-(void)setMediaTypesMutArr:(NSMutableArray *)mediaTypesMutArr{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_mediaTypesMutArr,
                             mediaTypesMutArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)TZImagePickerController *imagePickerVC;
//分类里面只能写self.属性，所以每次都优先走get方法再走set
-(TZImagePickerController *)imagePickerVC{
    TZImagePickerController *imagePickerController = objc_getAssociatedObject(self, BaseVC_TZImagePickerController_imagePickerVC);
    if (!imagePickerController) {
        switch (self.tzImagePickerControllerType){
            case TZImagePickerControllerType_1:{
                imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxImagesCount
                                                                                       delegate:self];
            }break;
            case TZImagePickerControllerType_2:{
                imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxImagesCount
                                                                                   columnNumber:self.columnNumber
                                                                                       delegate:self];
            }break;
            case TZImagePickerControllerType_3:{
                imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxImagesCount
                                                                                   columnNumber:self.columnNumber
                                                                                       delegate:self
                                                                              pushPhotoPickerVc:YES];
            }break;
            case TZImagePickerControllerType_4:{
                imagePickerController = [[TZImagePickerController alloc] initWithSelectedAssets:self.selectedAssets
                                                                                 selectedPhotos:self.selectedPhotos
                                                                                          index:self.index];
            }break;
            case TZImagePickerControllerType_5:{
                imagePickerController = [[TZImagePickerController alloc] initCropTypeWithAsset:self.asset
                                                                                         photo:self.photo
                                                                                    completion:^(UIImage *cropImage,
                                                                                                 PHAsset *asset) {
                }];
            }break;

            default:
                NSAssert(imagePickerController,@"imagePickerController 创建出现错误");
                break;
        }
            
        @weakify(self)
        [imagePickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,
                                                                 NSArray *assets,
                                                                 BOOL isSelectOriginalPhoto) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@3,
                              photos,
                              assets,
                              @(isSelectOriginalPhoto));
            }
        }];
        
                
        [imagePickerController setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos,
                                                                          NSArray *assets,
                                                                          BOOL isSelectOriginalPhoto,
                                                                          NSArray<NSDictionary *> *infos) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@4,
                              photos,
                              assets,
                              @(isSelectOriginalPhoto),
                              infos);
            }
        }];

        [imagePickerController setImagePickerControllerDidCancelHandle:^{
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@0);
            }
        }];

        [imagePickerController setDidFinishPickingVideoHandle:^(UIImage *coverImage,
                                                                PHAsset *asset) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@2,
                              coverImage,
                              asset);
            }
        }];
        [imagePickerController setDidFinishPickingGifImageHandle:^(UIImage *animatedImage,
                                                                   id sourceAssets) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@2,
                              animatedImage,
                              sourceAssets);
            }
        }];

        [imagePickerController setDidFinishPickingGifImageHandle:^(UIImage *animatedImage,
                                                                   id sourceAssets) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@2,
                              animatedImage,
                              sourceAssets);
            }
        }];

        [imagePickerController setCropViewSettingBlock:^(UIView *cropView) { ///< 自定义裁剪框的其他属性
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@1,
                              cropView);
            }
        }];

        [imagePickerController setNavLeftBarButtonSettingBlock:^(UIButton *leftButton) {///< 自定义返回按钮样式及其属性
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@1,
                              leftButton);
            }
        }];

        /// 【自定义各页面/组件的样式】在界面初始化/组件setModel完成后调用，允许外界修改样式等
        [imagePickerController setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView,
                                                                 UIView *bottomToolBar,
                                                                 UIButton *previewButton,
                                                                 UIButton *originalPhotoButton,
                                                                 UILabel *originalPhotoLabel,
                                                                 UIButton *doneButton,
                                                                 UIImageView *numberImageView,
                                                                 UILabel *numberLabel,
                                                                 UIView *divideLine) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@9,
                              collectionView,
                              bottomToolBar,
                              previewButton,
                              originalPhotoButton,
                              originalPhotoLabel,
                              doneButton,
                              numberImageView,
                              numberLabel,
                              divideLine);
            }
        }];

        [imagePickerController setPhotoPreviewPageUIConfigBlock:^(UICollectionView *collectionView,
                                                                  UIView *naviBar,
                                                                  UIButton *backButton,
                                                                  UIButton *selectButton,
                                                                  UILabel *indexLabel,
                                                                  UIView *toolBar,
                                                                  UIButton *originalPhotoButton,
                                                                  UILabel *originalPhotoLabel,
                                                                  UIButton *doneButton,
                                                                  UIImageView *numberImageView,
                                                                  UILabel *numberLabel) {//
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@11,
                              collectionView,
                              naviBar,
                              backButton,
                              selectButton,
                              indexLabel,
                              toolBar,
                              originalPhotoButton,
                              originalPhotoLabel,
                              doneButton,
                              numberImageView,
                              numberLabel);
            }
        }];

        [imagePickerController setVideoPreviewPageUIConfigBlock:^(UIButton *playButton,
                                                                  UIView *toolBar,
                                                                  UIButton *doneButton) {//
            if (self.picBlock) {
                self.picBlock(@3,
                              playButton,
                              toolBar,
                              doneButton);
            }
        }];

        [imagePickerController setGifPreviewPageUIConfigBlock:^(UIView *toolBar,
                                                                UIButton *doneButton) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@2,
                              toolBar,
                              doneButton);
            }
        }];

        [imagePickerController setAlbumPickerPageUIConfigBlock:^(UITableView *tableView) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@1,
                              tableView);
            }
        }];

        [imagePickerController setAssetCellDidSetModelBlock:^(TZAssetCell *cell,
                                                              UIImageView *imageView,
                                                              UIImageView *selectImageView,
                                                              UILabel *indexLabel,
                                                              UIView *bottomView,
                                                              UILabel *timeLength,
                                                              UIImageView *videoImgView) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@7,
                              cell,
                              imageView,
                              selectImageView,
                              indexLabel,
                              bottomView,
                              timeLength,
                              videoImgView);
            }
        }];

        [imagePickerController setAlbumCellDidSetModelBlock:^(TZAlbumCell *cell,
                                                              UIImageView *posterImageView,
                                                              UILabel *titleLabel) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@3,
                              cell,
                              posterImageView,
                              titleLabel);
            }
        }];

        /// 【自定义各页面/组件的frame】在界面viewDidLayoutSubviews/组件layoutSubviews后调用，允许外界修改frame等
        [imagePickerController setPhotoPickerPageDidLayoutSubviewsBlock:^(UICollectionView *collectionView,
                                                                          UIView *bottomToolBar,
                                                                          UIButton *previewButton,
                                                                          UIButton *originalPhotoButton,
                                                                          UILabel *originalPhotoLabel,
                                                                          UIButton *doneButton,
                                                                          UIImageView *numberImageView,
                                                                          UILabel *numberLabel,
                                                                          UIView *divideLine) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@9,
                              collectionView,
                              bottomToolBar,
                              previewButton,
                              originalPhotoButton,
                              originalPhotoLabel,
                              doneButton,
                              numberImageView,
                              numberLabel,
                              divideLine);
            }
        }];

        [imagePickerController setPhotoPreviewPageDidLayoutSubviewsBlock:^(UICollectionView *collectionView,
                                                                           UIView *naviBar,
                                                                           UIButton *backButton,
                                                                           UIButton *selectButton,
                                                                           UILabel *indexLabel,
                                                                           UIView *toolBar,
                                                                           UIButton *originalPhotoButton,
                                                                           UILabel *originalPhotoLabel,
                                                                           UIButton *doneButton,
                                                                           UIImageView *numberImageView,
                                                                           UILabel *numberLabel) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@11,
                              collectionView,
                              naviBar,
                              backButton,
                              selectButton,
                              indexLabel,
                              toolBar,
                              originalPhotoButton,
                              originalPhotoLabel,
                              doneButton,
                              numberImageView,
                              numberLabel);
            }
        }];

        [imagePickerController setVideoPreviewPageDidLayoutSubviewsBlock:^(UIButton *playButton,
                                                                           UIView *toolBar,
                                                                           UIButton *doneButton) {//
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@3,
                              playButton,
                              toolBar,
                              doneButton);
            }
        }];

        [imagePickerController setGifPreviewPageDidLayoutSubviewsBlock:^(UIView *toolBar,
                                                                         UIButton *doneButton) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@2,
                              toolBar,
                              doneButton);
            }
        }];

        [imagePickerController setAlbumPickerPageDidLayoutSubviewsBlock:^(UITableView *tableView) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@1,
                              tableView);
            }
        }];

        [imagePickerController setAssetCellDidLayoutSubviewsBlock:^(TZAssetCell *cell,
                                                                    UIImageView *imageView,
                                                                    UIImageView *selectImageView,
                                                                    UILabel *indexLabel,
                                                                    UIView *bottomView,
                                                                    UILabel *timeLength,
                                                                    UIImageView *videoImgView) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@7,
                              cell,
                              imageView,
                              selectImageView,
                              indexLabel,
                              bottomView,
                              timeLength,
                              videoImgView);
            }
        }];

        [imagePickerController setAlbumCellDidLayoutSubviewsBlock:^(TZAlbumCell *cell,
                                                                    UIImageView *posterImageView,
                                                                    UILabel *titleLabel) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@3,
                              cell,
                              posterImageView,
                              titleLabel);
            }
        }];

        /// 自定义各页面/组件的frame】刷新底部状态(refreshNaviBarAndBottomBarState)使用的
        [imagePickerController setPhotoPickerPageDidRefreshStateBlock:^(UICollectionView *collectionView,
                                                                        UIView *bottomToolBar,
                                                                        UIButton *previewButton,
                                                                        UIButton *originalPhotoButton,
                                                                        UILabel *originalPhotoLabel,
                                                                        UIButton *doneButton,
                                                                        UIImageView *numberImageView,
                                                                        UILabel *numberLabel,
                                                                        UIView *divideLine) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@9,
                              collectionView,
                              bottomToolBar,
                              previewButton,
                              originalPhotoButton,
                              originalPhotoLabel,
                              doneButton,
                              numberImageView,
                              numberLabel,
                              divideLine);
            }
        }];

        [imagePickerController setPhotoPreviewPageDidRefreshStateBlock:^(UICollectionView *collectionView,
                                                                         UIView *naviBar,
                                                                         UIButton *backButton,
                                                                         UIButton *selectButton,
                                                                         UILabel *indexLabel,
                                                                         UIView *toolBar,
                                                                         UIButton *originalPhotoButton,
                                                                         UILabel *originalPhotoLabel,
                                                                         UIButton *doneButton,
                                                                         UIImageView *numberImageView,
                                                                         UILabel *numberLabel) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(@10,
                              collectionView,
                              naviBar,backButton,
                              selectButton,
                              indexLabel,
                              toolBar,
                              originalPhotoButton,
                              originalPhotoLabel,
                              doneButton,
                              numberImageView,
                              numberLabel);
            }
        }];

        objc_setAssociatedObject(self,
                                 BaseVC_TZImagePickerController_imagePickerVC,
                                 imagePickerController,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return imagePickerController;
}

-(void)setImagePickerVC:(TZImagePickerController *)imagePickerVC{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_imagePickerVC,
                             imagePickerVC,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)NSInteger maxImagesCount;
-(NSInteger)maxImagesCount{
    NSInteger MaxImagesCount = [objc_getAssociatedObject(self, BaseVC_TZImagePickerController_maxImagesCount) integerValue];
    MaxImagesCount = MaxImagesCount != 0 ? : 1;
    return MaxImagesCount;
}

-(void)setMaxImagesCount:(NSInteger)maxImagesCount{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_maxImagesCount,
                             [NSNumber numberWithInteger:maxImagesCount],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)NSInteger columnNumber;
-(NSInteger)columnNumber{
    return [objc_getAssociatedObject(self, BaseVC_TZImagePickerController_columnNumber) integerValue];
}

- (void)setColumnNumber:(NSInteger)columnNumber{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_columnNumber,
                             [NSNumber numberWithInteger:columnNumber],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)NSInteger index;
-(NSInteger)index{
    return [objc_getAssociatedObject(self, BaseVC_TZImagePickerController_index) integerValue];
}

-(void)setIndex:(NSInteger)index{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_index,
                             [NSNumber numberWithInteger:index],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)BOOL isPushPhotoPickerVc;
-(BOOL)isPushPhotoPickerVc{
    return [objc_getAssociatedObject(self, BaseVC_TZImagePickerController_isPushPhotoPickerVc) boolValue];
}

- (void)setIsPushPhotoPickerVc:(BOOL)isPushPhotoPickerVc{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_isPushPhotoPickerVc,
                             [NSNumber numberWithBool:isPushPhotoPickerVc],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,strong)NSMutableArray *selectedAssets;
-(void)setSelectedAssets:(NSMutableArray *)selectedAssets{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_selectedAssets,
                             selectedAssets,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSMutableArray *)selectedAssets{
    NSMutableArray *SelectedAssets = objc_getAssociatedObject(self, BaseVC_TZImagePickerController_selectedAssets);
    if (!SelectedAssets) {
        SelectedAssets = NSMutableArray.array;
        objc_setAssociatedObject(self,
                                 BaseVC_TZImagePickerController_selectedAssets,
                                 SelectedAssets,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return SelectedAssets;
}
#pragma mark —— @property(nonatomic,strong)NSMutableArray *selectedPhotos;
-(void)setSelectedPhotos:(NSMutableArray *)selectedPhotos{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_selectedPhotos,
                             selectedPhotos,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSMutableArray *)selectedPhotos{
    NSMutableArray *SelectedPhotos = objc_getAssociatedObject(self, BaseVC_TZImagePickerController_selectedPhotos);
    if (!SelectedPhotos) {
        SelectedPhotos = NSMutableArray.array;
        objc_setAssociatedObject(self,
                                 BaseVC_TZImagePickerController_selectedPhotos,
                                 SelectedPhotos,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return SelectedPhotos;
}
#pragma mark —— @property(nonatomic,strong)UIImage *photo;
-(UIImage *)photo{
    UIImage *Photo = objc_getAssociatedObject(self, BaseVC_TZImagePickerController_photo);
    if (!Photo) {
        
    }return Photo;
}

-(void)setPhoto:(UIImage *)photo{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_photo,
                             photo,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)PHAsset *asset;
-(PHAsset *)asset{
    PHAsset *ASset = objc_getAssociatedObject(self, BaseVC_TZImagePickerController_asset);
    if (!ASset) {
        
    }return ASset;
}

-(void)setAsset:(PHAsset *)asset{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_asset,
                             asset,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)TZImagePickerControllerType tzImagePickerControllerType;
-(TZImagePickerControllerType)tzImagePickerControllerType{
    return [objc_getAssociatedObject(self, BaseVC_TZImagePickerController_tzImagePickerControllerType) integerValue];
}

-(void)setTzImagePickerControllerType:(TZImagePickerControllerType)tzImagePickerControllerType{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_tzImagePickerControllerType,
                             [NSNumber numberWithInteger:tzImagePickerControllerType],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,copy)MKDataBlock picBlock;
-(MMDataBlock)picBlock{
    return objc_getAssociatedObject(self, BaseVC_TZImagePickerController_picBlock);
}

-(void)setPicBlock:(MMDataBlock)picBlock{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_picBlock,
                             picBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
