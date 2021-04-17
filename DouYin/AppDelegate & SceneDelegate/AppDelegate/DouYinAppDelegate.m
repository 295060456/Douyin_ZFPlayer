//
//  DouYinAppDelegate.m
//  DouYin
//
//  Created by Jobs on 2020/9/21.
//

#import "DouYinAppDelegate.h"
#import "DouYinAppDelegate+Func.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

@interface DouYinAppDelegate ()

@end

@implementation DouYinAppDelegate

static DouYinAppDelegate *static_appDelegate = nil;
+(instancetype)sharedInstance{
    @synchronized(self){
        if (!static_appDelegate) {
            static_appDelegate = DouYinAppDelegate.new;
        }
    }return static_appDelegate;
}

-(instancetype)init{
    if (self = [super init]) {
        static_appDelegate = self;
    }return self;
}
/// 在这里写支持的旋转方向，为了防止横屏方向，应用启动时候界面变为横屏模式
-(UIInterfaceOrientationMask)application:(UIApplication *)application
 supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    // 可以这么写
    if (self.allowOrentitaionRotation){
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#ifdef DEBUG
    [self testFunc];
#endif
    [[ZBLocalized sharedInstance] initLanguage];//放在tabbar前初始化
    [self makeTABAnimatedConfigure];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];//保持屏幕常亮
    /*
     * 禁止App系统文件夹document同步
     * 苹果要求：可重复产生的数据不得进行同步,什么叫做可重复数据？这里最好禁止，否则会影响上架，被拒！
     */
    [FileFolderHandleTool banSysDocSynchronization];
#ifdef DEBUG
    [self makeDoraemonManagerConfigure];//滴滴打车团队出的一款小工具
    [self makeNetworkingBitsMonitor];
    [UIFont getAvailableFont];//打印全员字体
#endif
    [self makeGKNavigationBarConfigure];//自定义导航栏
    [self makeReachabilityConfigure];//网络环境监测
    if (HDDeviceSystemVersion.floatValue < 13.0) {
        self.window.alpha = 1;
    }return YES;
}
//系统版本低于iOS13.0的设备
-(void)applicationDidEnterBackground:(UIApplication *)application{
    NSLog(@"---applicationDidEnterBackground----");//进入后台
}

//系统版本低于iOS13.0的设备
-(void)applicationDidBecomeActive:(UIApplication *)application{
    NSLog(@"---applicationDidBecomeActive----");//进入前台
}
#pragma mark - UISceneSession lifecycle
- (UISceneConfiguration *)application:(UIApplication *)application
configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession
                              options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application
didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}
#pragma mark - Core Data Saving support
- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
#pragma mark —— lazyLoad
//仅仅为了iOS 13 版本向下兼容而存在
-(UIWindow *)window{
    if (!_window) {
        _window = UIWindow.new;
        _window.frame = [UIScreen mainScreen].bounds;
        [_window setRootViewController:self.tabBarVC];
        [_window makeKeyAndVisible];
    }return _window;
}

-(TabbarVC *)tabBarVC{
    if (!_tabBarVC) {
        _tabBarVC = TabbarVC.new;
//        _tabBarVC.isOpenScrollTabbar = NO;
        _tabBarVC.myTabBar.offsetHeight = 5;
        [_tabBarVC.childMutArr addObject:childViewController_customStyle(ViewController_1.new,
                                                                         @"首页",
                                                                         KBuddleIMG(@"资源文件", @"TabbaritemImage", nil, @"community_selected"),
                                                                         KBuddleIMG(@"资源文件", @"TabbaritemImage", nil, @"community_unselected"),
                                                                         0,
                                                                         @"home_priase_animation",
                                                                         1)];
        
        [_tabBarVC.childMutArr addObject:childViewController_customStyle(ViewController_2.new,
                                                                         @"精彩生活",
                                                                         KBuddleIMG(@"资源文件", @"TabbaritemImage", nil, @"post_selected"),
                                                                         KBuddleIMG(@"资源文件", @"TabbaritemImage", nil, @"post_unselected"),
                                                                         30,
                                                                         @"green_lottie_tab_home",
                                                                         1)];
        
        [_tabBarVC.childMutArr addObject:childViewController_customStyle(ViewController_3.new,
                                                                         @"发现",
                                                                         KBuddleIMG(@"资源文件", @"TabbaritemImage", nil, @"My_selected"),
                                                                         KBuddleIMG(@"资源文件", @"TabbaritemImage", nil, @"My_unselected"),
                                                                         0,
                                                                         @"green_lottie_tab_mine",
                                                                         1)];
    }return _tabBarVC;
}
/// Core Data stack
@synthesize persistentContainer = _persistentContainer;
- (NSPersistentCloudKitContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentCloudKitContainer alloc] initWithName:@"DouYin"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }return _persistentContainer;
}

@end

#pragma clang diagnostic pop
