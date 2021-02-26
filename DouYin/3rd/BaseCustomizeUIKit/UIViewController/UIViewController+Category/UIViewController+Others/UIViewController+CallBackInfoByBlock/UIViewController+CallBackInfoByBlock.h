//
//  UIViewController+CallBackInfoByBlock.h
//  DouDong-II
//
//  Created by Jobs on 2021/2/26.
//

#import <UIKit/UIKit.h>
#import "AABlock.h"

NS_ASSUME_NONNULL_BEGIN
// 用于UIViewController的回调,之所以写在分类，是方便最大限度的涵盖了所有的基于UIViewController子类
@interface UIViewController (CallBackInfoByBlock)

@property(nonatomic,assign)MKDataBlock viewControllerBlock;

-(void)actionViewControllerBlock:(MKDataBlock)viewControllerBlock;

@end

NS_ASSUME_NONNULL_END
