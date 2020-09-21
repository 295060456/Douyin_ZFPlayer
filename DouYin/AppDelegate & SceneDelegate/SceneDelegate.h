//
//  SceneDelegate.h
//  DouYin
//
//  Created by Jobs on 2020/9/21.
//

#import <UIKit/UIKit.h>
#import "CustomSYSUITabBarController.h"

@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>

@property(nonatomic,strong)UIWindow *window;
@property(nonatomic,strong)UIWindowScene *windowScene;
@property(nonatomic,strong)CustomSYSUITabBarController *customSYSUITabBarController;
@property(nonatomic,strong)UINavigationController *navigationController;

+ (SceneDelegate *)sharedInstance;

@end

