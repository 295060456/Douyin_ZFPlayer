//
//  URLManagerModel.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "URLManagerModel.h"

@implementation URLManagerModel

#pragma mark —— 默认配置
-(NSNumber *)pageSize{
    if (!_pageSize) {
        _pageSize = @(3);
    }return _pageSize;
}

-(NSNumber *)currentPageNum{
    if (!_currentPageNum) {
        _currentPageNum = @(0);
    }return _currentPageNum;
}

@end
