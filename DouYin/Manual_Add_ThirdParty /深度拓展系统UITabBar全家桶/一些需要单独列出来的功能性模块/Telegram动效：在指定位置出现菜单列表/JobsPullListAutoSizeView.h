//
//  JobsPullListAutoSizeView.h
//  TabbarItemLottie
//
//  Created by Jobs on 2020/10/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JobsPullListAutoSizeView : UIView

@property(nonatomic,assign)CGFloat listTbVWidth;
@property(nonatomic,assign)CGFloat listTbVCellHeight;
@property(nonatomic,assign)CGFloat listTbVOffset;
@property(nonatomic,strong)UIColor *bgColorListTBV;

+ (instancetype)initWithTargetView:(UIView *__nonnull)targetView
                      imagesMutArr:(NSMutableArray <UIImage *>*__nullable)imagesMutArr
                       titleMutArr:(NSMutableArray <NSString *>*__nonnull)titleMutArr;

@end

NS_ASSUME_NONNULL_END
