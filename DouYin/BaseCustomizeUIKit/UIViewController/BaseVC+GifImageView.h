//
//  BaseVC+GifImageView.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC (GifImageView)

#pragma mark —— BaseVC+GifImageView
@property(nonatomic,strong)UIImageView *gifImageView;
@property(nonatomic,strong)NSString *path;
@property(nonatomic,strong)NSData *data;
@property(nonatomic,strong)UIImage *image;

@end

NS_ASSUME_NONNULL_END
