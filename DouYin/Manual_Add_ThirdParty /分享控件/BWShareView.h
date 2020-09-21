//
//  BWShareView.h
//  BWShareView
//
//  Created by syt on 2019/12/20.
//  Copyright © 2019 syt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BWItemModel;

NS_ASSUME_NONNULL_BEGIN

@interface BWShareView : UIView

/**
有/无标题的单层分享
*/
- (instancetype)initWithFrame:(CGRect)frame
                   shareTitle:(NSString *)shareTitle
                   shareArray:(NSArray *)shareArray;
/**
 有/无标题的双层分享
 */
- (instancetype)initWithFrame:(CGRect)frame
                   shareTitle:(NSString *)shareTitle
                   firstArray:(NSArray *)firstArray
                  secondArray:(NSArray *)secondArray;
/**
 显示
 */
- (void)show;
/**
 关闭
*/
- (void)removeChildView;

@property (nonatomic, copy) void (^shareItemClick) (BWItemModel *model);



@end

NS_ASSUME_NONNULL_END
