//
//  AppDelegate.h
//  DouYin
//
//  Created by Jobs on 2020/9/21.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#ifdef DEBUG
#import <DoraemonKit/DoraemonManager.h>
#endif

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(readonly,strong)NSPersistentCloudKitContainer *persistentContainer;
@property(nonatomic,assign)BOOL allowOrentitaionRotation;
@property(nonatomic,strong)TabbarVC *tabbarVC;
@property(nonatomic,strong)UIWindow *window;//仅仅为了iOS 13 版本向下兼容而存在

+(AppDelegate *)sharedInstance;

-(void)saveContext;

@end

