//
//  UIViewController+GifImageView.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "UIViewController+GifImageView.h"
#import "NSString+Extras.h"
#import <objc/runtime.h>

@implementation UIViewController (GifImageView)

static char *BaseVC_GifImageView_gifImageView = "BaseVC_GifImageView_gifImageView";
static char *BaseVC_GifImageView_path = "BaseVC_GifImageView_path";
static char *BaseVC_GifImageView_data = "BaseVC_GifImageView_data";
static char *BaseVC_GifImageView_image = "BaseVC_GifImageView_image";

@dynamic gifImageView;
@dynamic path;
@dynamic data;
@dynamic image;

#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong)UIImageView *gifImageView;
-(UIImageView *)gifImageView{
    UIImageView *GifImageView = objc_getAssociatedObject(self, BaseVC_GifImageView_gifImageView);
    if (!GifImageView) {
        GifImageView = UIImageView.new;
        GifImageView.image = self.image;
        [self.view addSubview:GifImageView];
        [GifImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        objc_setAssociatedObject(self,
                                 BaseVC_GifImageView_gifImageView,
                                 GifImageView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return GifImageView;
}

-(void)setGifImageView:(UIImageView *)gifImageView{
    objc_setAssociatedObject(self,
                             BaseVC_GifImageView_gifImageView,
                             gifImageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark —— @property(nonatomic,strong)NSString *path;
-(NSString *)path{
    NSString *Path = objc_getAssociatedObject(self, BaseVC_GifImageView_path);
    if (![NSString isNullString:Path]) {
        Path = [[NSBundle mainBundle] pathForResource:@"GIF大图"
                                               ofType:@"gif"];
        objc_setAssociatedObject(self,
                                 BaseVC_GifImageView_path,
                                 Path,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return Path;
}

-(void)setPath:(NSString *)path{
    objc_setAssociatedObject(self,
                             BaseVC_GifImageView_path,
                             path,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSData *data;
-(NSData *)data{
    NSData *Data = objc_getAssociatedObject(self, BaseVC_GifImageView_data);
    if (!Data) {
        Data = [NSData dataWithContentsOfFile:self.path];
        objc_setAssociatedObject(self,
                                 BaseVC_GifImageView_data,
                                 Data,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return Data;
}

-(void)setData:(NSData *)data{
    objc_setAssociatedObject(self,
                             BaseVC_GifImageView_data,
                             data,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIImage *image;
-(UIImage *)image{
    UIImage *img = objc_getAssociatedObject(self, BaseVC_GifImageView_image);
    if (!img) {
        img = [UIImage sd_imageWithGIFData:self.data];
        objc_setAssociatedObject(self,
                                 BaseVC_GifImageView_image,
                                 img,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return img;
}

-(void)setImage:(UIImage *)image{
    objc_setAssociatedObject(self,
                             BaseVC_GifImageView_image,
                             image,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
