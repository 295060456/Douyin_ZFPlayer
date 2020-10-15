//
//  UIViewController+TZLocationManager.h
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import <UIKit/UIKit.h>
#import "TZImagePickerController.h"

///分别对应 TZImagePickerController 的五种初始化方法
typedef enum : NSInteger {
    TZLocationManagerType_1,//startLocation
    TZLocationManagerType_2,//startLocationWithSuccessBlock/failureBlock
    TZLocationManagerType_3,//startLocationWithGeocoderBlock
    TZLocationManagerType_4,//startLocationWithSuccessBlock/failureBlock/geocoderBlock
} TZLocationManagerType;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (TZLocationManager)

@property(nonatomic,assign)TZLocationManagerType tzLocationManagerType;

-(void)Location:(TZLocationManagerType)tzLocationManagerType
          block:(MMDataBlock)block;

@end

NS_ASSUME_NONNULL_END
