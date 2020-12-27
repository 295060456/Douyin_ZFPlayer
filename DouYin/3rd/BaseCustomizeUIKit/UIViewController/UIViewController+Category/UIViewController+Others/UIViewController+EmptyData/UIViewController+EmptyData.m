//
//  UIViewController+EmptyData.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/17.
//

#import "UIViewController+EmptyData.h"

@implementation UIViewController (EmptyData)

-(void)ifEmptyData{
    [self.view ifEmptyData];
    self.view.tipsLab.text = [NSString stringWithFormat:@"%@\n%@",self.view.tipsTitle,ReuseIdentifier];
}

@end
