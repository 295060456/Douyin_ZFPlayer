//
//  BaseVC+TZLocationManager.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/12.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

///分别对应 TZImagePickerController 的五种初始化方法
typedef enum : NSInteger {
    TZLocationManagerType_1,//startLocation
    TZLocationManagerType_2,//startLocationWithSuccessBlock/failureBlock
    TZLocationManagerType_3,//startLocationWithGeocoderBlock
    TZLocationManagerType_4,//startLocationWithSuccessBlock/failureBlock/geocoderBlock
} TZLocationManagerType;

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC (TZLocationManager)

@property(nonatomic,assign)TZLocationManagerType tzLocationManagerType;

-(void)Location:(TZLocationManagerType)tzLocationManagerType
          block:(MMDataBlock)block;

@end

NS_ASSUME_NONNULL_END
