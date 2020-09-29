//
//  UITableViewCell+WhiteArrows.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/26.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UITableViewCell+WhiteArrows.h"

@implementation UITableViewCell (WhiteArrows)

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    // 全局替换右侧箭头
    if (self.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        UIImageView *i = [[UIImageView alloc] initWithImage:KIMG(@"WhiteRightArrow")];
        self.accessoryView = i;
    }
}

@end
