//
//  NSObject+Extras.m
//  TestDemo
//
//  Created by AaltoChen on 15/10/31.
//  Copyright © 2015年 AaltoChen. All rights reserved.
//

#import "NSObject+Extras.h"
#import <objc/runtime.h>
#import <sys/sysctl.h>
#import <mach/mach.h>

@implementation NSObject (Extras)

static char *NSObject_Extras_indexPath = "NSObject_Extras_indexPath";
static char *NSObject_Extras_currentPage = "NSObject_Extras_currentPage";

@dynamic _indexPath;
@dynamic _currentPage;
/// 震动特效反馈
+(void)feedbackGenerator{
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
        [generator prepare];
        [generator impactOccurred];
    } else {
        // Fallback on earlier versions
        AudioServicesPlaySystemSound(1520);
    }
}
/// 检测用户是否锁屏：根据屏幕光线来进行判定，而不是系统通知
+(BOOL)didUserPressLockButton{
    //获取屏幕亮度
    CGFloat oldBrightness = [UIScreen mainScreen].brightness;
    //以较小的数量改变屏幕亮度
    [UIScreen mainScreen].brightness = oldBrightness + (oldBrightness <= 0.01 ? (0.01) : (-0.01));
    CGFloat newBrightness  = [UIScreen mainScreen].brightness;
    //恢复屏幕亮度
    [UIScreen mainScreen].brightness = oldBrightness;
    //判断屏幕亮度是否能够被改变
    return oldBrightness != newBrightness;
}
/// iOS 限制自动锁屏 lockSwitch:YES(关闭自动锁屏)
+(void)autoLockedScreen:(BOOL)lockSwitch{
    [[UIApplication sharedApplication] setIdleTimerDisabled:lockSwitch];
}
/// 打印请求体
+(void)printRequestMessage:(NSURLSessionDataTask *)task{
    // 请求URL
    NSLog(@"请求URL:%@\n",task.originalRequest.URL);
    
    // 请求方式
    NSLog(@"请求方式:%@\n",task.originalRequest.HTTPMethod);
    
    // 请求头信息
    NSLog(@"请求头信息:%@\n",task.originalRequest.allHTTPHeaderFields);
    
    // 请求正文信息
    NSLog(@"请求正文信息:%@\n",[[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding]);
    
//    // 请求响应时间
//    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:NSDate.date];
//    NSLog(@"请求响应时间:%@\n",@(time));
//    NSLog(@"\n请求URL:%@\n请求方式:%@\n请求头信息:%@\n请求正文信息:%@\n请求响应时间:%@\n",task.originalRequest.URL,task.originalRequest.HTTPMethod,task.originalRequest.allHTTPHeaderFields,[[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding],@(time));
}

+(void)savePic:(GKPhotoBrowser *)browser{
    if (browser) {
        GKPhoto *photo = browser.photos[browser.currentIndex];
        
        NSData *imageData = nil;
        
        if ([photo.image isKindOfClass:[SDAnimatedImage class]]) {
            imageData = [(SDAnimatedImage *)photo.image animatedImageData];
        }else if ([photo.image isKindOfClass:[YYImage class]]) {
            imageData = [(YYImage *)photo.image animatedImageData];
        }else {
            imageData = [photo.image sd_imageData];
        }
        
        if (!imageData) return;
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            if (@available(iOS 9, *)) {
                PHAssetCreationRequest *request = [PHAssetCreationRequest creationRequestForAsset];
                [request addResourceWithType:PHAssetResourceTypePhoto data:imageData options:nil];
                request.creationDate = [NSDate date];
            }
        } completionHandler:^(BOOL success, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    NSLog(@"保存照片成功");
                    [WHToast showSuccessWithMessage:@"图片保存成功"
                                           duration:2
                                      finishHandler:^{}];
                } else if (error) {
                    [WHToast showErrorWithMessage:@"保存保存失败"
                                         duration:2
                                    finishHandler:^{}];
                    NSLog(@"保存照片出错:%@",error.localizedDescription);
                }
            });
        }];
    }else{
        NSLog(@"GKPhotoBrowser * 为空");
    }
}
/// 获取当前 UIViewController
+(UIViewController *)getCurrentViewController{
    UIWindow *window = getMainWindow();
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = UIApplication.sharedApplication.windows;
        for(UIWindow *tempWindow in windows){
            if (tempWindow.windowLevel == UIWindowLevelNormal){
                window = tempWindow;
                break;
            }
        }
    }
      
    UIView *frontView = [window.subviews objectAtIndex:0];
    UIResponder *nextResponder = [frontView nextResponder];
      
    return [nextResponder isKindOfClass:UIViewController.class] ? (UIViewController *)nextResponder : window.rootViewController;
}
/// 用block来代替selector
SEL selectorBlocks(void (^block)(id _Nullable weakSelf, id _Nullable arg),
                   id target){
    if (!block) {
        [NSException raise:@"block can not be nil"
                    format:@"%@ selectorBlock error", target];
    }
    NSString *selName = [NSString stringWithFormat:@"selector_%p:", block];
    SEL sel = NSSelectorFromString(selName);
    class_addMethod([target class],
                    sel,
                    (IMP)selectorImp,
                    "v@:@");
    objc_setAssociatedObject(target,
                             sel,
                             block,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    return sel;
}

static void selectorImp(id self,
                        SEL _cmd,
                        id arg) {
    callback block = objc_getAssociatedObject(self, _cmd);
    __weak typeof(self) weakSelf = self;
    if (block) {
        block(weakSelf, arg);
    }
}
/// 获取当前设备可用内存
+(double)availableMemory{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return ((vm_page_size * vmStats.free_count)/1024.0)/1024.0;
}
/// 获取当前任务所占用内存
+(double)usedMemory{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }return taskInfo.resident_size/1024.0/1024.0;
}
/// 加入键盘通知的监听者
-(void)keyboard{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrameNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeFrameNotification:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}
//键盘 弹出 和 收回 走这个方法
-(void)keyboardWillChangeFrameNotification:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat KeyboardOffsetY = beginFrame.origin.y - endFrame.origin.y;// 正则抬起 ，负值下降
    NSLog(@"KeyboardOffsetY = %f",KeyboardOffsetY);
 
    if (KeyboardOffsetY > 0) {
        NSLog(@"键盘抬起");
    }else if(KeyboardOffsetY < 0){
        NSLog(@"键盘收回");
    }else{
        NSLog(@"键盘");
    }
}

