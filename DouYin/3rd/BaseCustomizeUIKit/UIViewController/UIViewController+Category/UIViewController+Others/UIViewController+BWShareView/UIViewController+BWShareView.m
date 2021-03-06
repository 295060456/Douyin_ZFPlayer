//
//  UIViewController+BWShareView.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "UIViewController+BWShareView.h"
#import <objc/runtime.h>

@implementation UIViewController (BWShareView)

static char *BaseVC_BWShareView_shareView = "BaseVC_BWShareView_shareView";
static char *BaseVC_BWShareView_shareViewDataMutArr = "BaseVC_BWShareView_shareViewDataMutArr";
static char *BaseVC_BWShareView_shareViewDataMutSecArr = "BaseVC_BWShareView_shareViewDataMutSecArr";
static char *BaseVC_BWShareView_bWShareViewStyle = "BaseVC_BWShareView_bWShareViewStyle";
static char *BaseVC_BWShareView_shareTitle = "BaseVC_BWShareView_shareTitle";

static char *originX = "originX";
static char *originY = "originY";
static char *sizeW = "sizeW";
static char *sizeH = "sizeH";

@dynamic shareView;
@dynamic shareViewFrame;
@dynamic shareViewDataMutArr;
@dynamic bWShareViewStyle;
@dynamic shareTitle;
@dynamic shareViewDataMutSecArr;

#pragma mark SET | GET
#pragma mark —— @property(strong,nonatomic)BWShareView *shareView;
-(BWShareView *)shareView{
    BWShareView *ShareView = objc_getAssociatedObject(self, BaseVC_BWShareView_shareView);
    switch (self.bWShareViewStyle) {
        case BWShareViewStyle_1:{
            if (!ShareView) {
                ShareView = [[BWShareView alloc] initWithFrame:self.shareViewFrame
                                                    shareTitle:self.shareTitle
                                                    shareArray:self.shareViewDataMutArr];
            }
        }
            break;
        case BWShareViewStyle_2:{
            if (!ShareView) {
                ShareView = [[BWShareView alloc] initWithFrame:self.shareViewFrame
                                                    shareTitle:self.shareTitle
                                                    firstArray:self.shareViewDataMutArr
                                                   secondArray:self.shareViewDataMutSecArr];
            }
        }
        default:
            ShareView = Nil;
            NSAssert(ShareView,@"ShareView 创建出现错误");
            break;
    }
    objc_setAssociatedObject(self,
                             BaseVC_BWShareView_shareView,
                             ShareView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return ShareView;
}

-(void)setShareView:(BWShareView *)shareView{
    objc_setAssociatedObject(self,
                             BaseVC_BWShareView_shareView,
                             shareView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(assign,nonatomic)CGRect shareViewFrame;
-(CGRect)shareViewFrame{
    CGFloat ShareViewFrameX = [objc_getAssociatedObject(self, originX) floatValue];
    CGFloat ShareViewFrameY = [objc_getAssociatedObject(self, originY) floatValue];
    CGFloat ShareViewFrameW = [objc_getAssociatedObject(self, sizeW) floatValue];
    CGFloat ShareViewFrameH = [objc_getAssociatedObject(self, sizeH) floatValue];
    return CGRectMake(ShareViewFrameX,
                      ShareViewFrameY,
                      ShareViewFrameW,
                      ShareViewFrameH);
}

-(void)setShareViewFrame:(CGRect)shareViewFrame{
    objc_setAssociatedObject(self,
                             originX,
                             [NSNumber numberWithFloat:shareViewFrame.origin.x],
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self,
                             originY,
                             [NSNumber numberWithFloat:shareViewFrame.origin.y],
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self,
                             sizeW,
                             [NSNumber numberWithFloat:shareViewFrame.size.width],
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self,
                             sizeH,
                             [NSNumber numberWithFloat:shareViewFrame.size.height],
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark —— @property(assign,nonatomic)BWShareViewStyle bWShareViewStyle;
-(BWShareViewStyle)bWShareViewStyle{
    return [objc_getAssociatedObject(self, BaseVC_BWShareView_bWShareViewStyle) integerValue];
}

-(void)setBWShareViewStyle:(BWShareViewStyle)bWShareViewStyle{
    objc_setAssociatedObject(self,
                             BaseVC_BWShareView_bWShareViewStyle,
                             [NSNumber numberWithInteger:bWShareViewStyle],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(strong,nonatomic)NSMutableArray *shareViewDataMutArr;
-(NSMutableArray *)shareViewDataMutArr{
    NSMutableArray *ShareViewDataMutArr = objc_getAssociatedObject(self, BaseVC_BWShareView_shareViewDataMutArr);
    if (!ShareViewDataMutArr) {
        ShareViewDataMutArr = NSMutableArray.array;
        objc_setAssociatedObject(self,
                                 BaseVC_BWShareView_shareViewDataMutArr,
                                 ShareViewDataMutArr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return ShareViewDataMutArr;
}

-(void)setShareViewDataMutArr:(NSMutableArray *)shareViewDataMutArr{
    objc_setAssociatedObject(self,
                             BaseVC_BWShareView_shareViewDataMutArr,
                             shareViewDataMutArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark —— @property(strong,nonatomic)NSMutableArray *shareViewDataMutSecArr;
-(NSMutableArray *)shareViewDataMutSecArr{
    NSMutableArray *ShareViewDataMutSecArr = objc_getAssociatedObject(self, BaseVC_BWShareView_shareViewDataMutSecArr);
    if (!ShareViewDataMutSecArr) {
        ShareViewDataMutSecArr = NSMutableArray.array;
        objc_setAssociatedObject(self,
                                 BaseVC_BWShareView_shareViewDataMutSecArr,
                                 ShareViewDataMutSecArr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return ShareViewDataMutSecArr;
}

-(void)setShareViewDataMutSecArr:(NSMutableArray *)shareViewDataMutSecArr{
    objc_setAssociatedObject(self,
                             BaseVC_BWShareView_shareViewDataMutSecArr,
                             shareViewDataMutSecArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(strong,nonatomic)NSString *shareTitle;
-(NSString *)shareTitle{
   return objc_getAssociatedObject(self, BaseVC_BWShareView_shareTitle);
}

-(void)setShareTitle:(NSString *)shareTitle{
    objc_setAssociatedObject(self,
                             BaseVC_BWShareView_shareTitle,
                             shareTitle,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
