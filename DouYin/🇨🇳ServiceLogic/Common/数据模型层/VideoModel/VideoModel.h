//
//  VideoModel.h
//  DouYin
//
//  Created by Jobs on 2020/9/24.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoModel_Core : NSObject

@property(nonatomic,strong)NSString *isPraise;
@property(nonatomic,strong)NSString *authorId;
@property(nonatomic,strong)NSString *videoSort;
@property(nonatomic,strong)NSString *headImage;
@property(nonatomic,strong)NSString *praiseNum;
@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSString *videoImg;//图
@property(nonatomic,strong)NSString *videoId;
@property(nonatomic,strong)NSString *videoTitle;
@property(nonatomic,strong)NSString *videoSize;
@property(nonatomic,strong)NSString *isVip;
@property(nonatomic,strong)NSString *commentNum;
@property(nonatomic,strong)NSString *isAttention;
@property(nonatomic,strong)NSString *videoIdcUrl;//视频地址
@property(nonatomic,strong)NSString *areSelf;
@property(nonatomic,strong)NSString *publishTime;
@property(nonatomic,strong)NSString *playNum;
@property(nonatomic,strong)NSString *videoTime;

@end

@interface VideoModel : BaseModel

@property(nonatomic,strong)NSMutableArray <VideoModel_Core *>*listMutArr;

@end


NS_ASSUME_NONNULL_END