-(void)keyboardDidChangeFrameNotification:(NSNotification *)notification{

}
/// 停止刷新【可能还有数据的情况，状态为：MJRefreshStateIdle】
-(void)endRefreshing:(UIScrollView *_Nonnull)targetScrollView{
    if ([targetScrollView isKindOfClass:UITableView.class]) {
        UITableView *tableView = (UITableView *)targetScrollView;
        [tableView reloadData];
    }else if ([targetScrollView isKindOfClass:UICollectionView.class]){
        UICollectionView *collectionView = (UICollectionView *)targetScrollView;
        [collectionView reloadData];
    }else{}
    
    [targetScrollView tab_endAnimation];//里面实现了 [self.collectionView reloadData];
    if (targetScrollView.mj_header.refreshing) {
        [targetScrollView.mj_header endRefreshing];// 结束刷新
    }
    if (targetScrollView.mj_footer.refreshing) {
        [targetScrollView.mj_footer endRefreshing];// 结束刷新
    }else{
        [targetScrollView.mj_footer resetNoMoreData];// 结束刷新
    }
}
/// 停止刷新【没有数据的情况，状态为：MJRefreshStateNoMoreData】
-(void)endRefreshingWithNoMoreData:(UIScrollView *_Nonnull)targetScrollView{
    if ([targetScrollView isKindOfClass:UITableView.class]) {
        UITableView *tableView = (UITableView *)targetScrollView;
        [tableView reloadData];
    }else if ([targetScrollView isKindOfClass:UICollectionView.class]){
        UICollectionView *collectionView = (UICollectionView *)targetScrollView;
        [collectionView reloadData];
    }else{}
    
    [targetScrollView tab_endAnimation];//里面实现了 [self.collectionView reloadData];
    if (targetScrollView.mj_header.refreshing) {
        [targetScrollView.mj_header endRefreshing];// 结束刷新
    }
    if (targetScrollView.mj_footer.refreshing) {
        [targetScrollView.mj_footer endRefreshingWithNoMoreData];// 结束刷新
    }
}
/// 转换为NSData
+(NSData *_Nullable)transformToData:(id _Nullable)object{
    if ([object isKindOfClass:NSString.class]) {
        NSString *string = (NSString *)object;
        return [string dataUsingEncoding:NSUTF8StringEncoding];
    }else if ([object isKindOfClass:NSArray.class]){
        NSArray *array = (NSArray *)object;
        NSError *err = nil;
        /*
         *  object 要归档的对象图的根
         *  requiresSecureCoding 一个布尔值，指示是否所有编码对象都必须符合 NSSecureCoding
         *  error 返回时，是编码时发生的错误，或者nil没有发生错误
         */
        if (@available(iOS 11.0, *)) {
            return [NSKeyedArchiver archivedDataWithRootObject:array
                                         requiringSecureCoding:YES
                                                         error:&err];
        } else {
            SuppressWdeprecatedDeclarationsWarning(return [NSKeyedArchiver archivedDataWithRootObject:array]);
        }
    }else if ([object isKindOfClass:NSDictionary.class]){
        NSDictionary *dictionary = (NSDictionary *)object;
        NSError *err = nil;
        return [NSJSONSerialization dataWithJSONObject:dictionary
                                               options:NSJSONWritingPrettyPrinted
                                                 error:&err];
    }else{
        return nil;
    }
}
/// NSInvocation的使用，方法多参数传递
/// @param methodName 方法名
/// @param target 靶点，方法在哪里
/// @param paramarrays 参数数组
+(void)methodName:(NSString *_Nonnull)methodName
           target:(id _Nonnull)target
      paramarrays:(NSArray *_Nullable)paramarrays{
    SEL selector = NSSelectorFromString(methodName);
    /*
     NSMethodSignature有两个常用的只读属性
     a. numberOfArguments:方法参数的个数
     b. methodReturnLength:方法返回值类型的长度，大于0表示有返回值
     **/
    NSMethodSignature *signature = [target methodSignatureForSelector:selector];
    //或使用下面这种方式
    //NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:selector];
    
    if (!signature) {
        //传入的方法不存在 就抛异常
        NSString *info = [NSString stringWithFormat:@"-[%@ %@]:unrecognized selector sent to instance",[self class],NSStringFromSelector(selector)];
        @throw [[NSException alloc] initWithName:@"方法不存在"
                                          reason:info
                                        userInfo:nil];
    }
    
    //只能使用该方法来创建，不能使用alloc init
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = target;
    invocation.selector = selector;
    /*
     注意:
     1、下标从2开始，因为0、1已经被target与selector占用
     2、设置参数，必须传递参数的地址，不能直接传值
     **/
    for (int i = 2; i < paramarrays.count + 2; i++) {
        NSLog(@"i = %d",i);
        id d = paramarrays[i - 2];
        [invocation setArgument:&d atIndex:i];
    }
    // 执行方法
    [invocation invoke];
    //可以在invoke方法前添加，也可以在invoke方法后添加
    //通过方法签名的methodReturnLength判断是否有返回值
    if (signature.methodReturnLength > 0) {
        NSString *result = nil;
        [invocation getReturnValue:&result];
        NSLog(@"result = %@",result);
    }
}
#pragma mark —— @property(nonatomic,strong)NSIndexPath *_indexPath;
-(NSIndexPath *)_indexPath{
    return objc_getAssociatedObject(self, NSObject_Extras_indexPath);
}

-(void)set_indexPath:(NSIndexPath *)_indexPath{
    objc_setAssociatedObject(self,
                             NSObject_Extras_indexPath,
                             _indexPath,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)NSInteger _currentPage;
-(NSInteger)_currentPage{
    return [objc_getAssociatedObject(self, NSObject_Extras_currentPage) integerValue];
}

-(void)set_currentPage:(NSInteger)_currentPage{
    objc_setAssociatedObject(self,
                             NSObject_Extras_currentPage,
                             [NSNumber numberWithInteger:_currentPage],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

