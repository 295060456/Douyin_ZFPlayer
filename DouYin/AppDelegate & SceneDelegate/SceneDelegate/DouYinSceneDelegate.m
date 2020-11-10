//
//  DouYinSceneDelegate.m
//  DouYin
//
//  Created by Jobs on 2020/9/21.
//

#import "DouYinSceneDelegate.h"
#import "DouYinAppDelegate.h"

API_AVAILABLE(ios(13.0))

@interface DouYinSceneDelegate ()

@end

@implementation DouYinSceneDelegate

static DouYinSceneDelegate *static_sceneDelegate = nil;
+(instancetype)sharedInstance{
    @synchronized(self){
        if (!static_sceneDelegate) {
            static_sceneDelegate = DouYinSceneDelegate.new;
        }
    }return static_sceneDelegate;
}

-(instancetype)init{
    if (self = [super init]) {
        static_sceneDelegate = self;
    }return self;
}

- (void)scene:(UIScene *)scene
willConnectToSession:(UISceneSession *)session
      options:(UISceneConnectionOptions *)connectionOptions {
    //在这里手动创建新的window
    if (@available(iOS 13.0, *)) {
        self.windowScene = (UIWindowScene *)scene;
        self.window.alpha = 1;
    }
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}

- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}

- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}

- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}

- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.

    // Save changes in the application's managed object context when the application transitions to the background.
    [(DouYinAppDelegate *)UIApplication.sharedApplication.delegate saveContext];
}
#pragma mark —— lazyLoad
-(UIWindow *)window{
    [_window setRootViewController:DouYinAppDelegate.sharedInstance.tabbarVC];
    [_window makeKeyAndVisible];
    return _window;
}
@end
