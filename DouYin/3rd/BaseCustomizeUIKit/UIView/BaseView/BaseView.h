//
//  BaseView.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2021/2/5.
//  Copyright © 2021 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AABlock.h"
#import "BaseViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseView : UIView<BaseViewProtocol>

@property(nonatomic,copy)MKDataBlock baseViewBlock;
/*
    用于以此为基类的View层上所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockBaseView:(MKDataBlock)baseViewBlock;

@end

NS_ASSUME_NONNULL_END
