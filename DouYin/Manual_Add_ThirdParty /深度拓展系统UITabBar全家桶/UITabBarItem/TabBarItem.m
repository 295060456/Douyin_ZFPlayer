//
//  TabBarItem.m
//  TabbarItemLottie
//
//  Created by Jobs on 2020/10/14.
//

#import "TabBarItem.h"

@interface TabBarItem ()

@end

@implementation TabBarItem

-(instancetype)initWithConfig:(TabBarControllerConfig *)config{
    if (self = [super init]) {
        
        [self setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}
                            forState:UIControlStateNormal];
        [self setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blueColor]}
                            forState:UIControlStateSelected];
        
        self.image = [config.imageUnselected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.selectedImage = [config.imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.title = config.title;
    }return self;
}

@end
