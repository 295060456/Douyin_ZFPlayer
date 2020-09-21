//
//  BaseVC+BWShareView.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/9.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"
#import "BWShareView.h"

typedef enum : NSUInteger {
    BWShareViewStyle_1 = 0,//   有/无标题的单层分享
    BWShareViewStyle_2//    有/无标题的双层分享
} BWShareViewStyle;

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC (BWShareView)

/// 分享视图
@property(strong,nonatomic)BWShareView *shareView;
@property(assign,nonatomic)CGRect shareViewFrame;
@property(strong,nonatomic)NSMutableArray *shareViewDataMutArr;
@property(strong,nonatomic)NSMutableArray *shareViewDataMutSecArr;
@property(assign,nonatomic)BWShareViewStyle bWShareViewStyle;
@property(strong,nonatomic)NSString *shareTitle;

@end

NS_ASSUME_NONNULL_END
