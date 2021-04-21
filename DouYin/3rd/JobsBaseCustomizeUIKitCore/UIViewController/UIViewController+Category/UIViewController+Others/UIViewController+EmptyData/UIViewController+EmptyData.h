//
//  UIViewController+EmptyData.h
//  DouDong-II
//
//  Created by Jobs on 2020/12/17.
//

#import <UIKit/UIKit.h>
#import "UIView+EmptyData.h"

NS_ASSUME_NONNULL_BEGIN
// 当ViewController的view上啥也没有的时候，出现提示，方便调试
@interface UIViewController (EmptyData)

-(void)ifEmptyData;

@end

NS_ASSUME_NONNULL_END
