//
//  BaseVC+TZLocationManager.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/12.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC+TZLocationManager.h"

@implementation BaseVC (TZLocationManager)

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
