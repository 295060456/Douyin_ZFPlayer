//
//  UIViewController+JXCategoryListContentViewDelegate.h
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import <UIKit/UIKit.h>
#import "JXCategoryView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (JXCategoryListContentViewDelegate)
<
JXCategoryListContentViewDelegate
>

/**
 如果列表是VC，就返回VC.view
 如果列表是View，就返回View自己

 @return 返回列表视图
 */
- (UIView *)listView;

@end

NS_ASSUME_NONNULL_END
