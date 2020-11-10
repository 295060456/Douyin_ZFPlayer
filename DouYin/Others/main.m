//
//  main.m
//  DouYin
//
//  Created by Jobs on 2020/9/21.
//

#import <UIKit/UIKit.h>
#import "DouYinAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([DouYinAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
