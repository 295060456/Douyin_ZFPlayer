//
//  SuspendLab.h
//  Search
//
//  Created by Jobs on 2020/8/13.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuspendLab : UILabel

@property(nonatomic,assign)BOOL isAllowDrag;//是否允许托拽手势
@property(nonatomic,copy)MKDataBlock suspendLabBlock;

-(void)actionSuspendViewBlock:(MKDataBlock)suspendLabBlock;

@end

NS_ASSUME_NONNULL_END
/**
使用方法：
 在需要作用的UIView的子类
 
 @property(nonatomic,weak)UIViewController *vcer;//这个属性掌管悬浮效果，具体实现见  @interface UIView (SuspendView)
 
 -(void)drawRect:(CGRect)rect{
     [super drawRect:rect];
     if (self.isSuspend) {
         //开启悬浮效果
         self.vc = self.vcer;
         self.panRcognize.enabled = YES;
     }else{
         self.vc = nil;
     }
 }

*/
