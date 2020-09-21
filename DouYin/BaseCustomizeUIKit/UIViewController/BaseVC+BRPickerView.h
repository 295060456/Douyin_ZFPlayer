//
//  BaseVC+BRStringPickerView.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC (BRPickerView)

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
