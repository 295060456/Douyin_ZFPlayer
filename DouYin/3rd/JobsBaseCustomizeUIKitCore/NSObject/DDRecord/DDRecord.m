//
//  DDMutableArray.m
//  DouDong-II
//
//  Created by Jobs on 2021/6/12.
//

#import "DDRecord.h"

@interface DDRecord ()

@end

@implementation DDRecord

static DDRecord *record = nil;
+(instancetype)sharedInstance{
    @synchronized(self){
        if (!record) {
            record = DDRecord.new;
        }
    }return record;
}

-(instancetype)init{
    if (self = [super init]) {
        record = self;
    }return self;
}
#pragma mark —— lazyLoad
-(NSMutableArray *)recordMutArr{
    if (!_recordMutArr) {
        _recordMutArr = NSMutableArray.array;
    }return _recordMutArr;
}

-(NSMutableDictionary *)recordMutDic{
    if (!_recordMutDic) {
        _recordMutDic = NSMutableDictionary.dictionary;
    }return _recordMutDic;
}

-(NSMutableSet *)recordMutSet{
    if (!_recordMutSet) {
        _recordMutSet = NSMutableSet.set;
    }return _recordMutSet;
}

-(NSMutableString *)recordMutString{
    if (!_recordMutString) {
        _recordMutString = NSMutableString.string;
    }return _recordMutString;
}

-(NSMutableData *)recordMutData{
    if (!_recordMutData) {
        _recordMutData = NSMutableData.data;
    }return _recordMutData;
}

@end
