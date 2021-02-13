//
//  UIView+EmptyData.h
//  DouDong-II
//
//  Created by Jobs on 2020/12/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (EmptyData)

@property(nonatomic,strong)UILabel *tipsLab;
@property(nonatomic,strong)NSString *tipsTitle;
-(void)ifEmptyData;

@end

NS_ASSUME_NONNULL_END
