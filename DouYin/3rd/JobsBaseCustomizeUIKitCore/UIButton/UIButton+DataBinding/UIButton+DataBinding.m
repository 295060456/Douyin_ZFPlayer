//
//  UIButton+DataBinding.m
//  DouDong-II
//
//  Created by Jobs on 2021/3/13.
//

#import "UIButton+DataBinding.h"

@implementation UIButton (DataBinding)

static char *UIButton_DataBinding_requestParams = "UIButton_DataBinding_requestParams";
@dynamic requestParams;
#pragma mark —— @property(nonatomic,strong)id requestParams;
-(id)requestParams{
    id RequestParams = objc_getAssociatedObject(self, UIButton_DataBinding_requestParams);
    return RequestParams;
}

-(void)setRequestParams:(id)requestParams{
    objc_setAssociatedObject(self,
                             UIButton_DataBinding_requestParams,
                             requestParams,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
