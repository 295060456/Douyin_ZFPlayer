//
//  BaseNavigationBar.m
//  UBallLive
//
//  Created by Jobs on 2020/10/21.
//

#import "BaseNavigationBar.h"

@interface BaseNavigationBar ()

@property(nonatomic,copy)MKDataBlock baseNavigationBarBlock;

@end

@implementation BaseNavigationBar

- (instancetype)init{
    if (self = [super init]) {
        self.translucent = YES;
    }return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if(@available(iOS 11.0, *)){
        CGFloat Y = isiPhoneX_series() ? 44 : 20;
        CGFloat width = self.bounds.size.width;
        Class bgClass = NSClassFromString(@"_UIBarBackground");
        Class cvClass = NSClassFromString(@"_UINavigationBarContentView");
        for(UIView *view in self.subviews){
            if([view isKindOfClass:bgClass]){
                view.frame = self.bounds;
            }

            if([view isKindOfClass:cvClass]){
                view.frame = CGRectMake(0, Y, width, 44);
            }
        }
    }
}

-(void)actionBlockBaseNavigationBar:(MKDataBlock)baseNavigationBarBlock{
    self.baseNavigationBarBlock = baseNavigationBarBlock;
}

@end
