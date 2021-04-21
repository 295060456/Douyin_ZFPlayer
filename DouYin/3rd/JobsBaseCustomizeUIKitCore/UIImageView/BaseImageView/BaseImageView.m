//
//  BaseImageView.m
//  KJBannerViewDemo
//
//  Created by 杨科军 on 2021/2/19.
//  Copyright © 2021 杨科军. All rights reserved.
//

#import "BaseImageView.h"

@interface BaseImageView ()

@end

@implementation BaseImageView

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}
//具体由子类进行复写【数据定UI】
-(void)richElementsInViewWithModel:(id _Nullable)model{}
//具体由子类进行复写【数据定高】
+(CGFloat)viewHeightWithModel:(id _Nullable)model{
    return 0;
}
//具体由子类进行复写【数据尺寸】
+(CGSize)viewSizeWithModel:(id _Nullable)model{
    return CGSizeZero;
}
//具体由子类进行复写【数据Frame】
+(CGRect)viewFrameWithModel:(id _Nullable)model{
    return CGRectZero;
}
/*
    用于以此为基类的UIImageView的具体子类层所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockBaseImageView:(MKDataBlock)baseImageViewBlock{
    self.baseImageViewBlock = baseImageViewBlock;
}

@end
