//
//  UIViewController+BWShareView.h
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import <UIKit/UIKit.h>
#import "BWShareView.h"

typedef enum : NSUInteger {
    BWShareViewStyle_1 = 0,//   有/无标题的单层分享
    BWShareViewStyle_2//    有/无标题的双层分享
} BWShareViewStyle;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (BWShareView)

/// 分享视图
@property(nonatomic,strong)BWShareView *shareView;
@property(nonatomic,assign)CGRect shareViewFrame;
@property(nonatomic,strong)NSMutableArray *shareViewDataMutArr;
@property(nonatomic,strong)NSMutableArray *shareViewDataMutSecArr;
@property(nonatomic,assign)BWShareViewStyle bWShareViewStyle;
@property(nonatomic,strong)NSString *shareTitle;

@end

NS_ASSUME_NONNULL_END
