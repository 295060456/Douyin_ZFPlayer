//
//  EmptyView.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/31.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "EmptyView.h"

@implementation EmptyView

+ (instancetype)diyEmptyView{
    return [EmptyView emptyViewWithImageStr:@"noData"
                                   titleStr:@"暂无数据"
                                  detailStr:@"请稍后再试!"];
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

- (void)prepare{
    [super prepare];
    self.autoShowEmptyView = NO; //如果想要DemoEmptyView的效果都不是自动显隐的，这里统一设置为NO，初始化时就不必再一一去写了
    self.titleLabTextColor = RGBCOLOR(180, 30, 50);
    self.titleLabFont = [UIFont systemFontOfSize:18];
    self.detailLabTextColor = RGBCOLOR(80, 80, 80);
}

@end
