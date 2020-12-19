//
//  UserDefaultModel.h
//  DouDong-II
//
//  Created by Jobs on 2020/12/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDefaultModel : NSObject
// 对象
@property(nonatomic,strong,nullable)id obj;
// 基本数据类型
@property(nonatomic,assign)int intValue;
@property(nonatomic,assign)float floatValue;
@property(nonatomic,assign)BOOL booLValue;
@property(nonatomic,assign)NSInteger NSIntValue;
@property(nonatomic,assign)CGFloat CGfloatValue;
// key
@property(nonatomic,strong,nonnull)NSString *key;

@end

NS_ASSUME_NONNULL_END
