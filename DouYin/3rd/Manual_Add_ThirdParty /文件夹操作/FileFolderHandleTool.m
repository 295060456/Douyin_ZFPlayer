//
//  FileFolderHandleTool.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/27.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "FileFolderHandleTool.h"

@implementation FileFolderHandleTool

#pragma mark —— 禁止App系统文件夹document同步
///因为它会同步。苹果要求：可重复产生的数据不得进行同步,什么叫做可重复数据？这里最好禁止，否则会影响上架，被拒！
+(void)banSysDocSynchronization{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSURL *URL = [NSURL fileURLWithPath:path];
    [URL setResourceValue:@(YES)
                   forKey:NSURLIsExcludedFromBackupKey
                    error:nil];
}
#pragma mark —— iOS获取文件的 文件名 和 后缀
///从路径中获得完整的文件名 （带后缀）
+(NSString *)getFullFileName:(NSString *)filePath{
    NSString *fullFileName = [filePath lastPathComponent];
    return fullFileName;
}
///从路径中获得完整的文件名 （不带后缀）
+(NSString *)getOnlyFileName:(NSString *)filePath{
    NSString *onlyFileName = [[FileFolderHandleTool getFullFileName:filePath] stringByDeletingPathExtension];
    return onlyFileName;
}
///从路径中获得文件完整的后缀名 （不带'.'）
+(NSString *)getSuffixFileName:(NSString *)filePath{
    NSString *suffix = [[FileFolderHandleTool getFullFileName:filePath] pathExtension];
    return suffix;
}
#pragma mark —— 目录获取
///获取沙盒的主目录路径：
+(NSString *)homeDir {
    return NSHomeDirectory();
}
///获取真机沙盒中Documents的目录路径：
+(NSString *)documentsDir{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                NSUserDomainMask,
                                                YES) firstObject];
}
///获取沙盒中Library的目录路径：
+(NSString *)libraryDir{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                NSUserDomainMask,
                                                YES) lastObject];
}
///获取沙盒中Libarary/Preferences的目录路径：
+(NSString *)preferencesDir{
    NSString *libraryDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                                NSUserDomainMask,
                                                                YES) lastObject];
    return [libraryDir stringByAppendingPathComponent:@"Preferences"];
}
///获取沙盒中Library/Caches的目录路径：
+(NSString *)cachesDir{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                NSUserDomainMask,
                                                YES)
            firstObject];
}
/// 获取沙盒中tmp的目录路径：供系统使用，程序员不要使用，因为随时会被销毁
+(NSString *)tmpDir{
    return NSTemporaryDirectory();
}
#pragma mark - 创建Library/Caches下的文件夹📂路径 还未真正创建
/// 以当前时间戳生成缓存路径 Library/Caches：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除。一般存放体积比较大，不是特别重要的资源。
/// @param folderNameEx 中间层自定义的文件夹
/// @param fileNameEx 文件后缀名
+(NSString *)createCacheFolderPath:(NSString * __nullable)folderNameEx
                            fileEx:(NSString * __nullable)fileNameEx{
    NSString *folderName = TimeModel.new.currentTimestampStr;
    NSString *cachePath;
    if ([NSString isNullString:folderNameEx]) {
        // Library/Caches/时间戳
        cachePath = [[FileFolderHandleTool cachesDir] stringByAppendingPathComponent:folderName];
    }else{
        if ([NSString isNullString:fileNameEx]) {
            // Library/Caches/folderNameEx/时间戳
            cachePath = [[FileFolderHandleTool cachesDir] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",folderNameEx,folderName]];
        }else{
            // Library/Caches/folderNameEx/时间戳.fileNameEx
            NSString *FolderName = [folderName stringByAppendingString:fileNameEx];
            cachePath = [[FileFolderHandleTool cachesDir] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",folderNameEx,FolderName]];
        }
    }return cachePath;
}
#pragma mark —— 创建文件（夹）
///软性 仅仅是创建文件夹：返回是否创建成功
+(BOOL)createDirectoryAtPath:(NSString *)path
                       error:(NSError *__autoreleasing *)error {
    NSFileManager *manager = [NSFileManager defaultManager];
    /* createDirectoryAtPath:withIntermediateDirectories:attributes:error:
     * 参数1：创建的文件夹的路径
     * 参数2：是否创建媒介的布尔值，一般为YES
     * 参数3: 属性，没有就置为nil
     * 参数4: 错误信息
    */
    BOOL isSuccess = [manager createDirectoryAtPath:path
                        withIntermediateDirectories:YES
                                         attributes:nil
                                              error:error];
    if (error) {
        NSLog(@"createDirectoryAtPath_err = %@",(*error).description);
    }return isSuccess;
}
/// 创建带文件夹的文件 返回是否创建带文件夹的文件成功状态
/// @param path 文件创建的路径
/// @param contentsData 写入文件的内容
/// @param overwrite 假如已经存在此文件是(YES)否(NO)覆盖
/// @param error 错误信息
+(BOOL)createFileWithFolderAtPath:(NSString *)path
                     contentsData:(NSData *_Nullable)contentsData
                        overwrite:(BOOL)overwrite
                            error:(NSError *__autoreleasing *)error{
///先讨论是否存在此路径的文件夹？
//file_url是文件的全路径。外层拼接好，如果返回YES则file_url可用
    
    if ([FileFolderHandleTool createFolderByFileUrl:path
                                              error:error]) {
        ///下面是对文件夹存在的情况进行说明
        // 如果文件存在，并不想覆盖，那么直接返回YES。
        if (!overwrite) {
#warning 这里可能有点疑问
            return YES;
        }else{
            /*创建文件
             *参数1：创建文件的路径
             *参数2：创建文件的内容（NSData类型）
             *参数3：文件相关属性
             
             返回 创建文件是(YES)否(NO)成功？
             */
             return [[NSFileManager defaultManager] createFileAtPath:path//文件的路径
                                                            contents:contentsData//文件的二进制内容（NSData）
                                                          attributes:nil];//文件的属性
        }
    }return NO;
}
/* 硬性创建文件夹
 * 给定一个具体的精确到文件📃的路径地址
 * 不管他是否存在与否，强制性的创建出来
 * file_url是文件的全路径。外层拼接好，如果返回YES则file_url可用
 */
+(BOOL)createFolderByFileUrl:(NSString *)file_url
                       error:(NSError *__autoreleasing *)error{
    //删除最后一个路径节点，提取父文件夹的路径
    NSString *directoryPath = [FileFolderHandleTool directoryAtPath:file_url];
    //创建目录
    //如果文件夹路径不存在，那么先创建文件夹
    return [FileFolderHandleTool createFoldByFolderUrl:directoryPath
                                                 error:error];
}
/* 硬性创建文件夹
* 给定一个具体的精确到文件夹📂的路径地址
* 不管他是否存在与否，强制性的创建出来
* file_url是文件的全路径。外层拼接好，如果返回YES则file_url可用
*/
+(BOOL)createFoldByFolderUrl:(NSString *)folder_url
                       error:(NSError *__autoreleasing *)error{
    //创建目录
    //如果文件夹路径不存在，那么先创建文件夹
    if (![FileFolderHandleTool isExistsAtPath:folder_url]) {
        // 创建文件夹，返回文件夹是否创建成功：先有文件夹再有文件，没有文件夹就没有文件
        if (![FileFolderHandleTool createDirectoryAtPath:folder_url
                                   error:error]) {
            return NO;
        }return YES;
    }return YES;
}
///获取文件创建的时间
+(NSDate *)creationDateOfItemAtPath:(NSString *)path
                              error:(NSError *__autoreleasing *)error {
    return (NSDate *)[FileFolderHandleTool attributeOfItemAtPath:path
                                          forKey:NSFileCreationDate
                                           error:error];
}
///获取文件修改的时间
+(NSDate *)modificationDateOfItemAtPath:(NSString *)path
                                  error:(NSError *__autoreleasing *)error {
    return (NSDate *)[FileFolderHandleTool attributeOfItemAtPath:path
                                          forKey:NSFileModificationDate
                                           error:error];
}
#pragma mark —— 读取文件内容
/// 给定一个NSBundle地址和文件类型，获取返回里面的一个实体文件 默认是以本App mainBundle 为路径
/// @param bundleFileName 本App的mainBundle之下的Bundle实体名字
/// @param bundleFileSuffix 中间层路径：
/// @param fileType  获取的文件类型 因为要以不同的方式解析出数据
+(id)bundleFile:(NSString *__nullable)bundleFileName
bundleFileSuffix:(NSString *__nonnull)bundleFileSuffix
       fileType:(FileType)fileType{
    //获取bundle路径
    NSString *bundlePath = NSBundle.mainBundle.bundlePath;
    
    if (![NSString isNullString:bundleFileName]) {
        bundlePath = [bundlePath stringByAppendingString:[NSString stringWithFormat:@"/%@%@",bundleFileName,@".bundle"]];
    }
    
    if (![NSString isNullString:bundleFileSuffix]) {
        bundlePath = [bundlePath stringByAppendingString:bundleFileSuffix];
    }
    return [FileFolderHandleTool filePath:bundlePath
                                 fileType:fileType];
}
/// 给定一个地址读取内容
/// @param filePath 文件全路径
/// @param fileType 获取的文件类型 因为要以不同的方式解析出数据
+(id)filePath:(NSString *__nonnull)filePath
     fileType:(FileType)fileType{
    if ([NSString isNullString:filePath]) {
        NSLog(@"文件路径不存在");
        return nil;
    }else{
        switch (fileType) {
            case TXT:{
                NSString *string = [[NSString alloc] initWithContentsOfFile:filePath
                                                                   encoding:NSUTF8StringEncoding
                                                                      error:nil];
                return string;
            }break;
            case IMAGE:{
                UIImage *img = [UIImage imageWithContentsOfFile:filePath];
                return img;
            }break;
            case VIDEO:{
                NSData *movieData = [NSData dataWithContentsOfFile:filePath];
                return movieData;
            }break;
            case SOUND:{
                AVURLAsset *mp3Asset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:filePath] options:nil];
                NSData *mp3Data = [NSData dataWithContentsOfURL:mp3Asset.URL];
                return mp3Data;
            }break;
            case PLIST:{
                NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:filePath];
                return dic;
            }break;
                
            default:
                return nil;
                break;
        }
    }
}
#pragma mark —— 写文件内容
/// 将bundle里面的文件写进手机本地文件，返回路径
/// @param bundleFileName  bundle文件名
/// @param LocalFileName 被写入的本地文件名 前提要有空白文件，否则写入失败
/// @param LocalFileSuffix 中间层路径：
/// @param fileType 获取的文件类型 因为要以不同的方式解析出数据
/// @param error 错误抛出
+(NSString *)bundleFile:(NSString *__nullable)bundleFileName
            toLocalFile:(NSString *)LocalFileName
        localFileSuffix:(NSString *__nonnull)LocalFileSuffix
               fileType:(FileType)fileType
                  error:(NSError *__autoreleasing *)error{
    //获取bundle路径
    id content = [FileFolderHandleTool bundleFile:bundleFileName
                                 bundleFileSuffix:LocalFileSuffix
                                         fileType:fileType];
    
    //图片、文本、plist（字典）、视频、声音
    NSString *fileFolderPathStr = [FileFolderHandleTool createCacheFolderPath:nil
                                                                       fileEx:nil];
    //写文件之前一定要 有空白文件可写。
    //文件全名 带后缀
    NSString *localFileFullNameStr = [NSString stringWithFormat:@"/%@.%@",LocalFileName,LocalFileSuffix];
    //先创建空白文件
    bool b = [FileFolderHandleTool createFileWithFolderAtPath:[fileFolderPathStr stringByAppendingString:localFileFullNameStr]
                                                 contentsData:nil
                                                    overwrite:YES
                                                        error:error];
    bool d = NO;
    if (b) {
        //写文件。
        NSString *ff = [NSString stringWithFormat:@"%@%@",fileFolderPathStr,localFileFullNameStr];
        d = [FileFolderHandleTool writeFileAtPath:ff
                                          content:content
                                            error:error];
    }return fileFolderPathStr = d? fileFolderPathStr : nil;
}
/// 写入文件内容：按照文件路径向文件写入内容，内容可为数组、字典、NSData等等，返回写入成功与否的状态
/// @param path 要写入的文件路径
/// @param content 要写入的文件内容
/// @param error 错误信息抛出
+(BOOL)writeFileAtPath:(NSString *)path
               content:(NSObject *)content
                 error:(NSError *__autoreleasing *)error{
    //判断文件内容是否为空
    if (!content) {
        [NSException raise:@"非法的文件内容" format:@"文件内容不能为nil"];
        return NO;
    }
    //判断文件(夹)是否存在
    if ([FileFolderHandleTool isExistsAtPath:path]) {
        if ([content isKindOfClass:NSMutableArray.class]) {//文件内容为可变数组
            return [(NSMutableArray *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:NSArray.class]) {//文件内容为不可变数组
            return [(NSArray *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:NSMutableData.class]) {//文件内容为可变NSMutableData
            return [(NSMutableData *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:NSData.class]) {//文件内容为NSData
            return [(NSData *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:NSMutableDictionary.class]) {//文件内容为可变字典
            return [(NSMutableDictionary *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:NSDictionary.class]) {//文件内容为不可变字典
            return [(NSDictionary *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:NSJSONSerialization.class]) {//文件内容为JSON类型
            return [(NSDictionary *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:NSMutableString.class]) {//文件内容为可变字符串
            return [[((NSString *)content) dataUsingEncoding:NSUTF8StringEncoding] writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:NSString.class]) {//文件内容为不可变字符串
            return [[((NSString *)content) dataUsingEncoding:NSUTF8StringEncoding] writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:UIImage.class]) {//文件内容为图片 保存为PNG
            return [UIImagePNGRepresentation((UIImage *)content) writeToFile:path atomically:YES];
        }else if ([content conformsToProtocol:@protocol(NSCoding)]) {//文件归档
//            [NSKeyedArchiver archiveRootObject:content toFile:path];//API_DEPRECATED
            [NSKeyedArchiver archivedDataWithRootObject:content
                                  requiringSecureCoding:NO
                                                  error:error];
        }else {
            [NSException raise:@"非法的文件内容"
                        format:@"文件类型%@异常，无法被处理。", NSStringFromClass([content class])];
            return NO;
        }
    }else {
        NSLog(@"文件路径不存在");
        return NO;
    }return YES;
}
#pragma mark —— 删除文件（夹）
/// 删除指定后缀名的文件
/// @param pathArr 这个文件夹下面的内容进行删除 非递归删除
/// @param fileSuffix 传需要删除的文件的后缀名，如果需要全部删除就传nil
+(void)delFile:(NSArray *)pathArr
    fileSuffix:(NSString *_Nullable)fileSuffix
         error:(NSError *__autoreleasing *)error{
    NSString *extension = fileSuffix;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = pathArr;
    NSString *documentsDirectory = [paths objectAtIndex:0];
     
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:error];
    NSEnumerator*e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        if (extension) {
            if ([[filename pathExtension] hasPrefix:extension]) {
                [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:error];
            }
        }else{
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:error];
        }
    }
}
///删除文件（夹）
+(BOOL)removeItemAtPath:(NSString *)path
                  error:(NSError *__autoreleasing *)error{
    return [[NSFileManager defaultManager] removeItemAtPath:path
                                                      error:error];
}
///给定一个路径，删除旗下所有东西
+(void)cleanFilesWithPath:(NSString *)PathStr{
    /**
     函数说明：unlink()会删除参数pathname 指定的文件. 如果该文件名为最后连接点, 但有其他进程打开了此文件, 则在所有关于此文件的文件描述词皆关闭后才会删除. 如果参数pathname 为一符号连接, 则此连接会被删除。
     返回值：成功则返回0, 失败返回-1, 错误原因存于errno

     错误代码：
     1、EROFS 文件存在于只读文件系统内。
     2、EFAULT 参数pathname 指针超出可存取内存空间。
     3、ENAMETOOLONG 参数pathname 太长。
     4、ENOMEM 核心内存不足。
     5、ELOOP 参数pathname 有过多符号连接问题。
     6、EIO I/O 存取错误
     */
    unlink([PathStr UTF8String]);
}
///清空Cashes文件夹
+(BOOL)clearCachesDirectory{
    NSArray *subFiles = [TXFileOperation listFilesInCachesDirectoryByDeep:NO];
    BOOL isSuccess = YES;

    for (NSString *file in subFiles) {
        NSString *absolutePath = [[FileFolderHandleTool cachesDir] stringByAppendingPathComponent:file];
        isSuccess &= [TXFileOperation removeItemAtPath:absolutePath];
    }return isSuccess;
}
///清空temp文件夹
+(BOOL)clearTmpDirectory{
    NSArray *subFiles = [TXFileOperation listFilesInTmpDirectoryByDeep:NO];
    BOOL isSuccess = YES;

    for (NSString *file in subFiles) {
        NSString *absolutePath = [[FileFolderHandleTool tmpDir] stringByAppendingPathComponent:file];
        isSuccess &= [TXFileOperation removeItemAtPath:absolutePath];
    }return isSuccess;
}
#pragma mark —— 复制文件（夹）
///复制文件 依据源文件的路径复制一份到目标路径：
/*参数1、被复制文件路径
 *参数2、要复制到的目标文件路径
 *参数3、当要复制到的文件路径文件存在，会复制失败，这里传入是否覆盖
 *参数4、错误信息
 */
+(BOOL)copyItemAtPath:(NSString *)path
                toPath:(NSString *)toPath
             overwrite:(BOOL)overwrite
                 error:(NSError *__autoreleasing *)error {
    // 先要保证源文件路径存在，不然抛出异常
    if (![FileFolderHandleTool isExistsAtPath:path]) {
        [NSException raise:@"非法的源文件路径"
                    format:@"源文件路径%@不存在，请检查源文件路径", path];
        return NO;
    }
    //获得目标文件的上级目录
    NSString *toDirPath = [FileFolderHandleTool directoryAtPath:toPath];
    if (![FileFolderHandleTool isExistsAtPath:toDirPath]) {
        // 创建复制路径
        if (![FileFolderHandleTool createDirectoryAtPath:toDirPath
                                   error:error]) {
            return NO;
        }
    }
    // 如果覆盖，那么先删掉原文件
    if (overwrite) {
        if ([FileFolderHandleTool isExistsAtPath:toPath]) {
            [FileFolderHandleTool removeItemAtPath:toPath
                                             error:error];
        }
    }
    // 复制文件，如果不覆盖且文件已存在则会复制失败
    BOOL isSuccess = [[NSFileManager defaultManager] copyItemAtPath:path
                                                             toPath:toPath
                                                              error:error];
    return isSuccess;
}
#pragma mark —— 移动文件（夹）
/// 移动文件(夹) 依据源文件的路径移动到目标路径：
/// @param path 被移动文件路径
/// @param toPath 要移动到的目标文件路径
/// @param overwrite 当要移动到的文件路径文件存在，会移动失败，这里传入是否覆盖
/// @param error 错误信息抛出
+(BOOL)moveItemAtPath:(NSString *)path
                toPath:(NSString *)toPath
             overwrite:(BOOL)overwrite
                 error:(NSError *__autoreleasing *)error {
    // 先要保证源文件路径存在，不然抛出异常
    if (![FileFolderHandleTool isExistsAtPath:path]) {
        [NSException raise:@"非法的源文件路径"
                    format:@"源文件路径%@不存在，请检查源文件路径", path];
        return NO;
    }
    //获得目标文件的上级目录
    NSString *toDirPath = [FileFolderHandleTool directoryAtPath:toPath];
    if (![FileFolderHandleTool isExistsAtPath:toDirPath]) {
        // 创建移动路径
        if (![FileFolderHandleTool createDirectoryAtPath:toDirPath error:error]) {
            return NO;
        }
    }
    // 判断目标路径文件是否存在
    if ([FileFolderHandleTool isExistsAtPath:toPath]){
        //如果覆盖，删除目标路径文件
        if (overwrite) {
            //删掉目标路径文件
            [FileFolderHandleTool removeItemAtPath:toPath error:error];
        }else {
           //删掉被移动文件
            [FileFolderHandleTool removeItemAtPath:path error:error];
            return YES;
        }
    }
    // 移动文件，当要移动到的文件路径文件存在，会移动失败
    BOOL isSuccess = [[NSFileManager defaultManager] moveItemAtPath:path
                                                             toPath:toPath
                                                              error:error];
    return isSuccess;
}
#pragma mark —— 根据URL获取文件名
/*参数1：文件路径
 *参数2、是否需要后缀
 */
+(NSString *)fileNameAtPath:(NSString *)path
                      suffix:(BOOL)suffix {
    NSString *fileName = [path lastPathComponent];
    if (!suffix) {
        fileName = [fileName stringByDeletingPathExtension];
    }return fileName;
}
/// 获取文件所在的文件夹路径：删除最后一个路径节点
+(NSString *)directoryAtPath:(NSString *)path {
    return [path stringByDeletingLastPathComponent];
}
/// 根据文件路径获取文件扩展类型:
+(NSString *)suffixAtPath:(NSString *)path {
    return [path pathExtension];
}
#pragma mark —— 判断文件（夹）是否存在
///判断文件路径是否存在:
+(BOOL)isExistsAtPath:(NSString *)path{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}
///判断路径是否为空（判空条件是文件大小为0，或者是文件夹下没有子文件）:
+(BOOL)isEmptyItemAtPath:(NSString *)path
                    error:(NSError *__autoreleasing *)error {
    return ([FileFolderHandleTool isFileAtPath:path error:error] &&
            [[FileFolderHandleTool sizeOfItemAtPath:path error:error] intValue] == 0) ||
    ([FileFolderHandleTool isDirectoryAtPath:path error:error] &&
     [[FileFolderHandleTool listFilesInDirectoryAtPath:path deep:NO] count] == 0);
}
///判断目录是否是文件夹：
+(BOOL)isDirectoryAtPath:(NSString *)path
                    error:(NSError *__autoreleasing *)error {
    return ([FileFolderHandleTool attributeOfItemAtPath:path forKey:NSFileType error:error] == NSFileTypeDirectory);
}
///判断目录是否是文件:
+(BOOL)isFileAtPath:(NSString *)path
               error:(NSError *__autoreleasing *)error {
    return ([FileFolderHandleTool attributeOfItemAtPath:path forKey:NSFileType error:error] == NSFileTypeRegular);
}
///判断目录是否可以执行:
+(BOOL)isExecutableItemAtPath:(NSString *)path{
    return [[NSFileManager defaultManager] isExecutableFileAtPath:path];
}
///判断目录是否可读:
+(BOOL)isReadableItemAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] isReadableFileAtPath:path];
}
///判断目录是否可写:
+(BOOL)isWritableItemAtPath:(NSString *)path{
    return [[NSFileManager defaultManager] isWritableFileAtPath:path];
}
#pragma mark —— 获取文件（夹）大小
///获取文件大小（NSNumber）:
+(NSNumber *)sizeOfItemAtPath:(NSString *)path
                        error:(NSError *__autoreleasing *)error {
    return (NSNumber *)[FileFolderHandleTool attributeOfItemAtPath:path
                                                            forKey:NSFileSize
                                                             error:error];
}
///获取文件夹大小（NSNumber）:
+(NSNumber *)sizeOfDirectoryAtPath:(NSString *)path
                             error:(NSError *__autoreleasing *)error {
    if ([FileFolderHandleTool isDirectoryAtPath:path error:error]) {
       //深遍历文件夹
        NSArray *subPaths = [FileFolderHandleTool listFilesInDirectoryAtPath:path deep:YES];
        NSEnumerator *contentsEnumurator = [subPaths objectEnumerator];
        
        NSString *file;
        unsigned long long int folderSize = 0;
        
        while (file = [contentsEnumurator nextObject]) {
            NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[path stringByAppendingPathComponent:file]
                                                                                            error:nil];
            folderSize += [[fileAttributes objectForKey:NSFileSize] intValue];
        }
        return [NSNumber numberWithUnsignedLongLong:folderSize];
    }return nil;
}
///获取文件大小（单位为字节）:
+(NSString *)sizeFormattedOfItemAtPath:(NSString *)path
                                 error:(NSError *__autoreleasing *)error {
    //先获取NSNumber类型的大小
    NSNumber *size = [FileFolderHandleTool sizeOfItemAtPath:path
                                      error:error];
    if (size) {
       //将文件大小格式化为字节
        return [FileFolderHandleTool sizeFormatted:size];
    }return nil;
}
///将文件大小格式化为字节
+(NSString *)sizeFormatted:(NSNumber *)size{
    /*NSByteCountFormatterCountStyle枚举
     *NSByteCountFormatterCountStyleFile 字节为单位，采用十进制的1000bytes = 1KB
     *NSByteCountFormatterCountStyleMemory 字节为单位，采用二进制的1024bytes = 1KB
     *NSByteCountFormatterCountStyleDecimal KB为单位，采用十进制的1000bytes = 1KB
     *NSByteCountFormatterCountStyleBinary KB为单位，采用二进制的1024bytes = 1KB
     */
    return [NSByteCountFormatter stringFromByteCount:[size unsignedLongLongValue]
                                          countStyle:NSByteCountFormatterCountStyleFile];
}
///获取文件夹大小（单位为字节）:
+(NSString *)sizeFormattedOfDirectoryAtPath:(NSString *)path
                                      error:(NSError *__autoreleasing *)error {
    //先获取NSNumber类型的大小
    NSNumber *size = [FileFolderHandleTool sizeOfDirectoryAtPath:path error:error];
    if (size) {
        return [FileFolderHandleTool sizeFormatted:size];
    }return nil;
}
#pragma mark —— 遍历文件夹(分为深遍历和浅遍历：)
/**
 文件遍历
 参数1：目录的绝对路径
 参数2：是否深遍历 (1. 浅遍历：返回当前目录下的所有文件和文件夹；
 2. 深遍历：返回当前目录下及子目录下的所有文件和文件夹)
 */
