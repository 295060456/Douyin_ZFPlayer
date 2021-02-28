//
//  UIFont+Extras.m
//  UBallLive
//
//  Created by Jobs on 2020/11/4.
//

#import "UIFont+Extras.h"

@implementation UIFont (Extras)

+(void)getAvailableFont{
    NSMutableArray <NSArray *>*fontNamesMutArr = NSMutableArray.array;
    for (NSString *familyName in UIFont.familyNames) {
        NSArray *names = [UIFont fontNamesForFamilyName:familyName];
        [fontNamesMutArr addObjectsFromArray:names];
    }
    NSLog(@"Font Names = %@", fontNamesMutArr);
}

@end
