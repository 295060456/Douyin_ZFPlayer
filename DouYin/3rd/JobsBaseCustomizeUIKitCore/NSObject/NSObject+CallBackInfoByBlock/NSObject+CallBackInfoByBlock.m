//
//  NSObject+CallBackInfoByBlock.m
//  DouDong-II
//
//  Created by Jobs on 2021/2/26.
//

#import "NSObject+CallBackInfoByBlock.h"
#import <objc/runtime.h>

@implementation NSObject (CallBackInfoByBlock)

static char *NSObject_CallBackInfoByBlock_objectBlock = "NSObject_CallBackInfoByBlock_objectBlock";
@dynamic objectBlock;

static char *NSObject_CallBackInfoByBlock_viewBlock = "NSObject_CallBackInfoByBlock_viewBlock";
@dynamic viewBlock;

static char *NSObject_CallBackInfoByBlock_viewControllerBlock = "NSObject_CallBackInfoByBlock_viewControllerBlock";
@dynamic viewControllerBlock;

-(void)actionObjectBlock:(MKDataBlock)objectBlock{
    self.objectBlock = objectBlock;
}

-(void)actionViewBlock:(MKDataBlock)viewBlock{
    self.viewBlock = viewBlock;
}

-(void)actionViewControllerBlock:(MKDataBlock)viewControllerBlock{
    self.viewControllerBlock = viewControllerBlock;
}
#pragma mark —— @property(nonatomic,assign)MKDataBlock objectBlock;
-(MKDataBlock)objectBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_objectBlock);
}

-(void)setObjectBlock:(MKDataBlock)objectBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_objectBlock,
                             objectBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)MKDataBlock viewBlock;
-(MKDataBlock)viewBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_viewBlock);
}

-(void)setViewBlock:(MKDataBlock)viewBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_viewBlock,
                             viewBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)MKDataBlock viewControllerBlock;
-(MKDataBlock)viewControllerBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_viewControllerBlock);
}

-(void)setViewControllerBlock:(MKDataBlock)viewControllerBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_viewControllerBlock,
                             viewControllerBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