+ (NSArray *)listFilesInDirectoryAtPath:(NSString *)path
                                   deep:(BOOL)deep {
    NSArray *listArr;
    NSError *error;
    NSFileManager *manager = [NSFileManager defaultManager];
    if (deep) {
        // 深遍历
        NSArray *deepArr = [manager subpathsOfDirectoryAtPath:path
                                                        error:&error];
        if (!error) {
            listArr = deepArr;
        }else {
            listArr = nil;
        }
    }else {
        // 浅遍历
        NSArray *shallowArr = [manager contentsOfDirectoryAtPath:path
                                                           error:&error];
        if (!error) {
            listArr = shallowArr;
        }else {
            listArr = nil;
        }
    }return listArr;
}
#pragma mark —— 获取文件属性
///根据key获取文件某个属性：
//key的列表如下：
//FOUNDATION_EXPORT NSString * const NSFileType;
//FOUNDATION_EXPORT NSString * const NSFileTypeDirectory;
//FOUNDATION_EXPORT NSString * const NSFileTypeRegular;
//FOUNDATION_EXPORT NSString * const NSFileTypeSymbolicLink;
//FOUNDATION_EXPORT NSString * const NSFileTypeSocket;
//FOUNDATION_EXPORT NSString * const NSFileTypeCharacterSpecial;
//FOUNDATION_EXPORT NSString * const NSFileTypeBlockSpecial;
//FOUNDATION_EXPORT NSString * const NSFileTypeUnknown;
//FOUNDATION_EXPORT NSString * const NSFileSize;
//FOUNDATION_EXPORT NSString * const NSFileModificationDate;
//FOUNDATION_EXPORT NSString * const NSFileReferenceCount;
//FOUNDATION_EXPORT NSString * const NSFileDeviceIdentifier;
//FOUNDATION_EXPORT NSString * const NSFileOwnerAccountName;
//FOUNDATION_EXPORT NSString * const NSFileGroupOwnerAccountName;
//FOUNDATION_EXPORT NSString * const NSFilePosixPermissions;
//FOUNDATION_EXPORT NSString * const NSFileSystemNumber;
//FOUNDATION_EXPORT NSString * const NSFileSystemFileNumber;
//FOUNDATION_EXPORT NSString * const NSFileExtensionHidden;
//FOUNDATION_EXPORT NSString * const NSFileHFSCreatorCode;
//FOUNDATION_EXPORT NSString * const NSFileHFSTypeCode;
//FOUNDATION_EXPORT NSString * const NSFileImmutable;
//FOUNDATION_EXPORT NSString * const NSFileAppendOnly;
//FOUNDATION_EXPORT NSString * const NSFileCreationDate;
//FOUNDATION_EXPORT NSString * const NSFileOwnerAccountID;
//FOUNDATION_EXPORT NSString * const NSFileGroupOwnerAccountID;
//FOUNDATION_EXPORT NSString * const NSFileBusy;
//FOUNDATION_EXPORT NSString * const NSFileProtectionKey NS_AVAILABLE_IOS(4_0);
//FOUNDATION_EXPORT NSString * const NSFileProtectionNone NS_AVAILABLE_IOS(4_0);
//FOUNDATION_EXPORT NSString * const NSFileProtectionComplete NS_AVAILABLE_IOS(4_0);
//FOUNDATION_EXPORT NSString * const NSFileProtectionCompleteUnlessOpen NS_AVAILABLE_IOS(5_0);
//FOUNDATION_EXPORT NSString * const NSFileProtectionCompleteUntilFirstUserAuthentication NS_AVAILABLE_IOS(5_0);

