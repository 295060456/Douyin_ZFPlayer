//
//  BaseVC+JXCategoryListContentViewDelegate.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC (JXCategoryListContentViewDelegate)
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
