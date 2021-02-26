//
//  NSObject+CallBackInfoByBlock.h
//  DouDong-II
//
//  Created by Jobs on 2021/2/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CallBackInfoByBlock)

@property(nonatomic,assign)MKDataBlock objectBlock;
@property(nonatomic,assign)MKDataBlock viewBlock;
@property(nonatomic,assign)MKDataBlock viewControllerBlock;

// 用于UIViewController数据的回调
-(void)actionViewControllerBlock:(MKDataBlock)viewControllerBlock;
// 用于UIView数据的回调
-(void)actionViewBlock:(MKDataBlock)viewBlock;
// 用于任何对象数据的回调
-(void)actionObjectBlock:(MKDataBlock)objectBlock;

@end

NS_ASSUME_NONNULL_END
