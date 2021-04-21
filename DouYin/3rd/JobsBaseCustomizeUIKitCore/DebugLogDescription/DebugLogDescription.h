//
//  DebugLogDescription.h
//  JobsComment
//
//  Created by Jobs on 2021/3/30.
//

#import <Foundation/Foundation.h>

#pragma mark ======================================== 日志打印 ========================================

#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

//#define DLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
