//
//  UIViewController+GifImageView.h
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (GifImageView)

#pragma mark —— BaseVC+GifImageView
@property(nonatomic,strong)UIImageView *gifImageView;
@property(nonatomic,strong)NSString *path;
@property(nonatomic,strong)NSData *data;
@property(nonatomic,strong)UIImage *image;

@end

NS_ASSUME_NONNULL_END
