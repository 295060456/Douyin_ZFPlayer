//
//  RBCLikeButton.h
//  EmitterAnimation
//
//  Created by 刘庆贺 on 2019/3/13.
//  Copyright © 2019 lmh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    RBCLikeButtonTypeImageleft, //图片在左,label在右
    RBCLikeButtonTypeImageTop  //图片在上,label在下
} RBCLikeButtonType;

typedef enum : NSUInteger {
    RBCLikeButtonStatusHadThumbs,        //已点赞
    RBCLikeButtonStatusNoneThumbs,       //未点赞
    RBCLikeButtonStatusThumbsing,        //正在点赞
    RBCLikeButtonStatusCancelThumbsing   //正在取消点赞
} RBCLikeButtonStatus;

@interface RBCLikeButton : UIButton

/** 点赞数 */
@property (nonatomic, assign) NSInteger thumpNum;

/** 按钮状态 */
//@property (nonatomic, assign) RBCLikeButtonStatus thumbStatus;

/** 恢复点赞 */
- (void)recoverLike;

/** 取消点赞 */
- (void)cancelLike;


/**
 初始化likeButton

 @param frame 尺寸,必须用frame布局,且不能为0
 @param type likeButton类型
 @return likeButton
 */
- (instancetype)initWithFrame:(CGRect)frame type:(RBCLikeButtonType)type;

/**
 设置点赞

 @param selected YES:设置为点赞状态 NO:设置为默认状态(非点赞状态)
 @param thumbNum 点赞数
 @param animation 是否需要动画
 */
- (void)setThumbWithSelected:(BOOL)selected thumbNum:(NSInteger)thumbNum animation:(BOOL)animation;

@end
