//
//  UIViewController+BRPickerView.h
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import <UIKit/UIKit.h>
#import "BRPickerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (BRPickerView)

#pragma mark —— BaseVC+BRStringPickerView
@property(nonatomic,strong)BRStringPickerView *stringPickerView;
@property(nonatomic,assign)BRStringPickerMode brStringPickerMode;
@property(nonatomic,copy)MKDataBlock brStringPickerViewBlock;
@property(nonatomic,strong)NSArray *BRStringPickerViewDataMutArr;

@property(nonatomic,strong)BRDatePickerView *datePickerView;//时间选择器
@property(nonatomic,strong)BRPickerStyle *customStyle;
@property(nonatomic,strong)BRAddressPickerView *addressPickerView;//地址选择器

-(void)BRStringPickerViewBlock:(MKDataBlock)block;

@end

NS_ASSUME_NONNULL_END
