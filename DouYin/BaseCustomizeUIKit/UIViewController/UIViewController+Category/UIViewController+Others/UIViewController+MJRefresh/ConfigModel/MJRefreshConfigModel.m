//
//  MJRefreshConfig.m
//  DouYin
//
//  Created by Jobs on 2020/12/11.
//

#import "MJRefreshConfigModel.h"

@implementation MJRefreshConfigModel

#pragma mark —— lazyLoad 默认配置
-(UIFont *)font{
    if (!_font) {
        _font = [UIFont systemFontOfSize:17
                                  weight:UIFontWeightLight];
    }return _font;
}

-(UIColor *)textColor{
    if (!_textColor) {
        _textColor = KLightGrayColor;
    }return _textColor;
}

-(NSString *)stateIdleTitle{
    if (!_stateIdleTitle) {
        _stateIdleTitle = @"普通闲置状态";
    }return _stateIdleTitle;
}

-(NSString *)pullingTitle{
    if (!_pullingTitle) {
        _pullingTitle = @"松开就可以进行刷新的状态";
    }return _pullingTitle;
}

-(NSString *)refreshingTitle{
    if (!_refreshingTitle) {
        _refreshingTitle = @"正在刷新中的状态";
    }return _refreshingTitle;
}

-(NSString *)willRefreshTitle{
    if (!_willRefreshTitle) {
        _willRefreshTitle = @"即将刷新的状态";
    }return _willRefreshTitle;
}

-(NSString *)noMoreDataTitle{
    if (!_noMoreDataTitle) {
        _noMoreDataTitle = @"所有数据加载完毕，没有更多的数据了";
    }return _noMoreDataTitle;
}

-(NSMutableArray<UIImage *> *)stateIdlePicsMutArr{
    if (!_stateIdlePicsMutArr) {
        _stateIdlePicsMutArr = NSMutableArray.array;
        [_stateIdlePicsMutArr addObject:KBuddleIMG(@"⚽️PicResource",@"刷新", nil, @"header.png")];
    }return _stateIdlePicsMutArr;
}

-(NSMutableArray<UIImage *> *)pullingPicsMutArr{
    if (!_pullingPicsMutArr) {
        _pullingPicsMutArr = NSMutableArray.array;
        [_pullingPicsMutArr addObject:KBuddleIMG(@"⚽️PicResource",@"刷新", nil, @"Indeterminate Spinner - Small.png")];
    }return _pullingPicsMutArr;
}

-(NSMutableArray<UIImage *> *)refreshingPicsMutArr{
    if (!_refreshingPicsMutArr) {
        _refreshingPicsMutArr = NSMutableArray.array;
        
        for (int i = 1; i <= 55; i++) {
            NSString *str = [NSString stringWithFormat:@"gif_header_%d",i];
            str = [str stringByAppendingString:@".png"];
            [_refreshingPicsMutArr addObject:KBuddleIMG(@"⚽️PicResource",
                                                        @"刷新",
                                                        @"刷新图片 166 * 166 @3x 100 * 100 @2x",
                                                        str)];
        }
        
    }return _refreshingPicsMutArr;
}

-(NSMutableArray<UIImage *> *)willRefreshPicsMutArr{
    if (!_willRefreshPicsMutArr) {
        _willRefreshPicsMutArr = NSMutableArray.array;
        
        for (int i = 1; i <= 55; i++) {
            NSString *str = [NSString stringWithFormat:@"gif_header_%d",i];
            str = [str stringByAppendingString:@".png"];
            [_willRefreshPicsMutArr addObject:KBuddleIMG(@"⚽️PicResource",
                                                         @"刷新",
                                                         @"刷新图片 166 * 166 @3x 100 * 100 @2x",
                                                         str)];
        }
        
    }return _willRefreshPicsMutArr;
}

-(NSMutableArray<UIImage *> *)noMoreDataPicsMutArr{
    if (!_noMoreDataPicsMutArr) {
        _noMoreDataPicsMutArr = NSMutableArray.array;
        
        for (int i = 1; i <= 55; i++) {
            NSString *str = [NSString stringWithFormat:@"gif_header_%d",i];
            str = [str stringByAppendingString:@".png"];
            [_noMoreDataPicsMutArr addObject:KBuddleIMG(@"⚽️PicResource",
                                                        @"刷新",
                                                        @"刷新图片 166 * 166 @3x 100 * 100 @2x",
                                                        str)];
        }
        
    }return _noMoreDataPicsMutArr;
}

-(NSString *)jsonLottiefilePaths{
    if (!_jsonLottiefilePaths) {
        _jsonLottiefilePaths = pathForBuddleIMG(nil,
                                                @"JsonRes",
                                                nil,
                                                @"下拉刷新.json");
    }return _jsonLottiefilePaths;
}

@end
