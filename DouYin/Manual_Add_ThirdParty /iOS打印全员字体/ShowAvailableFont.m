//
//  ShowAvailableFont.m
//  Shooting
//
//  Created by Jobs on 2020/8/17.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ShowAvailableFont.h"

@interface ShowAvailableFont()

@property(nonatomic,strong)NSMutableArray *fontNamesMutArr;

@end

@implementation ShowAvailableFont

static ShowAvailableFont *static_showAvailableFont = nil;
+(ShowAvailableFont *)sharedInstance{
    @synchronized(self){
        if (!static_showAvailableFont) {
            static_showAvailableFont = ShowAvailableFont.new;
        }
    }return static_showAvailableFont;
}

-(instancetype)init{
    if (self = [super init]) {
        static_showAvailableFont = self;
    }return self;
}

-(void)getAvailableFont{
    for (NSString *familyName in UIFont.familyNames) {
    NSArray *names = [UIFont fontNamesForFamilyName:familyName];
    [self.fontNamesMutArr addObjectsFromArray:names];
    }
    NSLog(@"Font Names = %@", self.fontNamesMutArr);
}

#pragma mark —— lazyLoad
-(NSMutableArray *)fontNamesMutArr{
    if (!_fontNamesMutArr) {
        _fontNamesMutArr = NSMutableArray.array;
    }return _fontNamesMutArr;
}

@end
