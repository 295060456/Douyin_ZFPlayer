//
//  NSObject+DataSave.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/3.
//

#import "NSObject+DataSave.h"

@implementation NSObject (DataSave)

/// 存数据，储存成功返回地址
/// @param data 被储存的数据
/// @param documentsChildDir 在documents旗下的子文件夹名，也可以不用子文件夹进行管理
/// @param fileFullname 对应写入的文件带后缀的全民
/// @param error 错误抛出
+(NSString *_Nullable)saveData:(id _Nonnull)data
         withDocumentsChildDir:(NSString *_Nullable)documentsChildDir
                  fileFullname:(NSString *_Nonnull)fileFullname
                         error:(NSError *__autoreleasing *)error{
    // 文件夹路径
    if ([NSString isNullString:documentsChildDir]) {
        documentsChildDir = @"";
    }
    NSString *folderPath = [NSString stringWithFormat:@"%@/%@",FileFolderHandleTool.documentsDir,documentsChildDir];
    // 创建文件夹
    [FileFolderHandleTool createFoldByFolderUrl:folderPath error:error];
    // 文件全名带后缀路径
    NSString *localFileFullNameStr = [NSString stringWithFormat:@"%@/%@",folderPath,fileFullname];
    // 在此文件夹下创建空白文件
    BOOL k = [FileFolderHandleTool createFileWithFolderAtPath:localFileFullNameStr
                                                 contentsData:nil
                                                    overwrite:YES
                                                        error:error];
    BOOL Q = NO;
    if (k) {
        //写文件。
        Q = [FileFolderHandleTool writeFileAtPath:localFileFullNameStr
                                          content:data
                                            error:error];
    }
    
    if (Q) {
        return localFileFullNameStr;
    }else{
        return @"";
    }
}

@end
