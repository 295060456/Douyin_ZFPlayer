//
//  NSObject+DataSave.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/3.
//

#import <Foundation/Foundation.h>
#import "FileFolderHandleTool.h"

NS_ASSUME_NONNULL_BEGIN
// 本工具类是对FileFolderHandleTool的再一次封装，目的是尽可能不要去关注过于底层交互化的FileFolderHandleTool，避免痛苦
@interface NSObject (DataSave)

/// 存数据，储存成功返回地址
/// @param data 被储存的数据
/// @param documentsChildDir 在documents旗下的子文件夹名，也可以不用子文件夹进行管理
/// @param fileFullname 对应写入的文件带后缀的全民
/// @param error 错误抛出
+(NSString *_Nullable)saveData:(id _Nonnull)data
         withDocumentsChildDir:(NSString *_Nullable)documentsChildDir
                  fileFullname:(NSString *_Nonnull)fileFullname
                         error:(NSError *__autoreleasing *)error;

@end

NS_ASSUME_NONNULL_END
