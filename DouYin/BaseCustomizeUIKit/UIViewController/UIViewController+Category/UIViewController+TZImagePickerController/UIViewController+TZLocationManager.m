//
//  UIViewController+TZLocationManager.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "UIViewController+TZLocationManager.h"

@implementation UIViewController (TZLocationManager)

static char *BaseVC_TZLocationManager_tzLocationManagerType = "BaseVC_TZLocationManager_tzLocationManagerType";
@dynamic tzLocationManagerType;

-(void)Location:(TZLocationManagerType)tzLocationManagerType
          block:(MMDataBlock)block{
    self.tzLocationManagerType = tzLocationManagerType;
    switch (self.tzLocationManagerType) {
        case TZLocationManagerType_1:{
            [[TZLocationManager manager] startLocation];
        }break;
        case TZLocationManagerType_2:{
            [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *t) {
                if (block) {
                    block(@1,
                          t);
                }
            } failureBlock:^(NSError *error) {
                if (block) {
                    block(@1,
                          error);
                }
            }];
        }break;
        case TZLocationManagerType_3:{
            [[TZLocationManager manager] startLocationWithGeocoderBlock:^(NSArray *geocoderArray) {
                if (block) {
                    block(@1,
                          geocoderArray);
                }
            }];
        }break;
        case TZLocationManagerType_4:{
            [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *t) {
                if (block) {
                    block(@1,
                          t);
                }
            } failureBlock:^(NSError *error) {
                if (block) {
                    block(@1,
                          error);
                }
            } geocoderBlock:^(NSArray *geocoderArray) {
                if (block) {
                    block(@1,
                          geocoderArray);
                }
            }];
        }break;
        default:
            break;
    }
}
#pragma mark SET | GET
#pragma mark —— @property(nonatomic,assign)TZLocationManagerType tzLocationManagerType;
-(TZImagePickerControllerType)tzImagePickerControllerType{
    return [objc_getAssociatedObject(self, BaseVC_TZLocationManager_tzLocationManagerType) integerValue];
}

-(void)setTzImagePickerControllerType:(TZImagePickerControllerType)tzImagePickerControllerType{
    objc_setAssociatedObject(self,
                             BaseVC_TZLocationManager_tzLocationManagerType,
                             [NSNumber numberWithInteger:tzImagePickerControllerType],
                             OBJC_ASSOCIATION_ASSIGN);
}


@end
