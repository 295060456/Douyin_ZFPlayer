//
//  BaseButton.h
//  DouDong-II
//
//  Created by Jobs on 2021/6/1.
//

#import <UIKit/UIKit.h>
#import "AABlock.h"
#import "BaseButtonProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseButton : UIButton<BaseButtonProtocol>

@property(nonatomic,copy)MKDataBlock baseButtonBlock;
/*
    用于以此为基类的View层上所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockBaseButton:(MKDataBlock)baseButtonBlock;

@end

NS_ASSUME_NONNULL_END
