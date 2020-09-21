//
//  BaseVC+JXCategoryListContentViewDelegate.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC+JXCategoryListContentViewDelegate.h"
#import <objc/runtime.h>

@implementation BaseVC (JXCategoryListContentViewDelegate)

//static char *BaseVC_JXCategoryListContentViewDelegate = "BaseVC_JXCategoryListContentViewDelegate";

#pragma mark —— JXCategoryListContentViewDelegate
/**
 如果列表是VC，就返回VC.view
 如果列表是View，就返回View自己

 @return 返回列表视图
 */
- (UIView *)listView{
    return self.view;
}

@end
