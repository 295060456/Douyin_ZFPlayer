//
//  EmptyView.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/31.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "EmptyView.h"

@implementation EmptyView

+ (instancetype)diyEmptyViewWithTitle:(NSString *_Nullable)title{
    if ([NSString isNullString:title]) {
        title = @"快来将我填满吧";
    }
    return [EmptyView emptyViewWithImageStr:@"暂无数据"
                                   titleStr:title
                                  detailStr:@""];
}

+ (instancetype)diyEmptyActionViewWithTarget:(id)target
                                      action:(SEL)action{
    return [EmptyView emptyActionViewWithImageStr:@"noNetwork"
                                         titleStr:@"无网络连接"
                                        detailStr:@"请检查你的网络连接是否正确!"
                                      btnTitleStr:@"重新加载"
                                           target:target
                                           action:action];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    self.autoShowEmptyView = NO; //如果想要DemoEmptyView的效果都不是自动显隐的，这里统一设置为NO，初始化时就不必再一一去写了
    self.titleLabFont = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
    
    UILabel *label = [self valueForKey:@"titleLabel"];
    UIColor *cor = [UIColor gradientCorDataMutArr:[NSMutableArray arrayWithArray:@[RGBCOLOR(247, 131, 97),RGBCOLOR(245, 75, 100)]]
                                       startPoint:CGPointZero
                                         endPoint:CGPointZero
                                           opaque:NO
                                  withTargetLabel:label];
    self.titleLabTextColor = cor;
}

- (void)prepare{
    [super prepare];
}

@end
