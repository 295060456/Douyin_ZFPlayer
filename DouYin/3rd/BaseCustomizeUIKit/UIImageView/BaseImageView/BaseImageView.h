//
//  BaseImageView.h
//  KJBannerViewDemo
//
//  Created by 杨科军 on 2021/2/19.
//  Copyright © 2021 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseImageView : UIImageView<BaseViewProtocol>

@property(nonatomic,copy)MKDataBlock baseImageViewBlock;
/*
    用于以此为基类的UIImageView的具体子类层所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockBaseImageView:(MKDataBlock)baseImageViewBlock;

@end

NS_ASSUME_NONNULL_END
