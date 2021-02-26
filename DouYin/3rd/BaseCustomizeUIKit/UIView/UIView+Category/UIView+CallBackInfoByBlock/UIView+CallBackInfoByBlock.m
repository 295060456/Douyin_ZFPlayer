//
//  UIView+CallBackInfoByBlock.m
//  DouDong-II
//
//  Created by Jobs on 2021/2/26.
//

#import "UIView+CallBackInfoByBlock.h"

@implementation UIView (CallBackInfoByBlock)

static char *UIView_CallBackInfoByBlock_viewBlock = "UIView_CallBackInfoByBlock_viewBlock";
@dynamic viewBlock;

-(void)actionViewBlock:(MKDataBlock)viewBlock{
    self.viewBlock = viewBlock;
}
#pragma mark —— @property(nonatomic,assign)MKDataBlock viewBlock;
-(MKDataBlock)viewBlock{
    return objc_getAssociatedObject(self, UIView_CallBackInfoByBlock_viewBlock);
}

-(void)setViewBlock:(MKDataBlock)viewBlock{
    objc_setAssociatedObject(self,
                             UIView_CallBackInfoByBlock_viewBlock,
                             viewBlock,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