+(id)attributeOfItemAtPath:(NSString *)path
                      forKey:(NSString *)key
                       error:(NSError *__autoreleasing *)error {
    return [[FileFolderHandleTool attributesOfItemAtPath:path
                                   error:error] objectForKey:key];
}
///获取文件属性集合:
+(NSDictionary *)attributesOfItemAtPath:(NSString *)path
                                   error:(NSError *__autoreleasing *)error {
    return [[NSFileManager defaultManager] attributesOfItemAtPath:path
                                                            error:error];
}
#pragma mark —— 系统相册相关
///获取相册最新加载（录制、拍摄）的资源
+(PHAsset *)gettingLastResource:(NSString *)Key{
    //获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = PHFetchOptions.new;
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:Key
                                                              ascending:NO]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    //这里取得的结果 assetsFetchResults 其实可以当做一个数组。
    //获取最新一张照片
    PHAsset *d = [assetsFetchResults firstObject];
    return d;
}
//相册
+(void)createAlbumFolder:(NSString *)folderName
       ifExitFolderBlock:(MKDataBlock)ifExitFolderBlock
       completionHandler:(TwoDataBlock)completionBlock{
    if (![FileFolderHandleTool isExistFolder:folderName]) {
        [PHPhotoLibrary.sharedPhotoLibrary performChanges:^{
            [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:folderName];
        } completionHandler:^(BOOL success,
                              NSError * _Nullable error) {
            if (completionBlock) {
                completionBlock(@(success),error);
            }
        }];
    }else{
        if (ifExitFolderBlock) {
            ifExitFolderBlock(@(YES));//文件夹存在说明至少曾经创建成功了
        }
    }
}
///创建一个名为folderName的相册，并且以路径pathStr保存文件
+(void)createAlbumFolder:(NSString *)folderName
                    path:(NSString *)pathStr{
    if (![FileFolderHandleTool isExistFolder:folderName]) {
        [PHPhotoLibrary.sharedPhotoLibrary performChanges:^{
            [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:folderName];
        } completionHandler:^(BOOL success,
                              NSError * _Nullable error) {
            if (success) {
                NSLog(@"创建相册文件夹成功!");
                [FileFolderHandleTool saveRes:[NSURL URLWithString:pathStr]];
            } else {
                NSLog(@"创建相册文件夹失败:%@", error);
            }
        }];
    }else [FileFolderHandleTool saveRes:[NSURL URLWithString:pathStr]];
}
///保存视频资源文件到指定的相册路径，这里是整个App名字的相册
+(void)saveRes:(NSURL *)movieURL{
    __block NSString *localIdentifier = Nil;//标识保存到系统相册中的标识
    PHFetchResult *collectonResuts = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];//首先获取相册的集合
    [collectonResuts enumerateObjectsUsingBlock:^(id obj,
                                                  NSUInteger idx,
                                                  BOOL *stop) {//对获取到集合进行遍历
        PHAssetCollection *assetCollection = obj;
        NSLog(@"LLL %@",assetCollection.localizedTitle);
        if ([assetCollection.localizedTitle isEqualToString:HDAppDisplayName])  {
            [PHPhotoLibrary.sharedPhotoLibrary performChanges:^{
                //请求创建一个Asset
                PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:movieURL];
                //请求编辑相册
                PHAssetCollectionChangeRequest *collectonRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
                //为Asset创建一个占位符，放到相册编辑请求中
                PHObjectPlaceholder *placeHolder = [assetRequest placeholderForCreatedAsset];
                //相册中添加视频
                [collectonRequest addAssets:@[placeHolder]];
                localIdentifier = placeHolder.localIdentifier;
            } completionHandler:^(BOOL success,
                                  NSError *error) {
                if (success) {
                    NSLog(@"保存视频成功!");
                    //保存视频成功 全局发通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"saveRes_success"
                                                                        object:nil];
                } else {
                    NSLog(@"保存视频失败:%@", error);
                }
            }];
        }
    }];
}
///是否存在此相册判断逻辑依据 注意和 isExistsAtPath进行区分
+(BOOL)isExistFolder:(NSString *)folderName{
    __block BOOL isExisted = NO;
    //首先获取用户手动创建相册的集合
    PHFetchResult *collectonResuts = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    //对获取到集合进行遍历
    //enumerateObjectsUsingBlock 不会自动开启新的线程,若开发者默认将代码写在主线程,则在主线程进行遍历, 写在子线程,则在子线程遍历
    [collectonResuts enumerateObjectsUsingBlock:^(id obj,
                                                  NSUInteger idx,
                                                  BOOL *stop) {
        PHAssetCollection *assetCollection = obj;
        if ([assetCollection.localizedTitle isEqualToString:folderName])  {
            isExisted = YES;
        }
    }];return isExisted;
}
///保存文件到系统默认的相册，image是要保存的图片
+(void)saveImage:(UIImage *)image{
    if (image) {
        UIImageWriteToSavedPhotosAlbum(image,
                                       self,
                                       @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:),
                                       nil);
    };
}
//保存完成后调用的方法
+(void)savedPhotoImage:(UIImage*)image
didFinishSavingWithError: (NSError *)error
            contextInfo: (void *)contextInfo {
    if (error) {
        NSLog(@"保存图片出错%@",error.localizedDescription);
    }else {
        NSLog(@"保存图片成功");
    }
}
///保存文件到系统默认的相册，videoPath为视频下载到本地之后的本地路径
+(void)saveVideo:(NSString *)videoPath{
    if (videoPath) {
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(videoPath)) {
            //保存相册核心代码
            UISaveVideoAtPathToSavedPhotosAlbum(videoPath,
                                                self,
                                                @selector(video:didFinishSavingWithError:contextInfo:),
                                                nil);
        }
    }
}
//保存视频完成之后的回调
+(void)video:(NSString *)videoPath
didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo {
    if (error) {
        NSLog(@"保存视频失败%@", error.localizedDescription);
    }else {
        NSLog(@"保存视频成功");
    }
}
///仅获取PHAsset里面的视频
+(void)getVideoFromPHAsset:(PHAsset *)phAsset
                  complete:(MKDataBlock)completeBlock{
    if (phAsset.mediaType == PHAssetMediaTypeVideo) {
        PHVideoRequestOptions *options = PHVideoRequestOptions.new;
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        
        PHImageManager *manager = PHImageManager.defaultManager;
        [manager requestAVAssetForVideo:phAsset options:options
                          resultHandler:^(AVAsset * _Nullable asset,
                                          AVAudioMix * _Nullable audioMix,
                                          NSDictionary * _Nullable info) {
            
            AVURLAsset *urlAsset = (AVURLAsset *)asset;
            FileFolderHandleModel *fileFolderHandleModel = FileFolderHandleModel.new;
            fileFolderHandleModel.asset = asset;
            fileFolderHandleModel.audioMix = audioMix;
            fileFolderHandleModel.info = info;
            fileFolderHandleModel.data = [FileFolderHandleTool AVAssetToData:asset];
            fileFolderHandleModel.image = [UIImage getVideoPreViewImage:urlAsset];
            if (completeBlock) {
                completeBlock(fileFolderHandleModel);
            }
        }];
    }
}
///获取PHAsset里面的相片
+(void)getPicFromPHAsset:(PHAsset *)phAsset
                complete:(MKDataBlock)completeBlock{
    if (phAsset.mediaType == PHAssetMediaTypeImage) {
        
    }
}
///获取PHAsset里面的声音
+(void)getAudioFromPHAsset:(PHAsset *)phAsset
                  complete:(MKDataBlock)completeBlock{
    if (phAsset.mediaType == PHAssetMediaTypeAudio) {
        
    }
}
///AVAsset 转 NSData
+(NSData *)AVAssetToData:(AVAsset *)asset{
    AVURLAsset *urlAsset = (AVURLAsset *)asset;
    NSURL *url = urlAsset.URL;
    NSData *data = [NSData dataWithContentsOfURL:url];
    return data;
}

@end

@implementation FileFolderHandleModel

@end
