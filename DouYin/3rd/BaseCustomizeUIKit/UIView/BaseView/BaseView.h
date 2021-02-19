//
//  BaseView.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2021/2/5.
//  Copyright © 2021 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseView : UIView

//具体由子类进行复写【数据定UI】
-(void)richElementsInViewWithModel:(id _Nullable)model;
//具体由子类进行复写【数据定高】
+(CGFloat)viewHeightWithModel:(id _Nullable)model;
//具体由子类进行复写【数据尺寸】
+(CGSize)viewSizeWithModel:(id _Nullable)model;
//具体由子类进行复写【数据Frame】
+(CGRect)viewFrameWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
