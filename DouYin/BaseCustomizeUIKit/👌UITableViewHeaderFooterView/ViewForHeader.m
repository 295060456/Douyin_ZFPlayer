//
//  ViewForHeader.m
//  ManVideo
//
//  Created by 刘赓 on 2019/9/26.
//  Copyright © 2019 Josee. All rights reserved.
//

#import "ViewForHeader.h"

@interface ViewForHeader()

@property(nonatomic,copy)MKDataBlock block;

@end

@implementation ViewForHeader

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
                               withData:(id)data{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
    }return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.block) {
        self.block(@1);
    }
}

-(void)actionBlock:(MKDataBlock)block{
    _block = block;
}

#pragma mark —— lazyLoad


@end
