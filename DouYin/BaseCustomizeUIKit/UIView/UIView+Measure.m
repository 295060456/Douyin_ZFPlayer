//
//  UIView+Measure.m
//  My_BaseProj
//
//  Created by Jobs on 2020/9/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UIView+Measure.h"

@implementation UIView (Measure)

-(CGFloat)top {
    return CGRectGetMinY(self.frame);
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

-(void)setMaxX:(CGFloat)maxX{
    
}

-(CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}

-(void)setMaxY:(CGFloat)maxY{
    
}

-(CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}

-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(CGFloat)centerX{
    return self.center.x;
}

-(void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

-(CGFloat)centerY{
    return self.center.y;
}

-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(CGFloat)width{
    return self.frame.size.width;
}

-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(CGSize)size{
    return self.frame.size;
}

-(void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

-(CGPoint)origin{
    return self.frame.origin;
}

-(CGFloat)getX{
    return CGRectGetMaxX(self.frame);
}

-(CGFloat)left {
    return self.frame.origin.x;
}

-(CGFloat)getY{
    return CGRectGetMaxY(self.frame);
}

-(CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

-(void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

-(CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

-(void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}



@end
