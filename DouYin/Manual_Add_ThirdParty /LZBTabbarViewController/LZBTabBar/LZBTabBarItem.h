//
//  LZBTabBarItem.h
//  My_BaseProj
//
//  Created by Jobs on 2020/8/9.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lottie.h"

NS_ASSUME_NONNULL_BEGIN

@interface LZBTabBarItem : UIControl
/**
 *  TabBar单个item的高度
 */
@property(nonatomic,assign)CGFloat itemHeight;

#pragma mark - config 文字样式
/**
 *  文字内容
 */
@property(nonatomic,copy)NSString *title;
/**
 *  文字偏移量
 */
@property(nonatomic,assign)UIOffset titleOffest;
/**
 *  未选中文字属性描述：颜色、字体
 */
@property(nonatomic,strong)NSDictionary *unselectTitleAttributes;
/**
 *  选中文字属性描述：颜色、字体
 */
@property(nonatomic,strong)NSDictionary *selectTitleAttributes;

#pragma mark - config 图片样式
/**
 *  选中图片
 */
@property(nonatomic,strong)UIImage *selectImage;
/**
 *  未选中图片
 */
@property(nonatomic,strong)UIImage *unSelectImage;
/**
 *  图片偏移量
 */
@property(nonatomic,assign)UIOffset imageOffest;
/**
 设置选中和未选中的图片

 @param selectImage 选中图片
 @param unSelectImage 未选中图片
 */
- (void)setSelectImage:(UIImage *)selectImage
         unselectImage:(UIImage *)unSelectImage;

#pragma mark - config 背景View图片样式
/**
 *  选中背景图片
 */
@property(nonatomic,strong)UIImage *selectBackgroundImage;
/**
 *  未选中背景图片
 */
@property(nonatomic,strong)UIImage *unselectBackgroundImage;
/**
 设置背景选中和未选中的图片
 
 @param selectedImage 选中图片
 @param unselectedImage 未选中图片
 */
- (void)setBackgroundSelectedImage:(UIImage *)selectedImage
                   unselectedImage:(UIImage *)unselectedImage;
/**
 * 手势
*/
@property(nonatomic,strong)UITapGestureRecognizer *tagGR;//敲击
@property(nonatomic,strong)UILongPressGestureRecognizer *longPressGR;//长按

@property(nonatomic,strong)NSMutableArray<NSString *> *lottieJsonNameStrMutArr;
@property(nonatomic,assign)NSInteger tagger;
@property(nonatomic,strong)LOTAnimationView *animationView;

-(void)gestureRecognizerLZBTabBarItemBlock:(TwoDataBlock)LZBTabBarItemGestureRecognizerBlock;

@end

NS_ASSUME_NONNULL_END
