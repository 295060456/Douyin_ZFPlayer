//
//  MKGPUImageView.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/12.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKGPUImageView.h"

@interface MKGPUImageView ()

@property(nonatomic,copy)MKDataBlock MKGPUImageViewBlock;

@end

@implementation MKGPUImageView

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    if (self.MKGPUImageViewBlock) {
        self.MKGPUImageViewBlock(@1);
    }
}

-(void)actionMKGPUImageViewBlock:(MKDataBlock)MKGPUImageViewBlock{
    self.MKGPUImageViewBlock = MKGPUImageViewBlock;
}

@end
