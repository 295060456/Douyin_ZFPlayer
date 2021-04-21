//
//  UIImageView+GIF.h
//  UIImage+GIF
//
//  Created by JieLee on 15/3/17.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (GIF)
/**
 *  输入路径，返回一个 UIImageView
 *
 *  @param file  路径
 *  @param frame frame
 *
 *  @return      UIImageView
 */
+ (UIImageView *)imageViewWithGIFFile:(NSString *)file
                                frame:(CGRect)frame;

@end
