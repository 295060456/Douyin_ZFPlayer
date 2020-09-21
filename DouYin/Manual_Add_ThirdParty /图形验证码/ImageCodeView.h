//
//  ImageCodeView.h
//  XLVerCodeView
//
//  Created by Mac-Qke on 2019/7/9.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageCodeView : UIView

@property(nonatomic,copy)NSArray *CodeArr;
@property(nonatomic,copy)NSString *CodeStr;

@property(nonatomic,strong)UIColor *color;
@property(nonatomic,strong)UIFont *font;
@property(nonatomic,strong)UIColor *bgColor;//外界不传值定义内部即用随机色彩

-(void)actionBlockImageCodeView:(MKDataBlock)imageCodeViewBlock;

@end

NS_ASSUME_NONNULL_END
